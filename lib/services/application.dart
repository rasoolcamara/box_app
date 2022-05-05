import 'dart:convert';
import 'package:box_app/models/application.dart';
import 'package:box_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:box_app/app_properties.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationService {
  Future<Application> getApplication(
    String token,
    int userId,
  ) async {
    final response = await http.get(Uri.parse(userURL + 'box/show/$userId'),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        });

    // print("RESPONSE");
    // print(response.body);

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var appli = body['application'];
      print('La reponse APP');
      print(appli['active_channels']);
      activeApplication = Application.fromJson(appli);

      return activeApplication;
    } else {
      return null;
    }
  }
  // Login

  Future<Application> loginStep2(
    String password,
    String login,
  ) async {
    final response = await http.post(Uri.parse(userURL + 'rlt/login'),
        body: jsonEncode({
          "login": login,
          "password": password,
        }),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer $activeToken"
        });

    var body = jsonDecode(response.body);
    print('LES DONNESS');
    print(body);
    if (body["response"] == "success") {
      User user = User.fromJson(body["data"]["user"]);

      Application application = await getApplication(
        activeToken,
        user.id,
      );

      return application;
    } else {
      return null;
    }
  }

  Future<Application> login(
    String password, {
    String phone,
    String email,
  }) async {
    final response = await http.post(
      Uri.parse(userURL + 'authenticate'),
      body: jsonEncode({
        "email": "collect@paydunya.com",
        "password": "123456789",
      }),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      activeToken = body['token'];

      SharedPreferences _prefs = await SharedPreferences.getInstance();

      await _prefs.setString("activeToken", activeToken);
      await _prefs.setBool("isLoggedIn", true);

      String log = phone ?? email;
      Application application = await loginStep2(password, log);
      if (application != null) {
        await _prefs.setInt("userId", application.user.id);
        userId = application.user.id;
        return application;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<Application> loginWithOtherCrendentials(
    String password, {
    String phone,
    String email,
  }) async {
    final response = await http.post(
      Uri.parse(userURL + 'authenticate'),
      body: jsonEncode({
        "email": "doro.gueye@paydunya.com",
        "password": "123456789",
      }),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      activeUserToken = body['token'];

      String log = phone ?? email;
      Application application = await loginStep2(password, log);

      userId = application.user.id;
      return application;
    } else {
      return null;
    }
  }

  // Logout
  /* Future<String> logout(String token) async {
    String deviceToken = await FirebaseMessaging.instance.getToken() ?? '';
    String deviceId = await PlatformDeviceId.getDeviceId ?? '';

    final response = await http.get(
      Uri.parse(userURL +
          'auth/logout?device_token=$deviceToken&device_id=$deviceId'),
      headers: <String, String>{
        "Content-Type": "application/json",
        "X-Requested-With": "XMLHttpRequest",
        "Authorization": "Bearer $token"
      },
    );

    var body = jsonDecode(response.body);
    print(body);
    if (response.statusCode == 201) {
      var body = jsonDecode(response.body);

      SharedPreferences _prefs = await SharedPreferences.getInstance();
      await _prefs.setString("activeToken", '');

      print("Le body:\n $body");
      print("\n \n");
      return body["message"];
    } else {
      return null;
    }
  } */
}
