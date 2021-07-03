//import 'package:e_trans/page/tab_home_screen.dart';
import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'forgot_password_screen.dart';
import 'home.dart';
import 'package:e_trans/utils/context_utils.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _emailController = new TextEditingController();
  var _passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error !'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Incorrect email or password'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Oke'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void authentication() async {
    var res = await context.autProvider
        .login(_emailController.text, _passwordController.text);

    if (res.result ?? false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      _showMyDialog();
    }
  }

  // void sendRequestGetDataUserLogin() {
  //   Userloginmodel userloginmodel = new Userloginmodel();
  //   var requestBody = jsonEncode(userloginmodel.toJson());
  //   UserLoginServices.getUserLogin(requestBody).then((value) {
  //     final result = value;
  //     if (result.success == true && result.code == 200) {
  //     } else {}
  //   }).catchError((error) {
  //     String err = error.toString();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      controller: _emailController,
      // validator: Validator,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(
          Icons.email,
          color: Colors.lightBlue,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );

    final password = TextFormField(
      controller: _passwordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        prefixIcon: Icon(
          Icons.security,
          color: Colors.lightBlue,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          authentication();
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlue,
        child:
            Text('Log In', style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.lightBlue),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return ForgotpasswordScreen();
          }),
        );
      },
    );

    // ignore: non_constant_identifier_names
    final signUpLabel = FlatButton(
      child: Text(
        "Don’t have account?, Create a new account",
        style: TextStyle(color: Colors.lightBlue),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) {
            return RegistrationPage();
          }),
        );
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          Image.asset('image/background_login3.JPG',
              fit: BoxFit.cover, width: 700),
          Padding(
            padding: EdgeInsets.only(top: 40, left: 120),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 90.0,
              child: Image.asset(
                'image/logo.png',
                width: 600,
                height: 300,
              ),
            ),
          ),
          Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 200),
              children: <Widget>[
                email,
                SizedBox(height: 24.0),
                password,
                SizedBox(height: 24.0),
                loginButton,
                SizedBox(height: 30.0),
                signUpLabel,
                forgotLabel,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
