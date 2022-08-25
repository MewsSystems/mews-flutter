import 'package:flutter/services.dart';

/// TextInputFormatter that will format the input according to the given mask.
///
/// Mask could consist of the following characters:
/// - `#`: Digit
/// - `A`: Letter
/// Example: `###-###-###`
/// You can change the definition of letter and digit by passing the
/// the [allowedDigits] and [allowedLetters] parameters. [_userInput] is used
/// for tracking the user input and distinct it from the placeholder, which is
/// used to fill empty places.
class DateFormatter extends TextInputFormatter {
  DateFormatter({
    required this.mask,
    required this.placeholder,
    required List<int> userInput,
    this.initValue,
    this.allowedDigits,
    this.allowedLetters,
  }) {
    _inputType = mask.toInputType;
    _userInput = userInput;
    _buildMaskMap();
  }

  final String mask;
  final String placeholder;
  final String? initValue;
  final RegExp? allowedDigits;
  final RegExp? allowedLetters;
  final Map<int, String> _mask = {};

  late List<int> _userInput;
  late _InputType _inputType;

  bool _isValidInput(String value) {
    switch (_inputType) {
      case _InputType.digits:
        return _isValidDigit(value);
      case _InputType.letters:
        return _isValidLetter(value);
      case _InputType.combined:
        return _isValidDigit(value) || _isValidLetter(value);
    }
  }

  bool _isValidForPosition(String value, int position) {
    if (position >= mask.length) return false;

    if (mask[position] == _digitSymbol) {
      return _isValidDigit(value);
    } else if (mask[position] == _letterSymbol) {
      return _isValidLetter(value);
    } else {
      return false;
    }
  }

  bool _isValidDigit(String value) =>
      allowedDigits?.hasMatch(value) ??
      _InputType.digits.allowed.hasMatch(value);

  bool _isValidLetter(String value) =>
      allowedLetters?.hasMatch(value) ??
      _InputType.letters.allowed.hasMatch(value);

  int get _maxLength => mask.length;

  bool get _isComplete => _validInputLength == _getCleanMask.length;

  int get _validInputLength =>
      _userInput.where((i) => !_isDesignatedSpace(i)).length;

  String get _getCleanMask {
    String result = placeholder;
    for (final char in _mask.values) {
      result = result.replaceAll(char, '');
    }

    return result;
  }

  void _buildMaskMap() {
    final StringBuffer buffer = StringBuffer();
    int sectionStart = 0;

    for (int i = 0; i < _maxLength;) {
      final symbol = mask[i];
      if (symbol != _digitSymbol && symbol != _letterSymbol) {
        buffer
          ..clear()
          ..write(symbol);
        sectionStart = i;
        String sequential = '';
        while (sequential != _digitSymbol &&
            sequential != _letterSymbol &&
            i < _maxLength) {
          buffer.write(sequential);
          i++;
          if (i < _maxLength) {
            sequential = mask[i];
          }
        }
        _mask[sectionStart] = buffer.toString();
      } else {
        i++;
      }
    }
  }

  bool _isDesignatedSpace(int index) {
    for (final key in _mask.keys) {
      final length = _mask[key]?.length ?? 0;
      if (key <= index && index < key + length) {
        return true;
      }
    }

    return false;
  }

  int _getNextInputIndex(int index, int max) {
    while (_isDesignatedSpace(index)) {
      if (index == max) return max;
      index++;
    }

    return index;
  }

  int _getPreviousInputIndex(int index) {
    while (_isDesignatedSpace(index)) {
      if (index == 0) return index;
      index--;
    }

    return index;
  }

  void _updateMaskBefore(int index, void Function(int) operation) {
    final int prevValue = _getPreviousInputIndex(index);
    final int start = prevValue + 1;
    final int length = _mask[start]?.length ?? -1;
    if (length == -1) return;

    for (int i = start; i < start + length; i++) {
      operation(i);
    }
  }

  void _addMaskBefore(int index) {
    _updateMaskBefore(index, (i) => _userInput.add(i));
  }

  void _removeMaskBefore(int index) {
    _updateMaskBefore(index, (i) => _userInput.remove(i));
  }

  String _replaceCharAt(String value, int index, String replacement) =>
      value.substring(0, index) +
      replacement +
      (index == value.length - replacement.length
          ? ''
          : value.substring(index + replacement.length));

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final oldSelection = oldValue.selection;
    final newSelection = newValue.selection;
    final oldText = oldValue.text;
    final newText = newValue.text;
    final oldSelectionStart = oldValue.selection.start;
    final newSelectionStart = newValue.selection.start;

