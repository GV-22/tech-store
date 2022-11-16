import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/form_item.dart';
import '../../utils/ui.dart';

class FTextField extends StatelessWidget {
  final TextInputType inputType;
  final FormItem formItem;
  final TextAlign textAlign;
  final String? label;
  final String? hintText;
  final int? minLines;
  final Widget? prefixIcon;

  const FTextField({
    required this.inputType,
    required this.formItem,
    this.label,
    this.hintText,
    this.minLines,
    this.textAlign = TextAlign.start,
    this.prefixIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!.toUpperCase(),
            style: TextStyle(
              color: grey400Color,
              fontSize: isMobile ? 14 : 18,
            ),
          ),
          const SizedBox(height: 12),
        ],
        TextFormField(
          onChanged: (val) {
            formItem.value = val;
          },
          keyboardType: inputType,
          initialValue: formItem.value,
          validator: formItem.validator,
          textInputAction: TextInputAction.next,
          textAlign: textAlign,
          minLines: minLines,
          maxLines: minLines,
          inputFormatters: inputType == TextInputType.number
              ? [FilteringTextInputFormatter.digitsOnly]
              : [],
          decoration: formInputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            verticalPadding: minLines == null ? 0.0 : 12.0,
          ),
        )
      ],
    );
  }
}
