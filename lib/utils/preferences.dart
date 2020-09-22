import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  void putNoteTitle(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('putNoteTitle', title);
  }

  Future<String> getNoteTitle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String string = prefs.getString('putNoteTitle');
    return string;
  }

}
