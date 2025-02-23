
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier{

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static late final SharedPreferences _prefs;

  Future<void> loginUser(String username) async{
    try {
      _prefs.setString('userName', username);
    }catch (e){
      print(e);
    }
  }

  Future<bool> isLoggedIn() async{
    String? username =_prefs.getString('username');
    if(username == null) return false;
    return true;
  }

  void logoutUser() {
    _prefs.clear();
  }

   getUsername() {
    return _prefs.getString('userName') ?? 'Default Username';
  }

  void updateUserName(String newName) {
    _prefs.setString('userName', newName);
    notifyListeners();
  }
}