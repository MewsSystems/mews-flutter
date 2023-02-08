import 'package:flutter/services.dart';

/// TextInputFormatter that will format the input according to the given mask.
///
/// DateFormatter will force the input to follow the mask and will fill the
/// empty spaces with the placeholder.
class DateFormatter extends TextInputFormatter {
  DateFormatter({
    required this.placeholder,
  });

  /// The placeholder to fill the empty spaces in the mask.
  ///
  /// Example: 'DD-MM-YYYY'
  final String placeholder;

  late final String _mask = placeholder.replaceAll(_maskRegExp, _digitSymbol);

  late final String _cleanMask = _mask.replaceAll(_nonDigitSymbols, '');

  late final int _maxLength = placeholder.length;

  bool _isValidPosition(int position) => position <= _maxLength;

  bool _isComplete(String value) => _inputLength(value) == _cleanMask.length;

  bool _isDesignatedSpace(int index) =>
      index >= _mask.length ? false : _mask[index] != _digitSymbol;

  /// Returns the next index that should be filled by the user.
  int _getNextInputIndex(int index) {
    while (_isDesignatedSpace(index)) {
      if (index == _maxLength) return _maxLength;
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

  String _replaceCharAt(String value, int index, String replacement) =>
      value.substring(0, index) +
      replacement +
      (index == value.length - replacement.length
          ? ''
          : value.substring(index + replacement.length));

  TextEditingValue _pasteStarting(
    String value,
    int selectionStart,
    int selectionEnd,
    String replacement,
  ) {
    final cleanInput = replacement.clean;
    int resultIndex = selectionStart;

    if (cleanInput.isNotEmpty) {
      int newInputPosition = 0;
      while (newInputPosition < cleanInput.length) {
        if (resultIndex >= placeholder.length) break;
        if (!_isDesignatedSpace(resultIndex)) {
          final post = resultIndex >= selectionEnd
              ? value.substring(resultIndex, value.length - 1)
              : value.substring(resultIndex + 1);
          value = value.substring(0, resultIndex) +
              cleanInput[newInputPosition] +
              post;
          newInputPosition++;
        }
        resultIndex++;
      }
    }

    if (resultIndex < selectionEnd) {
      value = value.substring(0, resultIndex) +
          placeholder.substring(resultIndex, selectionEnd) +
          value.substring(selectionEnd);
    }

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: resultIndex),
    );
  }

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

    String resultText = oldText;
    int resultSelection = oldSelectionStart;

    if (oldValue.text.isEmpty) {
      if (newText.clean.isEmpty) return oldValue;

      return _pasteStarting(placeholder, 0, placeholder.length, newText);
    } else if (oldSelection.end - oldSelection.start >= 1) {
      return _pasteStarting(
        oldText,
        oldSelectionStart,
        oldSelection.end,
        newText.substring(oldSelection.start, newSelection.end),
      );
    } else {
      if (newText.length > oldText.length) {
        if (_isComplete(oldText) ||
            !_isValidPosition(newSelectionStart) ||
            !_isValidDigit(newText[newSelectionStart - 1])) {
          return oldValue;
        }

        if (_isDesignatedSpace(oldSelectionStart)) {
          final nextInputSpace = _getNextInputIndex(oldSelectionStart);
          if (_isValidDigit(newText[newSelectionStart - 1]) &&
              !_isValidDigit(oldText[nextInputSpace])) {
            resultText = _replaceCharAt(
              oldText,
              nextInputSpace,
              newText[newSelectionStart - 1],
            );
            resultSelection = _getNextInputIndex(nextInputSpace + 1);
          } else {
            resultSelection = nextInputSpace;
          }
        } else {
          resultText = _replaceCharAt(
            oldText,
            oldSelectionStart,
            newText[oldSelectionStart],
          );
          resultSelection = _getNextInputIndex(newSelectionStart);
        }
      } else if (newText.length < oldText.length) {
        if (_isValidDigit(oldText[newSelectionStart])) {
          final start = oldSelectionStart == oldSelection.end
              ? newSelectionStart
              : oldSelectionStart;
          final end = oldSelectionStart == oldSelection.end
              ? newSelectionStart + 1
              : oldSelection.end;

          int selectionPosition = _getPreviousInputIndex(start);

          if (start - 1 >= 0 && _isDesignatedSpace(start - 1)) {
            selectionPosition = _getPreviousInputIndex(start - 1) + 1;
          }

          resultText = _replaceCharAt(
            oldText,
            newSelectionStart,
            placeholder.substring(start, end),
          );

          if (_inputLength(resultText) == 0) resultText = '';

          resultSelection = selectionPosition;
        } else if (_isDesignatedSpace(newSelectionStart)) {
          final prevInputSpace = _getPreviousInputIndex(newSelectionStart);
          if (_isValidDigit(oldText[prevInputSpace])) {
            resultText = _replaceCharAt(
              oldText,
              prevInputSpace,
              placeholder[prevInputSpace],
            );
          }
          resultSelection = _getPreviousInputIndex(newSelectionStart);
        } else if (!_isValidDigit(oldText[newSelectionStart])) {
          resultSelection = newSelectionStart;
        }
      } else {
        resultSelection = newSelectionStart;
      }
    }

    return TextEditingValue(
      text: resultText,
      selection: TextSelection.collapsed(offset: resultSelection),
    );
  }
}

extension on String {
  String get clean => replaceAll(_restrictedInput, '');
}

const _digitSymbol = '#';
final RegExp _allowedDigits = RegExp('[0-9]');
final RegExp _restrictedInput = RegExp('[^0-9]');
final RegExp _maskRegExp = RegExp('[a-zA-z]');
final RegExp _nonDigitSymbols = RegExp('[^$_digitSymbol]');

int _inputLength(String value) => _allowedDigits.allMatches(value).length;

bool _isValidDigit(String value) => _allowedDigits.hasMatch(value);
