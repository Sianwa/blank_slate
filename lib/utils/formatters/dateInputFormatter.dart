import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
   var text = _format(newValue.text, '/');
   return newValue.copyWith(text: text, selection:updateCursorPosition(text));
  }

  _format(String value, String separator) {
    value = value.replaceAll(separator, '');
    var newString = '';

    for(int i = 0; i < min(value.length, _maxChars); i++){
      newString += value[i];
      if((i==1 || i==3) && i != value.length - 1){
        newString += separator;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}