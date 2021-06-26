import 'package:flutter/material.dart';
import 'package:projeto_nlw2/shared/auth/auth_controller.dart';
import 'package:projeto_nlw2/shared/themes/app_images.dart';
import 'package:projeto_nlw2/shared/themes/appcolors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final authontroller = AuhtController();
    authontroller.currentUser(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Center(child: Image.asset(AppImages.union)),
          Center(child: Image.asset(AppImages.logoFull))
        ],
      ),
    );
  }
}
