import 'package:lsm_project/auth.dart';
import 'package:lsm_project/pages/homePage.dart';
import 'package:lsm_project/pages/loginRegisterPage.dart';
import 'package:flutter/material.dart';

class TreeOfPages extends StatefulWidget{
  const TreeOfPages({Key? key}) : super(key: key);

  @override
  State<TreeOfPages> createState() =>_TreeOfPagesState();
}

class _TreeOfPagesState extends State<TreeOfPages>{
  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot){
        if(snapshot.hasData) {
          return HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}