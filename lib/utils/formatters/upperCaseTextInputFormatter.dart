import 'package:flutter/services.dart';

class UpperCaseTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Convert to uppercase and filter non-alphanumeric characters
    final newText = newValue.text.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');

    // Calculate the new selection offset
    final selectionIndex = newValue.selection.baseOffset +
        (newText.length - newValue.text.length);

    // Ensure the selection index is valid
    final newSelection = TextSelection.collapsed(
        offset: selectionIndex.clamp(0, newText.length));

    // Return the new TextEditingValue with the updated text and selection
    return TextEditingValue(
      text: newText,
      selection: newSelection,
    );
  }
}