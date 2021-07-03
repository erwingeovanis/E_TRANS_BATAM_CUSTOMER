import 'package:e_trans/provider/auth_provider.dart';
import 'package:e_trans/provider/main_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ContextUtils on BuildContext {
  MainProvider _getMainProvider() =>
      Provider.of<MainProvider>(this, listen: false);
  AuthProvider _getAuthProvider() =>
      Provider.of<AuthProvider>(this, listen: false);
  showSnacbar(String msg) => ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              msg,
            ),
          ]),
        ),
      );
  pop({dynamic data}) => Navigator.of(this).pop(data);
  pushTo(Widget to) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (ctx) => to));
  replaceToFirst()=>Navigator.of(this).popUntil((route) => route.isFirst);

  replaceTo(Widget to) => Navigator.of(this)
      .pushReplacement(MaterialPageRoute(builder: (ctx) => to));

  MainProvider get mainProvider => _getMainProvider();
  AuthProvider get autProvider => _getAuthProvider();
}
