import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doc/core/utils/extensions/string_ext.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum _StyleEnum {
  primary,
  number,
  username,
  email,
  password,
  confirmPassword,
  phone
}

class CustomTextField extends StatefulWidget {
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
  final bool specialChar;
  final bool required;
  final bool clearButtonEnabled;
  final FloatingLabelBehavior? floatingLabelBehavior;

  final _StyleEnum _styleEnum;

  const CustomTextField._({
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
    this.specialChar = false,
    this.required = false,
    this.clearButtonEnabled = false,
    this.floatingLabelBehavior,
    required _StyleEnum styleEnum,
  })  : _styleEnum = styleEnum,
        super(key: key);

  factory CustomTextField.primary({
    IconData? icon,
    String? label,
    String? hint,
    ValueChanged<String>? onChanged,
    String? textValue,
    bool enabled = true,
    bool outlined = false,
    double? borderRadius,
    bool required = false,
    bool clearButtonEnabled = false,
    FloatingLabelBehavior? floatingLabelBehavior,
  }) {
    return CustomTextField._(
      icon: icon,
      label: label,
      hint: hint,
      onChanged: onChanged,
      textValue: textValue,
      enabled: enabled,
      outlined: outlined,
      borderRadius: borderRadius,
      required: required,
      clearButtonEnabled: clearButtonEnabled,
      floatingLabelBehavior: floatingLabelBehavior,
      styleEnum: _StyleEnum.primary,
    );
  }

  factory CustomTextField.number({
    IconData? icon,
    String? label,
    String? hint,
    ValueChanged<String>? onChanged,
    String? textValue,
    bool enabled = true,
    bool outlined = false,
    double? borderRadius,
    bool required = false,
    bool clearButtonEnabled = false,
    FloatingLabelBehavior? floatingLabelBehavior,
  }) {
    return CustomTextField._(
      icon: icon,
      label: label,
      hint: hint,
      onChanged: onChanged,
      textValue: textValue,
      enabled: enabled,
      outlined: outlined,
      borderRadius: borderRadius,
      required: required,
      clearButtonEnabled: clearButtonEnabled,
      floatingLabelBehavior: floatingLabelBehavior,
      styleEnum: _StyleEnum.number,
    );
  }

  factory CustomTextField.username({
    IconData? icon,
    String? label,
    String? hint,
    ValueChanged<String>? onChanged,
    String? textValue,
    bool enabled = true,
    bool outlined = false,
    double? borderRadius,
    bool required = false,
    bool clearButtonEnabled = false,
    FloatingLabelBehavior? floatingLabelBehavior,
  }) {
    return CustomTextField._(
      icon: icon,
      label: label,
      hint: hint,
      onChanged: onChanged,
      textValue: textValue,
      enabled: enabled,
      outlined: outlined,
      borderRadius: borderRadius,
      required: required,
      clearButtonEnabled: clearButtonEnabled,
      floatingLabelBehavior: floatingLabelBehavior,
      styleEnum: _StyleEnum.username,
    );
  }

  factory CustomTextField.email({
    IconData? icon,
    String? label,
    String? hint,
    ValueChanged<String>? onChanged,
    String? textValue,
    bool enabled = true,
    bool outlined = false,
    double? borderRadius,
    bool required = false,
    bool clearButtonEnabled = false,
    FloatingLabelBehavior? floatingLabelBehavior,
  }) {
    return CustomTextField._(
      icon: icon,
      label: label,
      hint: hint,
      onChanged: onChanged,
      textValue: textValue,
      enabled: enabled,
      outlined: outlined,
      borderRadius: borderRadius,
      required: required,
      clearButtonEnabled: clearButtonEnabled,
      floatingLabelBehavior: floatingLabelBehavior,
      styleEnum: _StyleEnum.email,
    );
  }

  factory CustomTextField.password({
    IconData? icon,
    String? label,
    String? hint,
    ValueChanged<String>? onChanged,
    String? textValue,
    bool enabled = true,
    bool outlined = false,
    double? borderRadius,
    bool strongPassword = false,
    bool specialChar = false,
    FloatingLabelBehavior? floatingLabelBehavior,
  }) {
    return CustomTextField._(
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
      specialChar: specialChar,
      floatingLabelBehavior: floatingLabelBehavior,
      styleEnum: _StyleEnum.password,
    );
  }

  factory CustomTextField.confirmPassword({
    IconData? icon,
    String? label,
    String? hint,
    ValueChanged<String>? onChanged,
    String? textValue,
    bool enabled = true,
    bool outlined = false,
    double? borderRadius,
    bool strongPassword = false,
    bool specialChar = false,
    FloatingLabelBehavior? floatingLabelBehavior,
    required String password,
  }) {
    return CustomTextField._(
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
      specialChar: specialChar,
      password: password,
      floatingLabelBehavior: floatingLabelBehavior,
      styleEnum: _StyleEnum.confirmPassword,
    );
  }

