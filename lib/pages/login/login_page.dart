import 'package:flutter/material.dart';
import 'package:flutter_doc/core/widget/custom_text_field.dart';
import 'package:flutter_doc/core/widget/safe_button.dart';
import 'package:flutter_doc/core/utils/extensions/misc_ext.dart';
import 'package:flutter_doc/core/utils/extensions/widget_ext.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomTextField.username(
                label: AppLocalizations.of(context)?.labelUsername,
                hint: AppLocalizations.of(context)?.hintUsername,
                outlined: true,
                clearButtonEnabled: true,
              ),
              CustomTextField.email(
                hint: AppLocalizations.of(context)?.hintEmail,
                clearButtonEnabled: true,
              ),
              CustomTextField.phone(
                label: AppLocalizations.of(context)?.labelPhone,
                hint: AppLocalizations.of(context)?.hintPhone,
                clearButtonEnabled: true,
              ),
              CustomTextField.password(
                hint: AppLocalizations.of(context)?.hintPassword,
                strongPassword: true,
                onChanged: (value) => setState(() {
                  _password = value;
                }),
              ),
              CustomTextField.confirmPassword(
                password: _password,
                strongPassword: true,
                hint: AppLocalizations.of(context)?.hintConfirmPassword,
              ),
              SizedBox(
                height: 100,
              ),
              SafeButton.primary(
                  label: 'Login',
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {}
                  }),
            ].spaceBetween(height: 10, withFirst: true),
          ),
        ),
      ).paddingAll(30),
    );
  }
}
