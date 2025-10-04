import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  static final ValueNotifier<bool> isLoggedIn = ValueNotifier(false);

  static Future<void> loadLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final savedStatus = prefs.getBool('isLoggedIn') ?? false;
    isLoggedIn.value = savedStatus;
  }

  static Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    isLoggedIn.value = true;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    isLoggedIn.value = false;
  }

  // static void login() => isLoggedIn.value = true;
  // static void logout() => isLoggedIn.value = false;
}
