import 'package:chatting_app/common/utils/app_color.dart';
import 'package:chatting_app/common/utils/app_font.dart';
import 'package:flutter/material.dart';

class AppInput extends StatefulWidget {
  final String hint;
  TextEditingController? controller;
  final Widget? prefixIcon;
  final bool? obscureText;
  final double? height;

  AppInput(
      {Key? key,
      required this.hint,
      this.controller,
      this.prefixIcon,
      this.obscureText,
      this.height})
      : super(key: key);

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 40,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText ?? false,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: AppFont.input.copyWith(
            color: AppColor.grey3,
          ),
          prefixIcon: widget.prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: AppColor.grey1,
            ),
          ),
        ),
      ),
    );
  }
}
