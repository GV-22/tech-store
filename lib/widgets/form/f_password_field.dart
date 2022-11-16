import 'package:flutter/material.dart';

import '../../utils/form_item.dart';
import '../../utils/ui.dart';

enum PasswordStrength { weak, normal, hight }

class FPasswordField extends StatefulWidget {
  final String label;
  final FormItem formItem;
  final String? hintText;

  final Function(String)? onSubmitted;

  const FPasswordField({
    required this.label,
    required this.formItem,
    this.hintText,
    this.onSubmitted,
    Key? key,
  }) : super(key: key);

  @override
  State<FPasswordField> createState() => _FPasswordFieldState();
}

class _FPasswordFieldState extends State<FPasswordField> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label.toUpperCase(),
          style: TextStyle(
            color: grey400Color,
            fontSize: isMobile ? 14 : 18,
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          onFieldSubmitted: widget.onSubmitted,
          onChanged: (val) {
            widget.formItem.value = val;
          },
          obscureText: _hidePassword,
          obscuringCharacter: "*",
          keyboardType: TextInputType.text,
          initialValue: widget.formItem.value,
          validator: widget.formItem.validator,
          decoration: formInputDecoration(
            hintText: widget.hintText,
            suffixIcon: InkWell(
              child: Icon(
                _hidePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onTap: () => setState(() => _hidePassword = !_hidePassword),
            ),
          ),
        ),
      ],
    );
  }
}
