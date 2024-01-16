import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

typedef DateTimeFormatter = String Function(DateTime value);

class OptimusDateTimeField extends StatefulWidget {
  const OptimusDateTimeField({
    super.key,
    this.value,
    this.label,
    required this.onChanged,
    this.minDate,
    this.maxDate,
    this.error,
    required this.formatDateTime,
    this.isClearEnabled = false,
    this.placeholder,
    this.isEnabled = true,
  });

  final DateTime? value;
  final String? label;
  final ValueChanged<DateTime?> onChanged;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTimeFormatter formatDateTime;
  final String? error;
  final bool isClearEnabled;
  final String? placeholder;
  final bool isEnabled;

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

  void _handleTap() {
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

  void _handleInputChanged(String v) {
    if (v.isEmpty) {
      widget.onChanged(null);
    }
  }

  Color get _iconColor =>
      theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000t64;

  @override
  Widget build(BuildContext context) => OptimusInputField(
        controller: _controller,
        readOnly: true,
        onTap: _handleTap,
        error: widget.error,
        label: widget.label,
        isClearEnabled: _isClearVisible,
        isEnabled: widget.isEnabled,
        trailing: GestureDetector(
          onTap: _handleTap,
          child: Icon(
            OptimusIcons.calendar,
            size: 20,
            color: _iconColor,
          ),
        ),
        placeholder: widget.placeholder,
        onChanged: _handleInputChanged,
      );
}
