import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

typedef DateTimeFormatter = String Function(DateTime);

class OptimusDateTimeField extends StatefulWidget {
  const OptimusDateTimeField({
    Key key,
    this.value,
    this.label,
    this.onChanged,
    this.minDate,
    this.maxDate,
    this.error,
    @required this.formatDateTime,
  }) : super(key: key);

  final DateTime value;
  final String label;
  final ValueChanged<DateTime> onChanged;
  final DateTime minDate;
  final DateTime maxDate;
  final DateTimeFormatter formatDateTime;
  final String error;

  @override
  _OptimusDateTimeFieldState createState() => _OptimusDateTimeFieldState();
}

class _OptimusDateTimeFieldState extends State<OptimusDateTimeField> {
  final TextEditingController _controller = TextEditingController();

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

  void _updateValue() {
    _controller.value = _controller.value.copyWith(
      text: widget.value == null ? '' : widget.formatDateTime(widget.value),
    );
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

  @override
  Widget build(BuildContext context) => OptimusInputField(
        controller: _controller,
        readOnly: true,
        onTap: _showPickerDialog,
        error: widget.error,
        label: widget.label,
      );
}
