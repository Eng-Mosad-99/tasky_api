
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg_flutter.dart';

class FloatingActionButtonItem extends StatelessWidget {
  const FloatingActionButtonItem({
    super.key,
    this.onPressed,
    required this.floatingImage,
    this.backgroundColor,
    this.size = 56,
    this.heroTag,
  });

  final void Function()? onPressed;
  final String floatingImage;
  final Color? backgroundColor;
  final double size;
final Object? heroTag;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: FloatingActionButton(
        heroTag: heroTag,
        backgroundColor: backgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
        ),
        onPressed: onPressed,
        child: SvgPicture.asset(floatingImage, width: size * 0.5),
      ),
    );
  }
}
