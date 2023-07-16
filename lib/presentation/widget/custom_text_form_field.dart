import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doc/utilities/extensions/string_ext.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum _StyleEnum {
  primary,
  number,
  email,
  password,
  createPassword,
  confirmPassword,
  phone
}

class CustomTextFormField extends StatefulWidget {
  final IconData? icon;
  final String? label;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final String? textValue;
  final bool enabled;
  final bool outlined;
  final double? borderRadius;
  final String password;
  final bool strongPassword;
  final bool required;

  final _StyleEnum _styleEnum;

  const CustomTextFormField._({
    Key? key,
    this.icon,
    this.label,
    this.hint,
    this.onChanged,
    this.textValue,
    this.enabled = true,
    this.outlined = false,
    this.borderRadius,
    this.password = '',
    this.strongPassword = false,
    this.required = false,
    required _StyleEnum styleEnum,
  })  : _styleEnum = styleEnum,
        super(key: key);

  factory CustomTextFormField.primary({
    IconData? icon,
    String? label,
    String? hint,
    ValueChanged<String>? onChanged,
    String? errorText,
    String? textValue,
    bool enabled = true,
    bool outlined = false,
    double? borderRadius,
    bool required = false,
  }) {
    return CustomTextFormField._(
      icon: icon,
      label: label,
      hint: hint,
      onChanged: onChanged,
      textValue: textValue,
      enabled: enabled,
      outlined: outlined,
      borderRadius: borderRadius,
      required: required,
      styleEnum: _StyleEnum.primary,
    );
  }

  factory CustomTextFormField.number({
    IconData? icon,
    String? label,
    String? hint,
    ValueChanged<String>? onChanged,
    String? errorText,
    String? textValue,
    bool enabled = true,
    bool outlined = false,
    double? borderRadius,
    bool required = false,
  }) {
    return CustomTextFormField._(
      icon: icon,
      label: label,
      hint: hint,
      onChanged: onChanged,
      textValue: textValue,
      enabled: enabled,
      outlined: outlined,
      borderRadius: borderRadius,
      required: required,
      styleEnum: _StyleEnum.number,
    );
  }

  factory CustomTextFormField.email({
    IconData? icon,
    String? label,
    String? hint,
    ValueChanged<String>? onChanged,
    String? errorText,
    String? textValue,
    bool enabled = true,
    bool outlined = false,
    double? borderRadius,
    bool required = false,
  }) {
    return CustomTextFormField._(
      icon: icon,
      label: label,
      hint: hint,
      onChanged: onChanged,
      textValue: textValue,
      enabled: enabled,
      outlined: outlined,
      borderRadius: borderRadius,
      required: required,
      styleEnum: _StyleEnum.number,
    );
  }

  factory CustomTextFormField.password({
    IconData? icon,
    String? label,
    String? hint,
    ValueChanged<String>? onChanged,
    String? errorText,
    String? textValue,
    bool enabled = true,
    bool outlined = false,
    double? borderRadius,
    bool strongPassword = false,
  }) {
    return CustomTextFormField._(
      icon: icon,
      label: label,
      hint: hint,
      onChanged: onChanged,
      textValue: textValue,
      enabled: enabled,
      outlined: outlined,
      borderRadius: borderRadius,
      required: true,
      strongPassword: strongPassword,
      styleEnum: _StyleEnum.password,
    );
  }

  factory CustomTextFormField.createPassword({
    IconData? icon,
    String? label,
    String? hint,
    ValueChanged<String>? onChanged,
    String? errorText,
    String? textValue,
    bool enabled = true,
    bool outlined = false,
    double? borderRadius,
    bool strongPassword = false,
  }) {
    return CustomTextFormField._(
      icon: icon,
      label: label,
      hint: hint,
      onChanged: onChanged,
      textValue: textValue,
      enabled: enabled,
      outlined: outlined,
      borderRadius: borderRadius,
      strongPassword: strongPassword,
      styleEnum: _StyleEnum.password,
    );
  }

  factory CustomTextFormField.confirmPassword({
    IconData? icon,
    String? label,
    String? hint,
    ValueChanged<String>? onChanged,
    String? errorText,
    String? textValue,
    bool enabled = true,
    bool outlined = false,
    double? borderRadius,
    bool strongPassword = false,
    required String password,
  }) {
    return CustomTextFormField._(
      icon: icon,
      label: label,
      hint: hint,
      onChanged: onChanged,
      textValue: textValue,
      enabled: enabled,
      outlined: outlined,
      borderRadius: borderRadius,
      strongPassword: strongPassword,
      password: password,
      styleEnum: _StyleEnum.confirmPassword,
    );
  }

