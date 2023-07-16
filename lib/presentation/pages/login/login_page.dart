import 'package:flutter/material.dart';
import 'package:flutter_doc/presentation/widget/custom_text_field.dart';
import 'package:flutter_doc/utilities/extensions/context_ext.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField.primary(
              label: AppLocalizations.of(context)?.hintUsername,
              hint: AppLocalizations.of(context)?.hintUsername,
              errorText: AppLocalizations.of(context)?.errorUsername,
            ),
          ],
        ),
      ),
    );
  }
}
