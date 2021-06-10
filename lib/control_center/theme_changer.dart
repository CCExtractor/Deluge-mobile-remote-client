import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme_controller.dart';

class ThemeBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, Brightness brightness) builder;
  
  ThemeBuilder({this.builder});

  @override
  _ThemeBuilderState createState() => _ThemeBuilderState();

  static _ThemeBuilderState of(BuildContext context) {
    return context.findAncestorStateOfType();
  }
}

class _ThemeBuilderState extends State<ThemeBuilder> {
  Brightness extracted_current_theme;
  @override
  void initState() {
    super.initState();
    fetch_current_theme();

    
  }

  void fetch_current_theme() async {
    extracted_current_theme = await theme_controller.get_set_theme();
    if (mounted) {
      setState(() {
        
       
        theme_controller.brightness = extracted_current_theme;
      });
    }
  }

  void changeTheme() {
    setState(() {
      theme_controller.brightness =
          theme_controller.brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark;
    });
  }

  void set_theme(Brightness br) {
    theme_controller.brightness = br;
  }

  Brightness getCurrentTheme() {
    return theme_controller.brightness;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, theme_controller.brightness);
  }
}