  factory CustomTextField.phone({
    IconData? icon,
    String? label,
    String? hint,
    ValueChanged<String>? onChanged,
    String? textValue,
    bool enabled = true,
    bool outlined = false,
    double? borderRadius,
    bool required = false,
    bool clearButtonEnabled = false,
    FloatingLabelBehavior? floatingLabelBehavior,
  }) {
    return CustomTextField._(
      icon: icon,
      label: label,
      hint: hint,
      onChanged: onChanged,
      textValue: textValue,
      enabled: enabled,
      outlined: outlined,
      borderRadius: borderRadius,
      required: required,
      clearButtonEnabled: clearButtonEnabled,
      floatingLabelBehavior: floatingLabelBehavior,
      styleEnum: _StyleEnum.phone,
    );
  }

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _fieldKey = GlobalKey<FormFieldState>();
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;
  late TextEditingController _textEditingController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
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
    final InputDecoration _inputDecortion = InputDecoration(
      prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
      labelText: widget.label,
      hintText: widget.hint,
      errorMaxLines: 2,
      floatingLabelBehavior: widget.floatingLabelBehavior,
      border: widget.outlined
          ? OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadius ?? 4.0)),
            )
          : UnderlineInputBorder(),
    );

    final _inputDecorationClearEnabled = _inputDecortion.copyWith(
      suffixIcon: IconButton(
        onPressed: () {
          _textEditingController.clear();
        },
        icon: Icon(Icons.clear),
      ),
    );

    final _inputDecorationPassword = _inputDecortion.copyWith(
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
        icon: _obscurePassword
            ? const Icon(Icons.visibility_rounded)
            : const Icon(Icons.visibility_off_rounded),
      ),
    );

    final _inputDecorationFinal = _hasFocus && widget.clearButtonEnabled
        ? _inputDecorationClearEnabled
        : _inputDecortion;

    List<TextInputFormatter> _inputFormatters = <TextInputFormatter>[];

    switch (widget._styleEnum) {
      case _StyleEnum.primary:
        return TextFormField(
          key: _fieldKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
          decoration: _inputDecorationFinal,
        );
      case _StyleEnum.number:
        _inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
        return TextFormField(
          key: _fieldKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
          inputFormatters: _inputFormatters,
          keyboardType: TextInputType.number,
          decoration: _inputDecorationFinal,
        );
      case _StyleEnum.username:
        return TextFormField(
          key: _fieldKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enabled: widget.enabled,
          controller: _textEditingController,
          focusNode: _focusNode,
          validator: (value) {
            if (widget.required && value?.isBlank == true) {
              return AppLocalizations.of(context)?.requiredField;
            } else if (value?.isValidUsername == false) {
              return AppLocalizations.of(context)?.errorUsername;
            }
            return null;
          },
          onChanged: widget.onChanged,
          keyboardType: TextInputType.name,
          decoration: _inputDecorationFinal,
        );
      case _StyleEnum.email:
        return TextFormField(
          key: _fieldKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
          decoration: _inputDecorationFinal,
        );
      case _StyleEnum.password:
        return TextFormField(
          key: _fieldKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: _obscurePassword,
          enabled: widget.enabled,
          controller: _textEditingController,
          focusNode: _focusNode,
          validator: (value) {
            if (widget.required && value?.isBlank == true) {
              return AppLocalizations.of(context)?.requiredField;
            } else if (widget.strongPassword && widget.specialChar &&
                  value?.isValidStrongPasswordWithSpecialChar == false) {
              return '${AppLocalizations.of(context)?.errorPassword}. ${AppLocalizations.of(context)?.errorStrongPasswordWithSpecialChar}';
            } else if (widget.strongPassword && value?.isValidStrongPassword == false) {
              return '${AppLocalizations.of(context)?.errorPassword}. ${AppLocalizations.of(context)?.errorStrongPassword}';
            } else if (value?.isValidWeakPassword == false) {
              return AppLocalizations.of(context)?.errorPassword;
            }
            return null;
          },
          onChanged: widget.onChanged,
          keyboardType: TextInputType.visiblePassword,
          decoration: _inputDecorationPassword,
        );
      case _StyleEnum.confirmPassword:
        return TextFormField(
          key: _fieldKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: _obscurePassword,
          enabled: widget.enabled,
          controller: _textEditingController,
          focusNode: _focusNode,
          validator: (value) {
            if (widget.required && value?.isBlank == true) {
              return AppLocalizations.of(context)?.requiredField;
            } else if (widget.strongPassword && widget.specialChar &&
                  value?.isValidStrongPasswordWithSpecialChar == false) {
              return '${AppLocalizations.of(context)?.errorPassword}. ${AppLocalizations.of(context)?.errorStrongPasswordWithSpecialChar}';
            } else if (widget.strongPassword && value?.isValidStrongPassword == false) {
              return '${AppLocalizations.of(context)?.errorPassword}. ${AppLocalizations.of(context)?.errorStrongPassword}';
            } else if (value?.isValidWeakPassword == false) {
              return AppLocalizations.of(context)?.errorPassword;
            } else if (value != widget.password) {
              return AppLocalizations.of(context)?.errorPasswordNotSame;
            }
            return null;
          },
          onChanged: widget.onChanged,
          keyboardType: TextInputType.visiblePassword,
          decoration: _inputDecorationPassword,
        );
      case _StyleEnum.phone:
        _inputFormatters.addAll([
          FilteringTextInputFormatter.digitsOnly,
          TextInputFormatter.withFunction((oldValue, newValue) {
            final text = newValue.text.trim();
            if (text.length > 1 && text.isNotBlank) {
              if (text[0] == '0') {
                return newValue.copyWith(
                  text: text.replaceFirst('0', '62'),
                  selection: TextSelection.collapsed(
                    offset: newValue.selection.end + 1,
                  ),
                );
              }
            }
            return newValue.copyWith(text: text);
          })
        ]);
        return TextFormField(
          key: _fieldKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enabled: widget.enabled,
          controller: _textEditingController,
          focusNode: _focusNode,
          validator: (value) {
            if (widget.required && value?.isBlank == true) {
              return AppLocalizations.of(context)?.requiredField;
            } else if (value?.isValidPhoneNumber == false) {
              return 'Please enter the correct phone numbger';
            }
            return null;
          },
          onChanged: widget.onChanged,
          inputFormatters: _inputFormatters,
          keyboardType: TextInputType.phone,
          decoration: _inputDecorationFinal,
        );
    }
  }
}
