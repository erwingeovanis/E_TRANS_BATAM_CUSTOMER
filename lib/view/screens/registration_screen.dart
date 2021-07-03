
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:e_trans/utils/context_utils.dart';

class RegistrationPage extends StatefulWidget {
  static String tag = 'registration-page';
  @override
  _RegistrationPageState createState() => new _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  var _nameController = new TextEditingController();
  var _emailController = new TextEditingController();
  var _passwordController = new TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void sentRequestInsertDataUser() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _nameController.text.isEmpty) {
    } else {
      var res = await context.autProvider.register(
        _emailController.text,
        _passwordController.text,
        _nameController.text,
      );
      context.showSnacbar(res.message ?? "cannot process your request");
      if (res.result ?? false) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    }
  }

  // Future<void> _showMyDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Error !'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('Successfuly'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('Oke'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final name = TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Full Name',
        prefixIcon: Icon(
          Icons.perm_identity_sharp,
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

    final email = TextFormField(
      controller: _emailController,
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
          borderRadius: BorderRadius.circular(20.0),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );

    final validasipassword = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        prefixIcon: Icon(
          Icons.security,
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

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          sentRequestInsertDataUser();
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlue,
        child: Text('Create Account',
            style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
    );

    // ignore: non_constant_identifier_names

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
                key: _formkey,
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 290),
                children: <Widget>[
                  name,
                  SizedBox(height: 15.0),
                  email,
                  SizedBox(height: 15.0),
                  password,
                  SizedBox(height: 15.0),
                  validasipassword,
                  SizedBox(height: 50.0),
                  loginButton,
                ],
              ),
            ),
          ],
        ));
  }
}
