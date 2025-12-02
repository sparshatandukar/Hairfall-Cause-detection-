import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import "package:hairfall_app/model/user_model.dart";

class AuthController {
  static const String baseUrl = "http://192.168.101.8:8000";

  // -----------------------
  // SIGNUP
  // -----------------------
  static Future<Map<String, dynamic>> signup(
      String name, String email, String password) async {
    if (password.length > 72) {
      password = password.substring(0, 72);
    }

    final res = await http.post(
      Uri.parse("$baseUrl/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );

    final body = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return {
        "success": true,
        "message": body["message"] ?? "Signup successful"
      };
    } else {
      String errorMsg = "Signup failed";
      if (body is Map && body.containsKey("detail")) {
        errorMsg = jsonEncode(body["detail"]);
      }
      return {"success": false, "message": errorMsg};
    }
  }

  // -----------------------
  // LOGIN
  // -----------------------
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    if (password.length > 72) {
      password = password.substring(0, 72);
    }

    final res = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    final body = jsonDecode(res.body);

    if (res.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();

      // Extract token
      final token = body["data"]["token"];
      await prefs.setString("auth_token", token);

      // Extract USER DATA → Convert to UserModel
      UserModel user = UserModel.fromJson(body["data"]["user"]);

      // Store user locally
      await prefs.setString("user", jsonEncode(user.toJson()));

      return {
        "success": true,
        "message": body["message"] ?? "Login successful",
        "user": user
      };
    } else {
      String errorMsg = "Login failed";
      if (body is Map && body.containsKey("detail")) {
        errorMsg = jsonEncode(body["detail"]);
      }
      return {"success": false, "message": errorMsg};
    }
  }
}
