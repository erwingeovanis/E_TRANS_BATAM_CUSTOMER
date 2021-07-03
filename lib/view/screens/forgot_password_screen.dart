import 'package:e_trans/view/screens/change_forgot_pass_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_trans/view/components/form_default.dart';
import 'package:e_trans/utils/context_utils.dart';

class ForgotpasswordScreen extends StatelessWidget {
  const ForgotpasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'image/background_login3.JPG',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: [
              Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 90.0,
                    child: Image.asset(
                      'image/logo.png',
                      width: 600,
                      height: 300,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.lightBlue,
                        radius: 25.0,
                        child: Icon(
                          Icons.lock_rounded,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Forget Password?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "code verification for reset password will send to your Email ",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  FormDefault(
                    field: ["email"],
                    onSubmit: (Map<String, String> result,
                        GlobalKey<FormState> keyForm) async {
                      var res = await context.autProvider
                          .sendVerificationCode(result["email"] ?? "");
                      context.showSnacbar(res.message ?? "internal error");
                      if (res.result ?? false) {
                        context.pushTo(ChangeForgotPassScreen(
                            verificationcode: res.data!.code!,
                            uid: res.data!.uid!));
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
