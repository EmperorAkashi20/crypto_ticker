// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'package:flutter/material.dart';

import '../DeviceManager/text_styles.dart';
import '../Utils/const_strings.dart';

enum Type {
  email,
  password,
  name,
}

class TextFields extends StatefulWidget {
  final TextEditingController textEditingController;
  final Type type;
  final ontap;
  final labelText;
  const TextFields({
    Key? key,
    required this.textEditingController,
    required this.type,
    this.ontap,
    this.labelText,
  }) : super(key: key);

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  late Type type;

  var _value;

  final bool _errorFree = true;

  bool validate = false;

  bool? readOnlyEmail;

  get errorFree => _errorFree;

  Type get _type => widget.type;

  var searchTextField;

  TextEditingController get _thisController => widget.textEditingController;
  late GlobalKey<NavigatorState> navigatorKey;
  bool indicator = true; //indicates if the field is selected or not

  final FocusNode focus = FocusNode();

  //initialize everything before the page loads so that it doesn't throw an error later.
  @override
  void initState() {
    super.initState();
    navigatorKey = GlobalKey<
        NavigatorState>(); //navigator key for validations and checking
    //if the textEditingController is null(has no data) do nothing else start validating as the user types.
    if (widget.textEditingController == null) {
    } else {
      widget.textEditingController.addListener(_handleControllerChanged);
    }
  }

  //What needs to be done when the textEditingController finds the changing data
  void _handleControllerChanged() {
    if (_thisController.text != _value || _value.trim().isNotEmpty) {
      didChange(_thisController.text);
    }
  }

  //As and when the data changes, the value starts getting updated.
  void didChange(var value) {
    setState(() {
      _value = value;
    });
  }

  @override
  void didUpdateWidget(TextFields oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.textEditingController != oldWidget.textEditingController) {
      oldWidget.textEditingController.removeListener(_handleControllerChanged);
      widget.textEditingController.addListener(_handleControllerChanged);

      if (widget.textEditingController == null) {
        if (widget.textEditingController != null) {
          _thisController.text = widget.textEditingController.text;
          //if (oldWidget.textEditingController == null) _controller = null;
        }
      }
    }
  }

  //Disposing the listener to avoid taking up extra memory.
  @override
  void dispose() {
    widget.textEditingController.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_type) {
      case Type.email:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.text,
            autofocus: false,
            maxLines: 1,
            validator: validateEmail,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              fillColor: Colors.blueGrey,
              filled: true,
              hintText: 'john@doe.com',
              hintStyle: TextStyles.hintTextStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: const OutlineInputBorder(
                //Enabled border for the form field
                borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                borderRadius: BorderRadius.all(
                  //Border radius for the form field
                  Radius.circular(10.0),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                //Focused border for the form field
                borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
          );
        }

      case Type.password:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.text,
            autofocus: false,
            maxLines: 1,
            obscureText: indicator,
            validator: validatePassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              errorMaxLines: 2,
              fillColor: Colors.blueGrey,
              filled: true,
              hintText: 'Password',
              hintStyle: TextStyles.hintTextStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: const OutlineInputBorder(
                //Enabled border for the form field
                borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                borderRadius: BorderRadius.all(
                  //Border radius for the form field
                  Radius.circular(10.0),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                //Focused border for the form field
                borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              suffixIcon: IconButton(
                //Suffix icon for the form field
                icon: Icon(
                  indicator
                      ? Icons
                          .visibility_off_outlined //If the indicator is true, then the icon is the eye closed icon
                      : Icons.visibility_outlined,
                  //If the indicator is false, then the icon is the eye open icon
                  color: Colors.grey.shade900,
                ),
                onPressed: () {
                  setState(() {
                    indicator = !indicator; //Toggle the indicator
                  });
                },
              ),
            ),
          );
        }

      case Type.name:
        {
          {
            return TextFormField(
              controller: _thisController,
              keyboardType: TextInputType.text,
              autofocus: false,
              maxLines: 1,
              validator: validateName,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                fillColor: Colors.blueGrey,
                filled: true,
                hintText: 'John Doe',
                hintStyle: TextStyles.hintTextStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: const OutlineInputBorder(
                  //Enabled border for the form field
                  borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                  borderRadius: BorderRadius.all(
                    //Border radius for the form field
                    Radius.circular(10.0),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  //Focused border for the form field
                  borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            );
          }
        }

      default:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.text,
            autofocus: false,
            maxLines: 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: TextStyles.subTitle,
            //validator: validateEmailAndMobile,
            decoration: InputDecoration(
              fillColor: Colors.grey.shade100,
              filled: true,
              hintText: 'Default',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
    }
  }

  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return AppLabels.emailRequired;
    } else if (!regExp.hasMatch(value)) {
      return AppLabels.invalidEmail;
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    /*String pattern =
        r"(^(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!%*?&.*':;€#])[A-Za-z\d@$!%*?&.*':;€#]{8,}$)";
    // ignore: unused_local_variable
    RegExp regExp = RegExp(pattern);*/

    //old
    //RegExp regExp1 = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    RegExp regExp1 = RegExp(r'^(?=.*[a-zA-Z])(?=.*[*".!@#\$%^&(){}:;<>,.\' +
        r"'?/~_+-=])(?=.*[0-9]).{8,30}");
    RegExp regExp2 = RegExp(r'^(?=.*[A-Z])');

    if (value!.length < 8) {
      return AppLabels.passwordValidation;
    } else if (!regExp1.hasMatch(value)) {
      return AppLabels.passwordValidation2;
    } else if (!regExp2.hasMatch(value)) {
      return AppLabels.passwordValidation3;
    }
    return null;
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return AppLabels.nameRequired;
    } else {
      return null;
    }
  }
}
