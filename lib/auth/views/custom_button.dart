import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final bool isDisabled;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final double width;
  final Widget? child;
  final String? prefixIconPath;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BorderSide? borderSide;
  final bool centerText;
  final String? backgroundImagePath;
  final bool spaceBetweenPrefix;
  final bool spaceBetweenSuffix;
  final double? suffixIconHeight;
  final double? suffixIconWidth;
  final double? prefixIconHeight;
  final double? prefixIconWidth;
  final List<String>? dropdownItems;
  final String? selectedDropdownValue;
  final ValueChanged<String?>? onDropdownChanged;

  const CustomButton({
    super.key,
    this.text,
    this.isDisabled = false,
    this.onPressed,
    this.backgroundColor = const Color(0xFFA16DB6),
    this.textColor = Colors.white,
    this.borderRadius = 20,
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
    this.height = 50,
    this.width = double.infinity,
    this.child,
    this.prefixIconPath,
    this.prefixIcon,
    this.suffixIcon,
    this.borderSide,
    this.centerText = false,
    this.backgroundImagePath,
    this.spaceBetweenPrefix = false,
    this.spaceBetweenSuffix = false,
    this.suffixIconHeight,
    this.suffixIconWidth,
    this.prefixIconHeight,
    this.prefixIconWidth,
    this.dropdownItems,
    this.selectedDropdownValue,
    this.onDropdownChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundImagePath == null ? backgroundColor : null,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderSide != null
            ? Border.all(
                color: borderSide!.color,
                width: borderSide!.width,
                style: borderSide!.style,
              )
            : null,
        image: backgroundImagePath != null
            ? DecorationImage(
                image: AssetImage(backgroundImagePath!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: dropdownItems != null
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedDropdownValue ?? dropdownItems!.first,
                  icon:
                      suffixIcon ??
                      Icon(Icons.arrow_drop_down, color: textColor),
                  dropdownColor: backgroundColor,
                  onChanged: onDropdownChanged,
                  items: dropdownItems!.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: fontWeight,
                          color: textColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          : InkWell(
              onTap: isDisabled ? null : onPressed,
              borderRadius: BorderRadius.circular(borderRadius),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child:
                    child ??
                    (centerText
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              if (prefixIcon != null || prefixIconPath != null)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      prefixIcon ??
                                          Image.asset(
                                            prefixIconPath!,
                                            height: prefixIconHeight ?? 18,
                                            width: prefixIconWidth ?? 18,
                                          ),
                                    ],
                                  ),
                                ),
                              Center(
                                child: Text(
                                  text!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: fontWeight,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              if (suffixIcon != null)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    height: suffixIconHeight ?? 24,
                                    width: suffixIconWidth ?? 24,
                                    child: suffixIcon!,
                                  ),
                                ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment:
                                (spaceBetweenPrefix || spaceBetweenSuffix)
                                ? MainAxisAlignment.spaceBetween
                                : MainAxisAlignment.center,
                            children: [
                              // LEFT SIDE: prefixIcon + text
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (prefixIcon != null ||
                                      prefixIconPath != null)
                                    prefixIcon ??
                                        Image.asset(
                                          prefixIconPath!,
                                          height: prefixIconHeight ?? 24,
                                          width: prefixIconWidth ?? 24,
                                        ),
                                  if (prefixIcon != null ||
                                      prefixIconPath != null)
                                    SizedBox(width: 8),
                                  Text(
                                    text!,
                                    style: TextStyle(
                                      fontSize: fontSize,
                                      fontWeight: fontWeight,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),

                              // RIGHT SIDE: suffixIcon
                              if (suffixIcon != null && spaceBetweenSuffix)
                                SizedBox(
                                  height: suffixIconHeight ?? 24,
                                  width: suffixIconWidth ?? 24,
                                  child: suffixIcon!,
                                )
                              else if (suffixIcon != null)
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: SizedBox(
                                    height: suffixIconHeight ?? 24,
                                    width: suffixIconWidth ?? 24,
                                    child: suffixIcon!,
                                  ),
                                ),
                            ],
                          )),
              ),
            ),
    );
  }
}
