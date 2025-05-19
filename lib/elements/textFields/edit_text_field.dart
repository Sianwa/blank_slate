import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/main_theme.dart';

class EditText extends StatelessWidget {
  EditText({
    Key? key,
    this.textLabel,
    this.maxLines,
    this.minLines,
    required this.textHint,
    required this.textController,
    required this.textValidatorType,
    required this.isEditable,
    this.textInputFormatter,
    this.suffixIcon,
    this.textInputType,
    this.errorText,
    this.textStyle,

  }) : super(key: key);

  final String? textLabel;
  final String textHint;
  final String? textValidatorType; //validator types: email, password
  final TextEditingController textController;
  final bool isEditable;
  final int? minLines;
  final int? maxLines;
  final List<TextInputFormatter>? textInputFormatter;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final String? errorText;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        inputFormatters: (textInputFormatter != null) ? textInputFormatter! : [],
        controller: textController,
        enabled: isEditable,
        validator: (value) => validateValue(textValidatorType),
        cursorColor: Colors.blue,
        minLines: minLines,
        maxLines: maxLines,
        keyboardType: textInputType,
        decoration: InputDecoration(
          errorText: errorText,
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.dark ?
                     MainTheme.appColors.darkModeBlue100 : MainTheme.appColors.neutral200,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide.none,
          ),
          hintText: textHint,
          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: MainTheme.appColors.neutral400),
          label: (textLabel != null)
              ? Text(
                  textLabel!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                )
              : null,
          suffixIcon: suffixIcon,
        ),
    );
  }

  String? validateValue(String? value) {
    if (value == "emailValidator") {
      return emailValidator(textController.text);
    } else if (value == "phoneNumberValidator") {
      return phoneNumberValidator(textController.text);
    } else if(value == "requiredTextValidator"){
      return requiredTextValidator(textController.text);
    } else if(value == "requiredTextBenValidator"){
      return requiredTextBenValidator(textController.text);
    } else if(value == "ibanValidator"){
      return ibanValidator(textController.text);
    }
    else {
      return null;
    }
  }

  //email validator
  String? emailValidator(String emailAddress) {
    if (emailAddress.isEmpty) {
      return "Field Required";
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
        .hasMatch(emailAddress)) {
      return "Invalid email address";
    } else {
      return null;
    }
  }

  String? requiredTextValidator(String text) {
    if (text.isEmpty) {
      return "Field Required";
    } else {
      return null;
    }
  }

  String? requiredTextBenValidator(String text){
      if (text.isEmpty) {
        return "Field Required";
      } else if (text.length < 10) {
        // Check Whether alias is less than 10
        return "Alias cannot be less than 10 characters";
      } else {
        return null;
      }
  }

  String? phoneNumberValidator(String text) {
    if (text.isEmpty) {
      return "Field Required";
    } else {
      var trimmedString = text.replaceAll(" ", "");
      if (trimmedString.length < 9) {
        return "Invalid phone number";
      } else if (trimmedString.length > 9) {
        return "Invalid phone number";
      } else {
        return null;
      }
    }
  }

  String? ibanValidator(String text){
    if(text.isEmpty){
      return "Field Required";
    }
    else if(!RegExp(r'^SO\d{21}$').hasMatch(text)){
      return "Invalid IBAN number";
    }
    else {
      return null;
    }
  }
}
