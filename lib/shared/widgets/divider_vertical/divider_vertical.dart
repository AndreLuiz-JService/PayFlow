import 'package:flutter/material.dart';
import 'package:projeto_nlw2/shared/themes/appcolors.dart';

class DividerVerticalWidget extends StatelessWidget {
  const DividerVerticalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: double.infinity,
      color: AppColors.stroke,
    );
  }
}
