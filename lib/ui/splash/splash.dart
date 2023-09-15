import 'dart:async';

import 'package:chat/ui/auth/login.dart';
import 'package:chat/ui/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shared_preferences/shared_preferences.dart';


class Splash extends StatefulWidget {
  static const route = "/";
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, init);

  }
  init() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? login = pref.getString("uid");
    if(login !=null){
      if(login.isNotEmpty){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const HomePage()));
      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const LoginPage()));
      }
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Splash")
            // Image.asset("AppImages.logo",
            //   // width: 0.70.sw,
            //   fit: BoxFit.fitWidth,),
             ],
        ),
      ),
    );
  }
}
