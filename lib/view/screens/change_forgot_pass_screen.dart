import 'package:e_trans/view/components/form_default.dart';
import 'package:flutter/material.dart';
import 'package:e_trans/utils/context_utils.dart';

class ChangeForgotPassScreen extends StatelessWidget {
  const ChangeForgotPassScreen(
      {Key? key, required this.verificationcode, required this.uid})
      : super(key: key);
  final String verificationcode;
  final int uid;
  @override
  Widget build(BuildContext context) {
    print("$uid " + verificationcode);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.all(10)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Input new password",
                  style: Theme.of(context).textTheme.headline6,
                ),
                FormDefault(
                  field: ["verification code", "password", "confirm password"],
                  onSubmit: (Map<String, String> result,
                      GlobalKey<FormState> keyForm) async {
                    if ((result["verification code"] ?? "").trim() !=
                        verificationcode.trim()) {
                      context.showSnacbar(
                          "your input verification code not valid");
                    } else {
                      var res = await context.autProvider
                          .changePasswordForget(result["password"] ?? "", uid);
                      context.showSnacbar(res.message ?? "internal error");
                      if (res.result ?? false) {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      }
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
