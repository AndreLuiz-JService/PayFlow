import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_nlw2/modules/barcode_scanner/barcode_scanner_page.dart';
import 'package:projeto_nlw2/modules/home/home_page.dart';
import 'package:projeto_nlw2/modules/insert_boleto/insert_boleto_page.dart';
import 'package:projeto_nlw2/modules/splash/splash_page.dart';
import 'package:projeto_nlw2/shared/models/user_model.dart';

import 'modules/login/login_page.dart';
import 'shared/themes/appcolors.dart';

class AppWidget extends StatelessWidget {
  AppWidget() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Flow',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: AppColors.primary,
      ),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => SplashPage(),
        "/home": (context) => HomePage(user: ModalRoute.of(context)!.settings.arguments as UserModel,),
        "/login": (context) => LoginPage(),
        "/barcode_scanner": (context) => BarcodeScannerPage(),
        "/insert_boleto": (context) => InsertBoletoPage(
          barcode: ModalRoute.of(context) != null ? ModalRoute.of(context)!.settings.arguments.toString() : null,
        ),
      },
    );
  }
}

class Login {}
