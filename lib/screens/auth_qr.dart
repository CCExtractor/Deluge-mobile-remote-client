import 'dart:io';

import 'package:deluge_client/database/dbmanager.dart';
import 'package:deluge_client/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deluge_client/api/apis.dart';
import 'package:deluge_client/state_ware_house/state_ware_house.dart';
import 'package:deluge_client/core/auth_valid.dart';

class auth_qr extends StatefulWidget {
  final bool tow_attachment;
  auth_qr({Key key, this.tow_attachment}) : super(key: key);
  @override
  _auth_qrState createState() => _auth_qrState(tow_attachment: tow_attachment);
}

class _auth_qrState extends State<auth_qr> {
  final bool tow_attachment;
  _auth_qrState({this.tow_attachment});
  //----------------------------------------------------------
  final DbbucketManager dbmanager = new DbbucketManager();

  bool has_deluge_pass = false;

  void add_in_db(String url, String qr_auth) {
    Bucket item = new Bucket(
      deluge_url: "https://" + url,
      has_deluge_pwrd: false.toString(),
      deluge_pwrd: "",
      is_reverse_proxied: true.toString(),
      username: "",
      password: "",
      via_qr: qr_auth,
    );
    dbmanager
        .insertbucket(item)
        .then((id) => {print('item Added to Db ${id}'),
      
        });
  }

  void set_auth_state() async {
    states.set_auth();
  }

//---------
//-
  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
      backgroundColor: Colors.black,
    );
  }

  int count = 0;
  void check_validity(String url, String auth_qr) async {
    auth_valid validity = await apis.auth_validity("https://" + url, "",
        false.toString(), true.toString(), "", "", auth_qr);

    if (validity.valid == 1) {
      controller.stopCamera();
      add_in_db(url, auth_qr);
      set_auth_state();

      !tow_attachment
          ? toastMessage("Successfully Authorized")
          : toastMessage("Successfully added");
      !tow_attachment
          ? Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => dashboard()))
          : Navigator.popUntil(context, (route) {
              return count++ == 1;
            });
    } else if (validity.valid == 0) {
      toastMessage("Credentials are wrong");
    } else if (validity.valid == -1) {
      toastMessage("Deluge is not responding, May be it is down");
    } else if (validity.valid == -11) {
      toastMessage("Deluge is not reachable");
    } else if (validity.valid == -2) {
      toastMessage("Seedbox authentification failed.");
    } else {
      toastMessage("Something goes wrong");
    }
  }

  // @override
  // void initState() {
  //   states.first_time_setup_selection();
  //   super.initState();
  // } //it will be fired from the auth screen on have qr button click

  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  // now no need to do this
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller.pauseCamera();
  //   }
  //   controller.resumeCamera();
  // }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  List<String> creds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Scan to setup",
            style: theme.app_bar_style,
          ),
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(241, 94, 90, 1.0),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.height - 250.0
                        : MediaQuery.of(context).size.height - 200.0,
                    child: _build_qr(context),
                  )),
            ],
          ),
          //--------------------------------------------------------
          //---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Color.fromRGBO(241, 94, 90, 1.0)),
                  ),
                  primary: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                  child: Text(
                    !tow_attachment
                        ? 'Scan to get started'
                        : 'Scan to Add account',
                    style: TextStyle(
                        color: theme.base_color,
                        fontSize: 18,
                        fontFamily: theme.font_family),
                  ),
                ),
                onPressed: () {
                  if (result != null) {
                    creds = (result.code.toString().split('\nP'));
                    check_validity(creds[0], creds[1].replaceFirst('\n', ''));
                  } else {
                    toastMessage("Qr code is invalid");
                  }
                  // if (url.text.length > 0) {
                  //   // check_validity(
                  //   //     url.text,
                  //   //     pass.text,
                  //   //     has_deluge_pass.toString(),
                  //   //     isreverse_proxied.toString(),
                  //   //     username.text,
                  //   //     seed_pass.text);
                  // } else {
                  //   toastMessage("Please enter location");
                  // }
                },
              ),
            ),
          )

          //---

          // this column belongs to this container
        ])));
  }

  //---------
  Widget _build_qr(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: theme.base_color,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    if (this.mounted) {
      setState(() {
        this.controller = controller;
      });
    }
    controller.scannedDataStream.listen((scanData) {
      if (this.mounted) {
        setState(() {
          result = scanData;
        });
      }
    });
  }
}
