import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:projeto_nlw2/modules/login/login_controller.dart';
import 'package:projeto_nlw2/shared/themes/app_images.dart';
import 'package:projeto_nlw2/shared/themes/app_text_styles.dart';
import 'package:projeto_nlw2/shared/themes/appcolors.dart';
import 'package:projeto_nlw2/shared/widgets/social_login/social_login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Container(
              height: size.height * 0.38,
              width: size.width,
              color: AppColors.primary,
            ),
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Image.asset(
                AppImages.person,
                height: size.height * 0.5,
              ),
            ),
            Positioned(
              top: 190,
              child: Container(
                height: 170,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: AnimatedCard(
                        direction: AnimatedCardDirection.right,
                        duration: Duration(seconds: 1),
                        child: Image.asset(
                          AppImages.iconeAdd,
                          height: 60,
                          width: 60,
                        ),
                      ),
                    ),
                    SizedBox(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 110.0),
                      child: AnimatedCard(
                        direction: AnimatedCardDirection.left,
                        duration: Duration(seconds: 1),
                        child: Image.asset(
                          AppImages.iconeList,
                          width: 60,
                          height: 60,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 420,
              left: 0,
              right: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.85),
                      spreadRadius: 10,
                      blurRadius: 15,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 445,
              left: 0,
              right: 0,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.9),
                      spreadRadius: 10,
                      blurRadius: 8,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: size.height * 0.08,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedCard(
                        duration: Duration(seconds: 1),
                        direction: AnimatedCardDirection.left,
                        child: Image.asset(
                          AppImages.logomini,
                          width: 90,
                        ),
                      ),
                    ],
                  ),
                  AnimatedCard(
                    duration: Duration(seconds: 1),
                    direction: AnimatedCardDirection.right,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 70.0, right: 70, top: 30),
                      child: Text(
                        "Organize seus boletos em um só lugar",
                        style: AppTextStyles.titleHome,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  AnimatedCard(
                    duration: Duration(seconds: 1),
                    direction: AnimatedCardDirection.left,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 40.0, right: 40, top: 40),
                      child: SocialLoginButton(
                        onTap: () => controller.googleSignIn(context),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
