import 'package:chat/data/network/api_service.dart';
import 'package:chat/data/repository/auth_repo.dart';
import 'package:chat/data/repository/chat_repo.dart';
import 'package:chat/ui/auth/login.dart';
import 'package:chat/ui/splash/splash.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  Dio dio=Dio();
  dio.interceptors.add(Interceptor());
  final ApiService apiService=ApiService(dio);
  runApp(MyApp(sharedPreferences,apiService));
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;
  final ApiService api;
  const MyApp(this.prefs,this.api,{super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>.value(value: AuthRepository(widget.prefs, widget.api)),
        Provider<ChatRepository>.value(value: ChatRepository(widget.prefs, widget.api)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.blue,
        ),
        home: const Splash(),
      ),
    );
  }
}
