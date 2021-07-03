import 'package:e_trans/provider/auth_provider.dart';
import 'package:e_trans/view/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_trans/view/screens/change_password_screen.dart';
import 'package:e_trans/utils/context_utils.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: ListView(
        children: [
          Consumer<AuthProvider>(
            builder: (context, value, child) => Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 0,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 40, bottom: 40),
                  child: Column(
                    children: <Widget>[
                      // Fullname
                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Full Name   : ' +
                                (value.userProfile.name ?? "no name"),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Email
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email           : ' + (value.email),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Password   : ' +
                                (value.userProfile.password ?? "*********"),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        MaterialButton(
                          onPressed: () =>
                              context.pushTo(ChangePasswordScreen()),
                          child: Text(
                            "Change password",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
                SizedBox(height: 100),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  width: 450,
                  child: ElevatedButton(
                    onPressed: () async {
                      context.autProvider.logout();
                      
                      Future.delayed(Duration(milliseconds: 800),()=>context.replaceTo(MainScreen()));
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(5),
                      padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.lightBlue),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
