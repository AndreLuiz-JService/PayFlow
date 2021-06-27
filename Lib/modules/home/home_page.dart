import 'package:flutter/material.dart';
import 'package:projeto_nlw2/modules/extract/extract_page.dart';
import 'package:projeto_nlw2/modules/meus_boletos_page/meus_boletos_page.dart';
import 'package:projeto_nlw2/shared/models/user_model.dart';
import 'package:projeto_nlw2/shared/themes/app_text_styles.dart';
import 'package:projeto_nlw2/shared/themes/appcolors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  confirmationPopup(
    BuildContext dialogContext,
  ) {
    var alertStyle = AlertStyle(
      overlayColor: Colors.black87,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      buttonsDirection: ButtonsDirection.row,
      titleStyle: AppTextStyles.buttonDeletarTitle,
      descStyle: AppTextStyles.buttonBoldGray,
      animationDuration: Duration(milliseconds: 400),
    );

    Alert(
      context: context,
      style: alertStyle,
      title: "Sair",
      desc: "Deseja Sair da conta? ${widget.user.name}",
      buttons: [
        DialogButton(
          child: Text(
            "cancelar",
            style: AppTextStyles.buttonBoldGray,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 100,
          color: AppColors.shape,
          border: Border.all(color: AppColors.stroke),
        ),
        DialogButton(
          child: Text(
            "confirmar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            await controller.logout();
            Navigator.pushReplacementNamed(context, "/login");
          },
          color: AppColors.primary,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: Container(
          height: 152,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              title: Text.rich(
                TextSpan(
                  text: 'Olá, ',
                  style: AppTextStyles.titleRegular,
                  children: [
                    TextSpan(
                      text: '${widget.user.name}',
                      style: AppTextStyles.titleBoldBackground,
                    ),
                  ],
                ),
              ),
              subtitle: Text(
                'Mantenha suas contas em dia',
                style: AppTextStyles.captionShape,
              ),
              trailing: GestureDetector(
                onTap: () {
                  confirmationPopup(context);
                },
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: NetworkImage(widget.user.photoURL!))),
                ),
              ),
            ),
          ),
        ),
      ),
      body: [
        MeusBoletosPage(
          homeController: controller.currentPage,
          key: UniqueKey(),
        ),
        ExtractPage(
          homeController: controller.currentPage,
          key: UniqueKey(),
        ),
      ][controller.currentPage],
      bottomNavigationBar: Container(
        color: Colors.white60,
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                setState(() => controller.setPage(0));
              },
              icon: Icon(
                Icons.home,
                color: controller.currentPage == 0
                    ? AppColors.primary
                    : AppColors.body,
              ),
            ),
            GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(context, '/barcode_scanner');
                setState(() {});
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  Icons.add_box_outlined,
                  color: AppColors.background,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(
                  () => controller.setPage(1),
                );
              },
              icon: Icon(
                Icons.description_outlined,
                color: controller.currentPage == 1
                    ? AppColors.primary
                    : AppColors.body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//a/