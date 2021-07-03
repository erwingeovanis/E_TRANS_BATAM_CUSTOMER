import 'package:flutter/material.dart';
import 'default_form_field.dart';
import 'primary_button.dart';

class FormDefault extends StatefulWidget {
  final List<String> field;
  final List<Widget> icons;
  final List<String> obscureField;
  final String submitButtonLabel;
  final List<String> notRequiredfield;
  final Map<String, TextInputType> inputype;
  final Widget? widgetBeforeSubmitButton;
  final String? Function(String? value, String? currentfieldname,
      Map<String, String> allfieldValue)? validation;
  final Function(
    Map<String, String> result,
    GlobalKey<FormState> keyForm,
  ) onSubmit;

  const FormDefault({
    Key? key,
    this.field = const [],
    this.obscureField = const [],
    this.notRequiredfield = const [],
    required this.onSubmit,
    this.icons = const [],
    this.submitButtonLabel = "Submit",
    this.inputype = const {},
    this.validation,
    this.widgetBeforeSubmitButton,
  }) : super(key: key);
  @override
  _FormDefaultState createState() => _FormDefaultState();
}

class _FormDefaultState extends State<FormDefault> {
  final Map<String, TextEditingController> _controllers = {};
  @override
  void initState() {
    widget.field.forEach((element) {
      _controllers[element] = TextEditingController();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controllers.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  GlobalKey<FormState> _fKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _fKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _generateFields(),
        ),
      ),
    );
  }

  List<Widget> _generateFields() {
    var fields = <Widget>[];

    for (var i = 0; i < widget.field.length; i++) {
      var wFields = widget.field;
      var _icon = (i < widget.icons.length) ? widget.icons[i] : null;
      fields.add(
        Row(
          children: [
            Expanded(
              child: DefaultFormField(
                inputType: widget.inputype[wFields[i]],
                icon: _icon,
                isObscure: widget.obscureField.contains(wFields[i]) ||
                    wFields[i].toLowerCase().contains('password'),
                validation: (value) {
                  if (widget.validation != null) {
                    widget.validation!(value, wFields[i], getResultForm());
                  }
                  if (widget.notRequiredfield.contains(wFields[i])) {
                    return null;
                  } else if (value!.isEmpty) {
                    return 'this fields is required';
                  } else if (wFields[i].toLowerCase().contains('password')) {
                    if (getResultForm()["password"]!.length < 6) {
                      return "please input password that length greater than 6";
                    }
                    List<String> res = [];
                    getResultForm()
                        .keys
                        .where((element) =>
                            element.toLowerCase().contains("password"))
                        .forEach((element) {
                      res.add(getResultForm()[element] ?? "");
                    });

                    if (res.length > 1 &&
                        res.where((element) => element != res.first).length >
                            0) {
                      return "please input match password";
                    }
                  } else if (wFields[i] == 'email' &&
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return 'please input a valid email';
                  }
                  return null;
                },
                labelText: wFields[i],
                textEditingController: (_controllers[wFields[i]])!,
              ),
            )
          ],
        ),
      );
    }
    if (widget.widgetBeforeSubmitButton != null) {
      fields.add(widget.widgetBeforeSubmitButton!);
    }
    fields.add(Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryButton(
              onPressed: () {
                if (_fKey.currentState!.validate()) {
                  widget.onSubmit(getResultForm(), _fKey);
                }
              },
              text: widget.submitButtonLabel),
        ],
      ),
    ));
    return fields;
  }

  Map<String, String> getResultForm() {
    return _controllers.map<String, String>(
      (key, value) => MapEntry(
        key,
        value.text.trim(),
      ),
    );
  }
}
