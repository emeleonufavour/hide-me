import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'text_widget.dart';

class HButton extends StatefulWidget {
  const HButton(
      {super.key,
      required this.label,
      this.fct,
      required this.color,
      this.withWidth,
      this.width,
      this.borderColor,
      this.textColor,
      this.horizontalPadding,
      this.verticalPadding,
      this.icon,
      this.iconColor,
      this.isPrefixPresent = false,
      this.prefixWidget,
      this.buttonWidget});
  final String label;
  final VoidCallback? fct;
  final Color color;
  final bool? withWidth;
  final double? width;
  final Color? borderColor;
  final Color? textColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final IconData? icon;
  final Color? iconColor;
  final bool isPrefixPresent;
  final Widget? prefixWidget;
  final Widget? buttonWidget;

  @override
  State<HButton> createState() => _LButtonState();
}

class _LButtonState extends State<HButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: widget.fct,
      onTap: () {
        _controller.forward();
        HapticFeedback.lightImpact();
        Future.delayed(const Duration(milliseconds: 200), () {
          _controller.reverse();
          widget.fct!();
        });
      },
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 1.0,
          end: 0.9,
        ).animate(_controller),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          width: widget.width ?? double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: widget.horizontalPadding ?? 10,
            vertical: widget.verticalPadding ?? 14,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.color,
          ),
          child: widget.buttonWidget ??
              TextWidget(
                textAlign: TextAlign.center,
                title: widget.label,
                fontWeight: FontWeight.w700,
                fontSize: 15,
                textColor: widget.textColor ?? Colors.white,
              ),
        ),
      ),
    );
  }
}
