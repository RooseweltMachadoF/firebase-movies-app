import 'package:firebase_movies_app/core/enums/size_enum.dart';
import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:flutter/material.dart';

class SizedBoxWidget extends StatelessWidget {
  final SizesEnum size;
  const SizedBoxWidget({this.size = SizesEnum.md,super.key});

  const SizedBoxWidget.xxxl({this.size = SizesEnum.xxxl,super.key});
  const SizedBoxWidget.xxl({this.size = SizesEnum.xxl,super.key});
  const SizedBoxWidget.xl({this.size = SizesEnum.xl,super.key});
  const SizedBoxWidget.lg({this.size = SizesEnum.lg,super.key});
  const SizedBoxWidget.md({this.size = SizesEnum.md,super.key});
  const SizedBoxWidget.sm({this.size = SizesEnum.sm,super.key});
  const SizedBoxWidget.xs({this.size = SizesEnum.xs,super.key});
  const SizedBoxWidget.xxs({this.size = SizesEnum.xxs,super.key});
  const SizedBoxWidget.xxxs({this.size = SizesEnum.xxxs,super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.getSize,
      width: size.getSize,
    );
  }
}