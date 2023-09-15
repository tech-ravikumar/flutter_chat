import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/auth_repo.dart';
import '../utils/message_handler.dart';
import 'bloc.dart';

class AuthBloc extends Bloc {
  final AuthRepository _repo;
  AuthBloc(this._repo);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier<bool> isPasswordVisible = ValueNotifier(true);
  late Map<String, dynamic> response;
  StreamController<String> authStream = StreamController.broadcast();
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  userLogin(/*String token*/) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    try {
      isLoading.value = true;
      if(emailController.text.isEmpty){
        showMessage(const MessageType.info("Please enter Email"));
        return ;
      }
      if(passwordController.text.isEmpty){
        showMessage(const MessageType.info("Please enter Password"));
        return ;
      }
      response = await _repo.userLoginWithEmail(
          emailController.text, passwordController.text,
          // fcmToken: token
      );

      if (
        response['status']) {
        Map<String, dynamic> uData = response['data'];
        _pref.setString('uid', uData['id'].toString());
        _pref.setString('name', uData['name'].toString());
        _pref.setString('email', uData['email'].toString());
        _pref.setString('phone', uData['number'].toString());
        authStream.sink.add('Success');

        print(_pref.getString("uid"));
        print(_pref.getString("name"));
        print(_pref.getString("email"));
        print(_pref.getString("phone"));

      }else{
        showMessage(MessageType.error('${response['message']}'));
      }
      return response;
    } catch (e, s) {
      debugPrint('error: $e');
      debugPrint('stackTrace $s');

    }finally{
      isLoading.value = false;
    }
  }

}