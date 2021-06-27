import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:projeto_nlw2/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:projeto_nlw2/shared/models/boleto_model.dart';
import 'package:projeto_nlw2/shared/models/user_model.dart';
import 'package:projeto_nlw2/shared/themes/app_text_styles.dart';
import 'package:projeto_nlw2/shared/themes/appcolors.dart';
import 'package:projeto_nlw2/shared/widgets/boleto_info/boleto_info_widget.dart';
import 'package:projeto_nlw2/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:projeto_nlw2/shared/widgets/boleto_list/boleto_list_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeusBoletosPage extends StatefulWidget {
  final int homeController;
  const MeusBoletosPage({Key? key, required this.homeController})
      : super(key: key);
  @override
  _MeusBoletosPageState createState() => _MeusBoletosPageState();
}

class _MeusBoletosPageState extends State<MeusBoletosPage> {
  final controller = BoletoListController();
  final controllerInsertBoleto = InsertBoletoController();

  confirmationPopup(
    BuildContext dialogContext,
  ) {
    var alertStyle = AlertStyle(
      overlayColor: Colors.black87,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      titleStyle: AppTextStyles.buttonDeletarTitle,
      descStyle: AppTextStyles.buttonBoldGray,
      animationDuration: Duration(milliseconds: 400),
    );

    Alert(
      context: context,
      style: alertStyle,
      title: "Cuidado",
      desc: "Deseja remover todos os boletos?",
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
            final instance = await SharedPreferences.getInstance();
            final json = instance.get(
              "user",
            ) as String;
            await controllerInsertBoleto.removerBoleto();
            Navigator.pushReplacementNamed(context, "/home",
                arguments: UserModel.fromJson(json));
          },
          color: AppColors.primary,
        )
      ],
    ).show();
  }

  @override
  void initState() {
    controller.boletos;
    super.initState();
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: AppColors.primary,
              height: 40,
              width: double.maxFinite,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ValueListenableBuilder<List<BoletoModel>>(
                valueListenable: controller.boletosNotifier,
                builder: (_, boletos, __) => AnimatedCard(
                  direction: AnimatedCardDirection.right,
                  duration: Duration(seconds: 1),
                  child: BoletoInfoWidget(
                    size: boletos.length,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24.0, left: 24, right: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedCard(
                direction: AnimatedCardDirection.top,
                duration: Duration(seconds: 1),
                child: Text(
                  "Meus Boletos",
                  style: AppTextStyles.titleBoldHeading,
                ),
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.bottom,
                duration: Duration(seconds: 1),
                child: TextButton(
                  child: Text(
                    "Remover Boletos",
                    style: AppTextStyles.buttonBoldTitlePrimary,
                  ),
                  onPressed: ()  {
                    confirmationPopup(context);
                  },
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24),
          child: Divider(
            thickness: 1,
            height: 1,
            color: AppColors.stroke,
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: BoletoListWidget(
                  homeController: widget.homeController,
                  controller: controller,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
