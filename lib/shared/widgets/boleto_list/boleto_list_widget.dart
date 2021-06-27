import 'package:flutter/material.dart';
import 'package:projeto_nlw2/shared/models/boleto_model.dart';
import 'package:projeto_nlw2/shared/themes/appcolors.dart';
import 'package:projeto_nlw2/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:projeto_nlw2/shared/widgets/boleto_tile/boleto_tile_widget.dart';
import 'package:projeto_nlw2/shared/widgets/showModalBottomSheet_boletos_widget/showModalBottomSheet_boleto_widget.dart';

class BoletoListWidget extends StatefulWidget {
  final int homeController;
  final BoletoListController controller;

  const BoletoListWidget({
    Key? key,
    required this.controller,
    required this.homeController,
  }) : super(key: key);

  @override
  _BoletoListWidgetState createState() => _BoletoListWidgetState();
}

class _BoletoListWidgetState extends State<BoletoListWidget> {
  _openTransactionFormModal(BuildContext context, BoletoModel boletoModel) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: 5, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: ShowModalBottomSheetBoletoWidget(
              boletoModel: boletoModel,
              removerBoleto: widget.controller.remover,
              setarEstado: widget.controller.setarEstado,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BoletoModel>>(
      valueListenable: widget.homeController == 0
          ? widget.controller.boletosNotifier
          : widget.controller.boletosPagosNotifier,
      builder: (_, boletos, __) => Column(
        children: boletos
            .map((e) => InkWell(
                  onTap: () {
                    _openTransactionFormModal(context, e);
                  },
                  focusColor: AppColors.primaryLight,
                  highlightColor: AppColors.primaryLight,
                  splashColor: AppColors.redLight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: BoletoTileWidget(data: e),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
//a/