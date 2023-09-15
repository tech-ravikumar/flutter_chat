
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api_exception.dart';
import '../network/api_service.dart';

class AuthRepository{
  final SharedPreferences prefs;
  final ApiService _api;
  AuthRepository(this.prefs, this._api);

  Future<Map<String,dynamic>> userLoginWithEmail(String email, String password, {String? fcmToken}) async {
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
      // 'fcmToken': fcmToken ?? prefs.getString('device_token'),
    };
    if(fcmToken!=null) {
      data['fcmToken'] = fcmToken;
    }

    var res = await _api.postRequest('login_user', data);
    if (res == null) {
      throw ApiException.fromString("response null");
    }
    return res;
  }


}
