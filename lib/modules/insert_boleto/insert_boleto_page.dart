import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projeto_nlw2/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:projeto_nlw2/shared/models/user_model.dart';
import 'package:projeto_nlw2/shared/themes/app_text_styles.dart';
import 'package:projeto_nlw2/shared/themes/appcolors.dart';
import 'package:projeto_nlw2/shared/widgets/input_text/input_text_widget.dart';
import 'package:projeto_nlw2/shared/widgets/set_label_buttons/set_label_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  const InsertBoletoPage({Key? key, this.barcode}) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final controller = InsertBoletoController();

  final moneyInputTextController =
      MoneyMaskedTextController(leftSymbol: "R\$", decimalSeparator: ',');

  final dueDateInputTextController = MaskedTextController(mask: "00/00/0000");

  @override
  void initState() {
    if (widget.barcode != null) {
      barcodeInputTextController.text = widget.barcode!;
    }
    super.initState();
  }

  final barcodeInputTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 40, bottom: 60, left: 70, right: 70),
                child: Text(
                  "Prencha os dados do boleto",
                  style: AppTextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      InputTextWidget(
                        label: "Nome do Boleto",
                        icon: Icons.description_outlined,
                        validator: controller.validateName,
                        onChanged: (value) {
                          controller.onChange(name: value);
                        },
                      ),
                      InputTextWidget(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: false),
                        controller: dueDateInputTextController,
                        label: "Vencimento",
                        icon: FontAwesomeIcons.timesCircle,
                        validator: controller.validateVencimento,
                        onChanged: (value) {
                          controller.onChange(dueDate: value);
                        },
                      ),
                      InputTextWidget(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        controller: moneyInputTextController,
                        label: "Valor",
                        icon: FontAwesomeIcons.wallet,
                        validator: (_) => controller.validateValor(
                            moneyInputTextController.numberValue),
                        onChanged: (value) {
                          controller.onChange(
                              value: moneyInputTextController.numberValue);
                        },
                      ),
                      InputTextWidget(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        controller: barcodeInputTextController,
                        label: "Código",
                        icon: FontAwesomeIcons.barcode,
                        validator: controller.validateCodigo,
                        onChanged: (value) {
                          controller.onChange(barcode: value);
                        },
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        primaryLabel: "Cancelar",
        primaryOnPressed: () {
          Navigator.of(context).pop();
        },
        secondaryLabel: "cadstrar",
        secondaryOnPressed: () async {
          final instance = await SharedPreferences.getInstance();
          final json = instance.get(
            "user",
          ) as String;
          await controller.cadastrarBoleto(context).then(
                (value) => {
                  if (value)
                    {
                      Navigator.pushReplacementNamed(context, "/home",
                          arguments: UserModel.fromJson(json))
                    }
                },
              );
        },
        enableSecondaryColor: true,
      ),
    );
  }
}
