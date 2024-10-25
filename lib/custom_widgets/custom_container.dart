import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final bool? isThreeLine;
  final bool? isDense;
  final VisualDensity? visualDensity;
  final TextDirection? textDirection;
  final TextBaseline? titleBaselineType;
  final TextBaseline? subtitleBaselineType;
  final double? horizontalTitleGap;
  final double? minVerticalPadding;
  final double? minLeadingWidth;
  final double? minTileHeight;
  final ListTileTitleAlignment? titleAlignment;
  final double? horizontalPadding;
  final double? minHorizontalPadding;
  final Color? cardColor;
  final BoxBorder? border;

  const CustomCard({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.isDense,
    this.visualDensity,
    this.textDirection,
    this.titleBaselineType,
    this.horizontalTitleGap = 16.0,
    this.minVerticalPadding,
    this.minLeadingWidth = 40.0,
    this.minTileHeight = 48.0,
    this.subtitleBaselineType,
    this.titleAlignment,
    this.horizontalPadding = 16.0,
    this.minHorizontalPadding = 8.0,
    this.cardColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: border,
        color: cardColor ?? Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.symmetric(
        vertical: minVerticalPadding ?? (isDense == true ? 8.0 : 16.0),
        horizontal: horizontalPadding != null &&
                horizontalPadding! >= minHorizontalPadding!
            ? horizontalPadding!
            : minHorizontalPadding!,
      ),
      constraints: BoxConstraints(
        minHeight: minTileHeight!,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: textDirection,
        children: [
          if (leading != null)
            Container(
              constraints: BoxConstraints(
                minWidth: minLeadingWidth!,
              ),
              child: leading,
            ),
          SizedBox(width: horizontalTitleGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        textBaseline:
                            titleBaselineType ?? TextBaseline.alphabetic,
                      ),
                  child: title ?? Container(),
                ),
                if (subtitle != null || isThreeLine == true)
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          textBaseline:
                              subtitleBaselineType ?? TextBaseline.alphabetic,
                        ),
                    child: subtitle ?? Container(),
                  ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
