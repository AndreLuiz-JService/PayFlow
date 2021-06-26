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
import 'package:shared_preferences/shared_preferences.dart';

class MeusBoletosPage extends StatefulWidget {
  final int homeController;
  const MeusBoletosPage({Key? key, required this.homeController}) : super(key: key);
  @override
  _MeusBoletosPageState createState() => _MeusBoletosPageState();
}

class _MeusBoletosPageState extends State<MeusBoletosPage> {
  final controller = BoletoListController();
  final controllerInsertBoleto = InsertBoletoController();
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
                    onPressed: () async {
                      final instance = await SharedPreferences.getInstance();
                      final json = instance.get(
                        "user",
                      ) as String;
                      await controllerInsertBoleto.removerBoleto();
                      Navigator.pushReplacementNamed(context, "/home",
                          arguments: UserModel.fromJson(json));
                    }),
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
