import 'package:flutter/material.dart';

import '../../themes/main_theme.dart';
import 'package:intl/intl.dart';
import '../../utils/formatters/dateInputFormatter.dart';

class DOBEditText extends StatelessWidget {
  const DOBEditText({
    Key? key,
    this.textLabel,
    required this.textHint,
    required this.textController,
    required this.textValidatorType,
    this.suffixIcon
  }) : super(key: key);

  final String? textLabel;
  final String textHint;
  final String? textValidatorType; //validator types: email, password
  final TextEditingController textController;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          DateInputFormatter(),
        ],
        validator: (value) => validateValue(textValidatorType),
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.dark ?
          MainTheme.appColors.darkModeBlue100 : MainTheme.appColors.neutral200,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide.none,
          ),
          hintText: textHint,
          hintStyle: Theme.of(context).textTheme.bodyLarge,
          label: (textLabel != null) ?  Text(
            textLabel!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ) : null,
          suffixIcon: suffixIcon
        ));
  }

  String? validateValue(String? value) {
    if(value == "dobValidator"){
      return birthDateValidator(textController.text);
    }
    else {
      return null;
    }
  }

  //date of birth validator
  String? birthDateValidator(String value){
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy');
    final String formatted = formatter.format(now);
    String str1 = value;
    List<String> str2 = str1.split('/');
    String day = str2.isNotEmpty ? str2[0] : '';
    String month = str2.length > 1 ? str2[1] :'';
    String year = str2.length > 2 ? str2[2] : '';
    if(value.isEmpty){
      return 'Value required';
    }
    else if(int.parse(month) > 13){
      return 'Invalid month';
    }
    else if(int.parse(day) > 32){
      return 'Invalid day';
    }
    else if(int.parse(year) > int.parse(formatted)){
      return 'Invalid Year';
    }
    else if(int.parse(year) < 1940){
      return 'Invalid year';
    }
    else if((int.parse(formatted) - int.parse(year))  < 18){
      return 'Age provided is below 18yrs.';
    }
    return null;
  }

}