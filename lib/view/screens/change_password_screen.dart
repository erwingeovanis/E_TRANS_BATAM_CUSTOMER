import 'package:e_trans/view/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_trans/view/components/form_default.dart';
import 'package:e_trans/utils/context_utils.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Input new password",
            style: Theme.of(context).textTheme.headline6,
          ),
          FormDefault(
            field: ["password", "confirm password"],
            onSubmit: (Map<String, String> result,
                GlobalKey<FormState> keyForm) async {
              var res = await context.autProvider
                  .changePassword(result["password"] ?? "");
              context.showSnacbar(res.message ?? "internal error");
              if (res.result ?? false) {
                context.replaceTo(MainScreen());
              }
            },
          )
        ],
      ),
    );
  }
}
