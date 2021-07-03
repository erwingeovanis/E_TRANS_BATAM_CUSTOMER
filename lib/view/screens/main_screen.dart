import 'package:e_trans/view/screens/home.dart';
import 'package:e_trans/provider/auth_provider.dart';
import 'package:e_trans/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return value.isLogin ? HomePage() : LoginPage();
      },
    );
  }
}
