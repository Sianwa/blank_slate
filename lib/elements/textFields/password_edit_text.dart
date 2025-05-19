import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/main_theme.dart';

class PasswordEditText extends StatefulWidget {
  const PasswordEditText({Key? key, required this.textLabel,  required this.textController, required this.textHint,}) : super(key: key);

  final String textLabel;
  final String textHint;
  final TextEditingController textController;


  @override
  State<PasswordEditText> createState() => _PasswordEditTextState(textHint, textLabel);
}

class _PasswordEditTextState extends State<PasswordEditText> {
  bool _isObscure = true;
  String textHint;
  String textLabel;

  _PasswordEditTextState(this.textHint, this.textLabel);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: 4,
        controller: widget.textController,
        obscureText: _isObscure,
        cursorColor: Colors.blue,
        obscuringCharacter: '•',
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,  // Allows only digits
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return "Field Required";
          }
          else if(value.length < 4){
            return "Password too short";
          }
          else if(value.length > 4){
            return "Password must be 4 characters";
          }
          else if (value[0] == value[1] && value[1] == value[2] && value[2] == value[3]) {
            return "Password cannot have all same digits";
          }
          else {
            return null;
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.dark ?
                      MainTheme.appColors.darkModeBlue100 : MainTheme.appColors.neutral200,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide.none,
          ),
          hintText: textHint,
          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: MainTheme.appColors.neutral400),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
            icon: Icon(
              _isObscure ? Icons.visibility_off : Icons.visibility,
              color:  Theme.of(context).brightness == Brightness.dark ? MainTheme.appColors.activeYellow400 : MainTheme.appColors.primaryBlue100,
            ),
          ),
          label: Text(
            textLabel,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
        ));
  }
}