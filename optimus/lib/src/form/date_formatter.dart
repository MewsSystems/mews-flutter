import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// TextInputFormatter that will format the input according to the given mask.
///
/// DateFormatter will force the input to follow the mask and will fill the
/// empty spaces with the placeholder.
class DateFormatter extends TextInputFormatter {
  DateFormatter({
    required this.mask,
    required this.placeholder,
    required List<int> userInput,
    this.onUserInputChanged,
    this.allowedDigits,
  }) {
    _userInput = userInput;
    _buildMaskMap();
  }

  /// The mask to format the input.
  ///
  /// # - is a place designed for a digit. Any
  /// other character will be displayed as is.
  ///
  /// Example: '##-##-####'
  final String mask;

  /// The placeholder to fill the empty spaces in the mask.
  ///
  /// Example: 'DD-MM-YYYY'
  final String placeholder;

  /// Digits that are allowed to be entered by the user.
  final RegExp? allowedDigits;

  /// Map of indexes and the corresponding mask characters.
  final Map<int, String> _mask = {};

  /// Callback, when the user input changes.
  final VoidCallback? onUserInputChanged;

  /// List of indexes of the user input.
  ///
  /// Because the field is then filled with the placeholder, we need to keep
  /// track of the user input.
  late List<int> _userInput;

  /// Builds the map of indexes and the corresponding mask characters.
  void _buildMaskMap() {
    final StringBuffer buffer = StringBuffer();
    int sectionStart = 0;

    for (int i = 0; i < _maxLength;) {
      final symbol = mask[i];
      if (symbol != _digitSymbol) {
        buffer
          ..clear()
          ..write(symbol);
        sectionStart = i;
        String sequential = '';
        while (sequential != _digitSymbol && i < _maxLength) {
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

  int get _maxLength => mask.length;

  bool get _isComplete => _validInputLength == _getCleanMask.length;

  RegExp get _digitsRegExp => allowedDigits ?? RegExp(r'[0-9]');

  /// Returns the list of user input indexes that are not mask positions.
  int get _validInputLength =>
      _userInput.where((i) => !_isDesignatedSpace(i)).length;

  /// Return the placeholder without the mask characters.
  String get _getCleanMask {
    String result = placeholder;
    for (final char in _mask.values) {
      result = result.replaceAll(char, '');
    }

    return result;
  }

  /// Returns weather the given value is allowed to be at the given index.
  bool _isValidForPosition(String value, int position) {
    if (position >= mask.length) return false;

    if (mask[position] == _digitSymbol) {
      return _isValidDigit(value);
    } else {
      return false;
    }
  }

  bool _isValidDigit(String value) => _digitsRegExp.hasMatch(value);

  /// Returns true if the given index is a space designated by the mask.
  bool _isDesignatedSpace(int index) {
    for (final key in _mask.keys) {
      final length = _mask[key]?.length ?? 0;
      if (key <= index && index < key + length) {
        return true;
      }
    }

    return false;
  }

  /// Returns the next index that should be filled by the user.
  int _getNextInputIndex(int index, int max) {
    while (_isDesignatedSpace(index)) {
      if (index == max) return max;
      index++;
    }

    return index;
  }

  /// Returns the previous index that should be filled by the user.
  int _getPreviousInputIndex(int index) {
    while (_isDesignatedSpace(index)) {
      if (index == 0) return -1;
      index--;
    }

    return index;
  }

  /// Returns the list of indexes designated for the mask before the given
  /// index.
  List<int> _getMaskPositionsBeforeIndex(int index) {
    final int prevValue = _getPreviousInputIndex(index);
    final int start = prevValue + 1;
    final int length = _mask[start]?.length ?? -1;
    if (length == -1) return [];

    return List<int>.generate(length, (i) => start + i);
  }

  String _replaceCharAt(String value, int index, String replacement) =>
      value.substring(0, index) +
      replacement +
      (index == value.length - replacement.length
          ? ''
          : value.substring(index + replacement.length));

  /// Because the input is filled with the placeholder, the whole process is
  /// going to be something like this:
  /// oldValue = 'DD-MM-YYYY'
  /// newValue = '2DD-MM-YYYY'
  ///              ^ - will be removed
  /// result = '2D-MM-YYYY'
  /// or:
  /// oldValue = '23-05-2019'
  /// newValue = '23-05-201' <- we removed the last digit
  /// empty space will be filled with the placeholder
  /// result = '23-05-201Y'
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
    final oldInputLength = _userInput.length;

    String resultText = oldText;
    TextSelection resultSelection = oldSelection;

    if (oldValue.text.isEmpty) {
      final selectPosition = _getNextInputIndex(0, mask.length);
      if (_isValidForPosition(newText[0], selectPosition)) {
        _userInput.add(selectPosition);
        if (selectPosition - 1 >= 0 && _isDesignatedSpace(selectPosition - 1)) {
          _userInput.addAll(_getMaskPositionsBeforeIndex(selectPosition - 1));
        }
        resultText = _replaceCharAt(placeholder, selectPosition, newText[0]);
        resultSelection = TextSelection.collapsed(
          offset: selectPosition + 1,
        );
      } else {
        return oldValue;
      }
    } else {
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
            if (_userInput.isNotEmpty) onUserInputChanged?.call();
            _userInput
              ..addAll(_getMaskPositionsBeforeIndex(nextInputSpace - 1))
              ..add(nextInputSpace);
            resultText = _replaceCharAt(
              oldText,
              nextInputSpace,
              newText[newSelectionStart - 1],
            );
            resultSelection = TextSelection.collapsed(
              offset: _getNextInputIndex(nextInputSpace + 1, mask.length),
            );
          } else {
            resultSelection = TextSelection.fromPosition(
              TextPosition(offset: nextInputSpace),
            );
          }
        } else {
          _userInput.add(oldSelectionStart);
          if (_isDesignatedSpace(oldSelectionStart - 1)) {
            _userInput
                .addAll(_getMaskPositionsBeforeIndex(oldSelectionStart - 1));
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
        if (_isValidDigit(oldText[newSelectionStart])) {
          final start = oldSelectionStart == oldSelection.end
              ? newSelectionStart
              : oldSelectionStart;
          final end = oldSelectionStart == oldSelection.end
              ? newSelectionStart + 1
              : oldSelection.end;

          _userInput.removeWhere((value) => value >= start && value < end);
          if (_userInput.isEmpty) onUserInputChanged?.call();
          int selectionPosition = _getPreviousInputIndex(start);

          if (start - 1 >= 0 && _isDesignatedSpace(start - 1)) {
            _userInput
                .removeWhere(_getMaskPositionsBeforeIndex(start - 1).contains);
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
    }
    if (oldInputLength != _userInput.length) onUserInputChanged?.call();

    return TextEditingValue(
      text: resultText,
      selection: resultSelection,
    );
  }
}

const _digitSymbol = '#';
