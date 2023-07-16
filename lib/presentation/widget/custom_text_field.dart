import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doc/utilities/extensions/string_ext.dart';

enum _StyleEnum { primary, number }

class CustomTextField extends StatefulWidget {
  final IconData? icon;
  final String? label;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final String? textValue;
  final bool enabled;
  final bool outlined;
  final double? borderRadius;
  final _StyleEnum _styleEnum;

  const CustomTextField._({
    Key? key,
    this.icon,
    this.label,
    this.hint,
    this.onChanged,
    this.errorText,
    this.textValue,
    this.enabled = true,
    this.outlined = false,
    this.borderRadius,
    required _StyleEnum styleEnum,
  })  : _styleEnum = styleEnum,
        super(key: key);

  factory CustomTextField.primary({
    IconData? icon,
    String? label,
    String? hint,
    ValueChanged<String>? onChanged,
    String? errorText,
    String? textValue,
    bool enabled = true,
    bool outlined = false,
    double? borderRadius,
  }) {
    return CustomTextField._(
      icon: icon,
      label: label,
      hint: hint,
      onChanged: onChanged,
      errorText: errorText,
      textValue: textValue,
      enabled: enabled,
      outlined: outlined,
      borderRadius: borderRadius,
      styleEnum: _StyleEnum.primary,
    );
  }

  factory CustomTextField.number({
    IconData? icon,
    String? label,
    String? hint,
    ValueChanged<String>? onChanged,
    String? errorText,
    String? textValue,
    bool enabled = true,
    bool outlined = false,
    double? borderRadius,
  }) {
    return CustomTextField._(
      icon: icon,
      label: label,
      hint: hint,
      onChanged: onChanged,
      errorText: errorText,
      textValue: textValue,
      enabled: enabled,
      outlined: outlined,
      borderRadius: borderRadius,
      styleEnum: _StyleEnum.number,
    );
  }

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.textValue);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final InputDecoration inputDecortion = InputDecoration(
      prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
      labelText: widget.label,
      hintText: widget.hint,
      errorText: widget.errorText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: widget.outlined
          ? OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadius ?? 4.0)))
          : UnderlineInputBorder(),
    );

    List<TextInputFormatter> inputFormatters = <TextInputFormatter>[];

    switch (widget._styleEnum) {
      case _StyleEnum.primary:
        return TextField(
          enabled: widget.enabled,
          controller: _textEditingController,
          onChanged: widget.onChanged,
          inputFormatters: inputFormatters,
          decoration: inputDecortion,
        );
      case _StyleEnum.number:
        inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
        return TextField(
          enabled: widget.enabled,
          controller: _textEditingController,
          onChanged: (value) {
            final newValue = value.number;
            if (newValue != value) {
              widget.onChanged?.call(newValue);
            }
          },
          inputFormatters: inputFormatters,
          keyboardType: TextInputType.number,
          decoration: inputDecortion,
        );
    }
  }
}
