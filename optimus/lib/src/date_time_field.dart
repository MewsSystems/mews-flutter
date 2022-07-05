import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

typedef DateTimeFormatter = String Function(DateTime);

class OptimusDateTimeField extends StatefulWidget {
  const OptimusDateTimeField({
    Key? key,
    this.value,
    this.label,
    required this.onChanged,
    this.minDate,
    this.maxDate,
    this.error,
    required this.formatDateTime,
    this.isClearEnabled = false,
    this.placeholder,
  }) : super(key: key);

  final DateTime? value;
  final String? label;
  final ValueChanged<DateTime?> onChanged;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTimeFormatter formatDateTime;
  final String? error;
  final bool isClearEnabled;
  final String? placeholder;

  @override
  State<OptimusDateTimeField> createState() => _OptimusDateTimeFieldState();
}

class _OptimusDateTimeFieldState extends State<OptimusDateTimeField>
    with ThemeGetter {
  final TextEditingController _controller = TextEditingController();
  bool _isClearVisible = false;

  @override
  void initState() {
    super.initState();
    _updateValue();
  }

  @override
  void didUpdateWidget(OptimusDateTimeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateValue();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateValue() {
    final value = widget.value;
    _controller.value = _controller.value.copyWith(
      text: value == null ? '' : widget.formatDateTime(value),
    );
    _isClearVisible = value != null && widget.isClearEnabled;
  }

  void _showPickerDialog() {
    FocusScope.of(context).requestFocus(FocusNode());
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => CupertinoDatePicker(
        onDateTimeChanged: widget.onChanged,
        initialDateTime: widget.value,
        minimumDate: widget.minDate,
        maximumDate: widget.maxDate,
      ),
    );
  }

  void _onInputChanged(String v) {
    if (v.isEmpty) {
      widget.onChanged(null);
    }
  }

  @override
  Widget build(BuildContext context) => OptimusInputField(
        controller: _controller,
        readOnly: true,
        onTap: _showPickerDialog,
        error: widget.error,
        label: widget.label,
        isClearEnabled: _isClearVisible,
        tailingWidget: GestureDetector(
          onTap: _showPickerDialog,
          child: Icon(
            OptimusIcons.calendar,
            size: 20,
            color: theme.colors.neutral1000,
          ),
        ),
        placeholder: widget.placeholder,
        onChanged: _onInputChanged,
      );
}
