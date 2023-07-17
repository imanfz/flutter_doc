import 'package:flutter/material.dart';
import 'package:flutter_doc/presentation/widget/custom_text_field.dart';
import 'package:flutter_doc/presentation/widget/custom_text_form_field.dart';
import 'package:flutter_doc/presentation/widget/safe_button.dart';
import 'package:flutter_doc/utilities/extensions/context_ext.dart';
import 'package:flutter_doc/utilities/extensions/widget_ext.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.title ?? ''),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField.username(
                hint: AppLocalizations.of(context)?.hintUsername,
                required: true,
              ),
              CustomTextFormField.email(
                hint: AppLocalizations.of(context)?.hintEmail,
              ),
              CustomTextFormField.password(
                hint: AppLocalizations.of(context)?.hintPassword,
              ),
              SizedBox(
                height: 100,
              ),
              SafeButton.primary(label: 'Login', onPressed: () {
                if(_formKey.currentState?.validate() ?? false) {
                  
                }
              }),
            ],
          ),
        ),
      ).paddingAll(30),
    );
  }
}