  factory CustomTextFormField.phone({
    IconData? icon,
    String? label,
    String? hint,
    ValueChanged<String>? onChanged,
    String? errorText,
    String? textValue,
    bool enabled = true,
    bool outlined = false,
    double? borderRadius,
    bool required = false,
  }) {
    return CustomTextFormField._(
      icon: icon,
      label: label,
      hint: hint,
      onChanged: onChanged,
      textValue: textValue,
      enabled: enabled,
      outlined: outlined,
      borderRadius: borderRadius,
      required: required,
      styleEnum: _StyleEnum.phone,
    );
  }

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final FocusNode _focusNode = FocusNode();
  // bool _hasFocus = false;
  late TextEditingController _textEditingController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        // _hasFocus = _focusNode.hasFocus;
      });
    });
    _textEditingController = TextEditingController(text: widget.textValue);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final InputDecoration inputDecortion = InputDecoration(
      prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
      labelText: widget.label,
      hintText: widget.hint,
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
        return TextFormField(
          enabled: widget.enabled,
          controller: _textEditingController,
          focusNode: _focusNode,
          validator: (value) {
            if (widget.required && value?.isBlank == true) {
              return AppLocalizations.of(context)?.requiredField;
            }
            return null;
          },
          onChanged: widget.onChanged,
          decoration: inputDecortion,
        );
      case _StyleEnum.number:
        inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
        return TextFormField(
          enabled: widget.enabled,
          controller: _textEditingController,
          focusNode: _focusNode,
          validator: (value) {
            if (widget.required && value?.isBlank == true) {
              return AppLocalizations.of(context)?.requiredField;
            }
            return null;
          },
          onChanged: widget.onChanged,
          inputFormatters: inputFormatters,
          keyboardType: TextInputType.number,
          decoration: inputDecortion,
        );
      case _StyleEnum.email:
        return TextFormField(
          enabled: widget.enabled,
          controller: _textEditingController,
          focusNode: _focusNode,
          validator: (value) {
            if (widget.required && value?.isBlank == true) {
              return AppLocalizations.of(context)?.requiredField;
            } else if (value?.isValidEmail == false) {
              return AppLocalizations.of(context)?.errorEmail;
            }
            return null;
          },
          onChanged: widget.onChanged,
          keyboardType: TextInputType.emailAddress,
          decoration: inputDecortion,
        );
      case _StyleEnum.password:
        return TextFormField(
          enabled: widget.enabled,
          controller: _textEditingController,
          focusNode: _focusNode,
          validator: (value) {
            if (widget.required) {
              return AppLocalizations.of(context)?.requiredField;
            } else if (value?.isBlank == true) {
              return AppLocalizations.of(context)?.errorPassword;
            }
            return null;
          },
          onChanged: widget.onChanged,
          keyboardType: TextInputType.visiblePassword,
          decoration: inputDecortion.copyWith(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              icon: _obscurePassword
                  ? const Icon(Icons.visibility_outlined)
                  : const Icon(Icons.visibility_off_outlined),
            ),
          ),
        );
      case _StyleEnum.createPassword:
        return TextFormField(
          enabled: widget.enabled,
          controller: _textEditingController,
          focusNode: _focusNode,
          validator: (value) {
            if (value?.isBlank == true) {
              return AppLocalizations.of(context)?.errorPassword;
            } else if (widget.strongPassword &&
                value?.isValidStrongPassword == false) {
              return AppLocalizations.of(context)?.errorStrongPassword;
            } else if (value?.isValidPassword == false) {
              return AppLocalizations.of(context)?.errorRequiredPassword;
            }
            return null;
          },
          onChanged: widget.onChanged,
          keyboardType: TextInputType.visiblePassword,
          decoration: inputDecortion.copyWith(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              icon: _obscurePassword
                  ? const Icon(Icons.visibility_outlined)
                  : const Icon(Icons.visibility_off_outlined),
            ),
          ),
        );
      case _StyleEnum.confirmPassword:
        return TextFormField(
          enabled: widget.enabled,
          controller: _textEditingController,
          focusNode: _focusNode,
          validator: (value) {
            if (value?.isBlank == true) {
              return AppLocalizations.of(context)?.errorPassword;
            } else if (widget.strongPassword &&
                value?.isValidStrongPassword == false) {
              return AppLocalizations.of(context)?.errorStrongPassword;
            } else if (value?.isValidPassword == false) {
              return AppLocalizations.of(context)?.errorRequiredPassword;
            } else if (value != widget.password) {
              return AppLocalizations.of(context)?.errorPasswordNotSame;
            }
            return null;
          },
          onChanged: widget.onChanged,
          keyboardType: TextInputType.visiblePassword,
          decoration: inputDecortion.copyWith(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              icon: _obscurePassword
                  ? const Icon(Icons.visibility_outlined)
                  : const Icon(Icons.visibility_off_outlined),
            ),
          ),
        );
      case _StyleEnum.phone:
        return TextFormField();
    }
  }
}
