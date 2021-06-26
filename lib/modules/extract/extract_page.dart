import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:projeto_nlw2/shared/models/boleto_model.dart';
import 'package:projeto_nlw2/shared/themes/app_text_styles.dart';
import 'package:projeto_nlw2/shared/themes/appcolors.dart';
import 'package:projeto_nlw2/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:projeto_nlw2/shared/widgets/boleto_list/boleto_list_widget.dart';

class ExtractPage extends StatefulWidget {
  final int homeController;
  const ExtractPage({Key? key, required this.homeController}) : super(key: key);

  @override
  _ExtractPageState createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  final controller = BoletoListController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24.0, left: 24, right: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedCard(
                direction: AnimatedCardDirection.top,
                duration: Duration(seconds: 1),
                child: Text(
                  "Meus extratos",
                  style: AppTextStyles.titleBoldHeading,
                ),
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.bottom,
                duration: Duration(seconds: 1),
                child: ValueListenableBuilder<List<BoletoModel>>(
                  valueListenable: controller.boletosPagosNotifier,
                  builder: (_, boletos, __) => AnimatedCard(
                    direction: AnimatedCardDirection.bottom,
                    duration: Duration(seconds: 1),
                    child: Text(
                      "pagos ${boletos.length}",
                      style: AppTextStyles.captionBody,
                    ),
                  ),
                ),
              ),
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
              )
            ],
          ),
        )
      ],
    );
  }
}
