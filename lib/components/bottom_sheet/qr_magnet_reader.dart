import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:deluge_client/api/apis.dart';
import 'package:deluge_client/string/magnet_detect.dart';
import 'package:fluttertoast/fluttertoast.dart';

class magnet_qr_reader extends StatefulWidget {
  final VoidCallback refresh;
  final List<Cookie> cookie;
  //----------------------------------------
  final String url;
  final String is_reverse_proxied;
  final String seed_username;
  final String seed_pass;
  final String qr_auth;
  magnet_qr_reader(
      {Key key,
      @required this.cookie,
      @required this.refresh,
      @required this.url,
      @required this.is_reverse_proxied,
      @required this.seed_username,
      @required this.seed_pass,
      @required this.qr_auth})
      : super(key: key);

  @override
  _magnet_qr_readerState createState() => _magnet_qr_readerState(
      refresh: refresh,
      cookie: cookie,
      url: url,
      is_reverse_proxied: is_reverse_proxied,
      seed_username: seed_username,
      seed_pass: seed_pass,
      qr_auth: qr_auth);
}

class _magnet_qr_readerState extends State<magnet_qr_reader> {
  final VoidCallback refresh;
  final List<Cookie> cookie;
  //-------------------------------------
  final String url;
  final String is_reverse_proxied;
  final String seed_username;
  final String seed_pass;
  final String qr_auth;

  _magnet_qr_readerState(
      {this.cookie,
      this.refresh,
      this.is_reverse_proxied,
      this.seed_username,
      this.seed_pass,
      this.url,
      this.qr_auth});
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

  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
      backgroundColor: Colors.black,
    );
  }

  void add_torrent_by_magnet_uri(String link) async {
    
    if (magnet_detect.parse(link)) {
      apis.add_magnet(link, cookie, url, is_reverse_proxied, seed_username,
          seed_pass, qr_auth,context);

      // after adding file then it should refresh it self;
       

    
      Future.delayed(Duration(seconds: 1), () {
        refresh();
        Navigator.of(context).pop();
      });
      

    } else {
      toastMessage("Magnet Q.R is invalid");
      
    }
     //  // bottom sheet should get closed
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.only(
              topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0)),
        ),
        child: SafeArea(
            top: false,
            child: Container(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 300.0
                        : 150.0,
                    child: _build_qr(context),
                  )),
            ],
          ),
                Flexible(
                 
                    child: RaisedButton(
                        color: theme.base_color,
                        onPressed: () {
                          if (result != null) {
                            // print(result.code);
                            add_torrent_by_magnet_uri(result.code);
                            controller.stopCamera();
                            Navigator.of(context).pop();
                          } else {
                            //todo i need to add a message here
                            controller.stopCamera();
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          "read QR",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: theme.alert_box_font_size,
                              fontFamily: theme.font_family),
                        ))),
              ]),
            )));
  }

  //-----------------
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
