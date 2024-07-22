import 'package:flutter/material.dart';

import 'text_widget.dart';

class HTextfield extends StatelessWidget {
  final String? label;
  final TextEditingController textCtr;
  final String hintText;
  final String? Function(String?)? validate;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final Color? labelColor;
  final Color? fillColor;
  final EdgeInsetsGeometry? textFieldPadding;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? prefixText;
  final FocusNode? focusNode;
  final int? maxLines;
  final TextInputAction? textInputAction;
  const HTextfield(
      {this.label,
      required this.hintText,
      required this.textCtr,
      this.keyboardType,
      this.textFieldPadding,
      this.onFieldSubmitted,
      this.onEditingComplete,
      this.onTap,
      this.fillColor,
      this.validate,
      this.onChanged,
      this.prefixIcon,
      this.labelColor,
      this.suffixIcon,
      this.prefixText,
      this.focusNode,
      this.maxLines,
      this.textInputAction,
      this.obscureText = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
        padding: textFieldPadding ?? const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (label != null)
            TextWidget(
              title: label!,
              // fontWeight: FontWeight.w500,
              // fontSize: 8,
              textColor: (labelColor ?? const Color(0xff101828)),
            ),
          const SizedBox(
            height: 14,
          ),
          Container(
            height: size.height * 0.1,
            width: double.maxFinite,
            decoration: const BoxDecoration(
                // color:,
                ),
            child: TextFormField(
              focusNode: focusNode,
              onTap: onTap,
              obscureText: obscureText,
              keyboardType: keyboardType,
              controller: textCtr,
              validator: validate,
              onChanged: onChanged,
              maxLines: maxLines,
              onFieldSubmitted: onFieldSubmitted,
              onEditingComplete: onEditingComplete,
              textInputAction: textInputAction,
              style: const TextStyle(
                  fontFamily: 'Anton', color: Colors.white, fontSize: 12),
              decoration: InputDecoration(
                prefixText: prefixText,
                filled: true,
                fillColor:
                    fillColor ?? (const Color(0xFFE8EDF1).withOpacity(0.3)),
                hintStyle: const TextStyle(
                    // fontFamily: 'Anton',
                    color: Color(0xFF697D95),
                    fontSize: 12),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
                hintText: hintText,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
              ),
            ),
          )
        ]));
  }

  HTextfield copyWith(
          {String? label,
          String? hintText,
          TextEditingController? textCtr,
          Color? labelColor,
          EdgeInsetsGeometry? textFieldPadding,
          Color? fillColor}) =>
      HTextfield(
        label: label ?? this.label,
        hintText: hintText ?? this.hintText,
        textCtr: textCtr ?? this.textCtr,
        labelColor: labelColor ?? this.labelColor,
        textFieldPadding: textFieldPadding ?? this.textFieldPadding,
        fillColor: fillColor ?? this.fillColor,
      );
}
