import 'package:chat/bloc/auth_bloc.dart';
import 'package:chat/data/repository/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../utils/message_handler.dart';
import '../home/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthBloc bloc;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    bloc = AuthBloc(context.read<AuthRepository>());
    super.initState();
    bloc.msgController?.stream.listen((event) {
      AppMessageHandler().showSnackBar(context, event);
    });
    bloc.authStream.stream.listen((event) {
      if(event == 'Success'){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
          return const HomePage();
        }),(route) => false,);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height:70,
              ),
              Center(
                child: Image.asset(
                  "assets/images/image_not_found.png",
                  height: 250,
                  width: 250,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Sign In!',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    letterSpacing: 0.3),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Hey, Enter your details to get sign in to your account',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[500],
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500],
                          fontFamily: 'Poppins'),
                    )),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: K.boxShadow,
                ),
                child: TextFormField(
                  controller: bloc.emailController,
                  onFieldSubmitted: (value) {
                    bloc.emailController.text = value;
                  },
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Please enter email";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Email Address",
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.black54,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Poppins',
                      ),
                      border: InputBorder.none),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'Password',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                        fontFamily: 'Poppins'),
                  )),

              const SizedBox(
                height: 5,
              ),

              ValueListenableBuilder(
                  valueListenable: bloc.isPasswordVisible,
                  builder: (context,bool visible,_) {
                    return Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        // boxShadow: K.boxShadow,
                      ),
                      child: TextFormField(
                        obscureText: visible,
                        controller: bloc.passwordController,
                        onFieldSubmitted: (value) {
                          bloc.passwordController.text = value;
                        },
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Please enter password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: const Icon(
                              Icons.lock_open_outlined,
                              color: Colors.black54,
                            ),
                            suffixIcon:GestureDetector(
                              onTap: () {
                                bloc.isPasswordVisible.value = !bloc.isPasswordVisible.value;
                              },
                              child: visible
                                  ? const Icon(
                                PhosphorIcons.eye_closed,
                                color: Colors.black54,
                                size: 20,
                              )
                                  : const Icon(
                                PhosphorIcons.eye,
                                color: Colors.black54,
                                size: 20,
                              ),
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Poppins',
                            ),
                            border: InputBorder.none),
                      ),
                    );
                  }
              ),

              const SizedBox(
                height: 10,
              ),

              Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(right: 30),
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ForgetPage()));
                    },
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                          fontSize: 13,
                          letterSpacing: 0.4,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade500),
                    ),
                  )),

              const SizedBox(
                height: 30,
              ),

              ValueListenableBuilder(
                  valueListenable: bloc.isLoading,
                  builder: (context,bool loading,_) {
                    return GestureDetector(
                      onTap: () {
                        if(formKey.currentState!.validate()){
                          bloc.userLogin();
                        }
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeBar()));

                      },
                      child: Center(
                        child: Container(
                          height: 50,
                          // width: 0.7.sw,
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                              color: Colors.red.withOpacity(0.8)),
                          child:loading ? const Center(child: CircularProgressIndicator(color: Colors.white,),): const Center(
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              ),

              const SizedBox(
                height: 30,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't Have An Account?",
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Provider.value(value: bloc,child: const Register())));
                      },
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          // decoration: TextDecoration.underline,
                            decorationColor: Colors.red.withOpacity(0.8),
                            decorationThickness: 1.5,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.red.withOpacity(0.8)),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
