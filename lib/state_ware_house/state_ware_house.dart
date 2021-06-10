import 'package:shared_preferences/shared_preferences.dart';

class states {
  static void set_auth() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("is_auth", true);
  }

  static Future<bool> isFirstTime() async {
    SharedPreferences pf = await SharedPreferences.getInstance();
    var isFirstTime = pf.getBool('first_time');
    if (isFirstTime != null && !isFirstTime) {
      pf.setBool('first_time', false);
      return false;
    } else {
      pf.setBool('first_time', false);
      return true;
    }
  }

  static void first_time_setup_selection() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    isFirstTime().then((isFirstTime) {
      if (isFirstTime) {
        pref.setInt("selected_account", 1);
      } else {
        print("it is not first");
      }
    });
  }

  //--
  static Future<int> state_selected_account() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int t = pref.getInt("selected_account");
    return t;
  }

  static Future<int> state_all_selected_account() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int t = pref.getInt("all_selected_account_idx");
    return t;
  }

  static Future<bool> state_is_auth_fetch() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool ctxt_state = pref.getBool('is_auth');
    return ctxt_state;
  }

  static void update_account_state(int id) async {
    SharedPreferences pf = await SharedPreferences.getInstance();
    pf.setInt("selected_account", id);
  }

  //-------------------------------------------------------------------------------
  static void set_theme_mode(int mode) async {
    SharedPreferences pf = await SharedPreferences.getInstance();
    pf.setInt("selected_theme", mode);
  }

  static Future<int> get_theme_mode() async {
    SharedPreferences pf = await SharedPreferences.getInstance();
    int t = pf.getInt("selected_theme");
    return t;
  }

  static void first_time_theme_selection() async{
    SharedPreferences pf = await SharedPreferences.getInstance();

    isFirstTime().then((isFirstTime) {
      if (isFirstTime) {
        pf.setInt("selected_theme", 1);
      } else {
        print("it is not first");
      }
    });

  }
}