    String resultText = oldText;
    TextSelection resultSelection = oldSelection;

    if (oldValue.text.isEmpty) {
      final selectPosition = _getNextInputIndex(0, mask.length);
      if (_isValidForPosition(newText[0], selectPosition)) {
        _userInput.add(selectPosition);

        return TextEditingValue(
          text: _replaceCharAt(placeholder, selectPosition, newText[0]),
          selection: TextSelection.collapsed(
            offset: selectPosition + 1,
          ),
        );
      } else {
        return oldValue;
      }
    }

    if (newText.length > oldText.length) {
      if (_isComplete ||
          _userInput.contains(oldSelectionStart) ||
          (!_isDesignatedSpace(oldSelectionStart) &&
              !_isValidForPosition(
                newText[newSelectionStart - 1],
                newSelectionStart - 1,
              ))) {
        return oldValue;
      }

      if (_isDesignatedSpace(oldSelectionStart)) {
        final nextInputSpace =
            _getNextInputIndex(oldSelectionStart, mask.length);
        if (_isValidForPosition(
              newText[newSelectionStart - 1],
              nextInputSpace,
            ) &&
            !_userInput.contains(nextInputSpace)) {
          _userInput.add(nextInputSpace);
          _addMaskBefore(nextInputSpace - 1);
          resultText = _replaceCharAt(
            oldText,
            nextInputSpace,
            newText[newSelectionStart - 1],
          );
          resultSelection = TextSelection.collapsed(
            offset: _getNextInputIndex(nextInputSpace + 1, mask.length),
          );
        } else {
          resultSelection =
              TextSelection.fromPosition(TextPosition(offset: nextInputSpace));
        }
      } else {
        _userInput.add(oldSelectionStart);
        if (_isDesignatedSpace(oldSelectionStart - 1)) {
          _addMaskBefore(oldSelectionStart - 1);
        }

        resultText = _replaceCharAt(
          oldText,
          oldSelectionStart,
          newText[oldSelectionStart],
        );
        resultSelection = TextSelection.collapsed(
          offset: _getNextInputIndex(newSelectionStart, mask.length),
        );
      }
    } else if (newText.length < oldText.length) {
      if (_isValidInput(oldText[newSelectionStart])) {
        final start = oldSelectionStart == oldSelection.end
            ? newSelectionStart
            : oldSelectionStart;
        final end = oldSelectionStart == oldSelection.end
            ? newSelectionStart + 1
            : oldSelection.end;

        _userInput.removeWhere((value) => value >= start && value < end);
        if (_userInput.isEmpty) return TextEditingValue.empty;

        int selectionPosition = _getPreviousInputIndex(start);

        if (start - 1 >= 0 && _isDesignatedSpace(start - 1)) {
          _removeMaskBefore(start - 1);
          selectionPosition = _getPreviousInputIndex(start - 1) + 1;
        }

        resultText = _replaceCharAt(
          oldText,
          newSelectionStart,
          placeholder.substring(start, end),
        );

        resultSelection = TextSelection.collapsed(
          offset: selectionPosition,
        );
      } else if (_isDesignatedSpace(newSelectionStart)) {
        final prevInputSpace = _getPreviousInputIndex(newSelectionStart);
        if (_userInput.contains(prevInputSpace)) {
          _userInput.remove(prevInputSpace);
          resultText = _replaceCharAt(
            oldText,
            prevInputSpace,
            placeholder[prevInputSpace],
          );
        }
        resultSelection = TextSelection.collapsed(
          offset: _getPreviousInputIndex(newSelectionStart),
        );
      } else if (!_userInput.contains(newSelectionStart)) {
        resultSelection = newSelection;
      }
    } else {
      resultSelection = newSelection;
    }

    return TextEditingValue(
      text: resultText,
      selection: resultSelection,
    );
  }
}

enum _InputType { digits, letters, combined }

extension on _InputType {
  RegExp get allowed {
    switch (this) {
      case _InputType.digits:
        return RegExp(r'[0-9]');
      case _InputType.letters:
        return RegExp(r'[a-zA-Z]');
      case _InputType.combined:
        return RegExp(r'[a-zA-Z0-9]');
    }
  }
}

extension on String {
  _InputType get toInputType {
    if (contains('A') && contains('#')) {
      return _InputType.combined;
    } else if (contains('#')) {
      return _InputType.digits;
    } else {
      return _InputType.letters;
    }
  }
}

const _digitSymbol = '#';
const _letterSymbol = 'A';
