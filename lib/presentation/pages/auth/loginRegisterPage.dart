import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lsm_project/data/data_sources/firebase_auth_source.dart';
import 'package:lsm_project/presentation/pages/auth/auth_controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) :super (key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final authController = Get.find<AuthController>();
  String? errorMessage = '';
  bool isLogin = true;

  Future<void> signInWithEmailAndPassword() async {
    try {
      await FirebaseAuthSource().signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text);
    } on FirebaseAuthException catch(e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }
  Future<void> createUserWithEmailAndPassword() async{
    try {
      await FirebaseAuthSource().createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text);
    } on FirebaseAuthException catch(e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }
  Widget entryField(String title, TextEditingController cont) {
    return TextField(
      controller: cont,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }
  Widget showErrorMessage() {
    return Text(errorMessage == '' ? '' : 'ERROR: $errorMessage');
  }
  Widget submit(){
    return ElevatedButton(
        onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
        child: Text(isLogin ? 'login' : 'register')
    );
  }
  Widget switchLoginOrRegister(){
    return TextButton(
        onPressed: (){
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? 'register': 'login'));
  }



  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('firebase auth'),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            entryField('email', _emailController),
            entryField('password', _passwordController),
            submit(),
            switchLoginOrRegister(),
            showErrorMessage()
          ],
        ),
      ),
    );
  }
}