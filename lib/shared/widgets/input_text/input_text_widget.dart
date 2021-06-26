import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:projeto_nlw2/shared/themes/app_text_styles.dart';
import 'package:projeto_nlw2/shared/themes/appcolors.dart';

class InputTextWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;

  const InputTextWidget({
    Key? key,
    required this.label,
    required this.icon,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      duration: Duration(seconds: 1),

      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(bottom: 16)),
          TextFormField(
            style: AppTextStyles.input,
            initialValue: initialValue,
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onChanged: onChanged,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                labelText: label,
                labelStyle: AppTextStyles.input,
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Icon(
                        icon,
                        color: AppColors.primary,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 48,
                      color: AppColors.stroke,
                    )
                  ],
                )),
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: AppColors.stroke,
          ),
        ],
      ),
    );
  }
}
