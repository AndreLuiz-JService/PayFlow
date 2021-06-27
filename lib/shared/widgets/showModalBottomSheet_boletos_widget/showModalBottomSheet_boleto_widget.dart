import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projeto_nlw2/shared/models/boleto_model.dart';
import 'package:projeto_nlw2/shared/themes/app_text_styles.dart';
import 'package:projeto_nlw2/shared/themes/appcolors.dart';

class ShowModalBottomSheetBoletoWidget extends StatelessWidget {
  final Function(String) removerBoleto;
  final Function(String,bool) setarEstado;
  final BoletoModel boletoModel;
  const ShowModalBottomSheetBoletoWidget(
      {Key? key, required this.boletoModel, required this.removerBoleto, required this.setarEstado})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        height: size.height * 0.35,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text.rich(
              TextSpan(
                text: "O boleto ",
                style: AppTextStyles.titleBody,
                children: [
                  TextSpan(
                    text: boletoModel.name,
                    style: AppTextStyles.titleBoldHeading,
                  ),
                  TextSpan(
                    text: "\nno valor de R\$",
                    style: AppTextStyles.titleBody,
                  ),
                  TextSpan(
                    text: boletoModel.value.toString(),
                    style: AppTextStyles.titleBoldHeading,
                  ),
                  TextSpan(
                    text: "\nfoi pago?",
                    style: AppTextStyles.titleBody,
                  )
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ContainerOption(
                  label: "Ainda não",
                  color: AppColors.shape,
                  resposta: ()async {
                    await  setarEstado(boletoModel.name!,false);
                  Navigator.pop(context);
                  },
                ),
                ContainerOption(
                  label: "Sim",
                  color: AppColors.primary,
                  resposta: ()async {
                  await  setarEstado(boletoModel.name!,true);
                  Navigator.pop(context);
                  },
                  style: AppTextStyles.buttonBackground,
                ),
              ],
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.stroke,
            ),
            TextButton.icon(
                onPressed: () async {
                  await removerBoleto(boletoModel.name!);
                  
                  Navigator.popUntil(context, ModalRoute.withName("/home"));
                },
                icon: Icon(
                  FontAwesomeIcons.trashAlt,
                  color: AppColors.deletar[500],
                ),
                label: Text(
                  'Remover boleto',
                  style: AppTextStyles.buttonDeletar,
                ))
          ],
        ),
      ),
    );
  }
}

class ContainerOption extends StatelessWidget {
  final String label;
  final Color color;
  final TextStyle? style;
  final Function() resposta;
  const ContainerOption({
    Key? key,
    required this.color,
    required this.resposta,
    required this.label,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: resposta,
      child: Container(
        width: 156,
        height: 55,
        decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: AppColors.stroke,
            ),
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          label,
          style: style ?? AppTextStyles.buttonHeading,
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
//a/