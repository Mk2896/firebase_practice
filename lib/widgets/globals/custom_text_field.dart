import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.autofocus,
    this.bottomMargin,
    this.cursorColor,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorWidth,
    this.height,
    this.initialValue,
    this.isEnabled,
    this.isPassword,
    this.isReadonly,
    this.keyboardType,
    this.leftMargin,
    this.maxLength,
    this.passwordChar,
    this.rightMargin,
    this.textAlignment,
    this.textCapitalization,
    required this.textController,
    this.textDirection,
    this.textScrollController,
    this.topMargin,
    this.validationMethod,
    this.width,
    this.prefix,
    this.suffix,
    this.backgroundColor,
    this.errorText,
    this.isFilled,
    this.labelPosition,
    this.labelStyle,
    this.helperText,
    this.hintText,
    this.labelText,
  }) : super(key: key);

  final double? leftMargin;
  final double? rightMargin;
  final double? topMargin;
  final double? bottomMargin;
  final double? width;
  final double? height;
  final bool? autofocus;
  final TextEditingController textController;
  final ScrollController? textScrollController;
  final Color? cursorColor;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final double? cursorWidth;
  final bool? isReadonly;
  final bool? isEnabled;
  final String? initialValue;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool? isPassword;
  final String? passwordChar;
  final TextAlign? textAlignment;
  final TextCapitalization? textCapitalization;
  final TextDirection? textDirection;
  final String? Function(String?)? validationMethod;
  final Widget? prefix;
  final Widget? suffix;
  final String? errorText;
  final bool? isFilled;
  final Color? backgroundColor;
  final FloatingLabelBehavior? labelStyle;
  final FloatingLabelAlignment? labelPosition;
  final String? helperText;
  final String? labelText;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: leftMargin ?? 0,
        right: rightMargin ?? 0,
        top: topMargin ?? 0,
        bottom: bottomMargin ?? 0,
      ),
      width: width ?? MediaQuery.of(context).size.width,
      height: height,
      child: TextFormField(
        autofocus: autofocus ?? false,
        controller: textController,
        cursorColor: cursorColor,
        cursorHeight: cursorHeight,
        cursorRadius: cursorRadius,
        cursorWidth: cursorWidth ?? 2.0,
        enabled: isEnabled,
        initialValue: initialValue,
        keyboardType: keyboardType,
        maxLength: maxLength,
        obscureText: isPassword ?? false,
        obscuringCharacter: passwordChar ?? "*",
        readOnly: isReadonly ?? false,
        scrollController: textScrollController,
        textAlign: textAlignment ?? TextAlign.start,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        textDirection: textDirection,
        validator: validationMethod,
        decoration: InputDecoration(
          // TODO: Setup border according to desired theme
          // border:
          // disabledBorder: ,
          // enabledBorder: ,
          // errorBorder: ,
          // focusedBorder: ,
          prefixIcon: prefix,
          suffixIcon: suffix,
          errorText: errorText,
          filled: isFilled,
          fillColor: backgroundColor,
          floatingLabelBehavior: labelStyle,
          floatingLabelAlignment: labelPosition,
          helperText: helperText,
          hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }
}
