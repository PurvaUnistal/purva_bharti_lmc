import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/WidgetStyles/common_style.dart';
import 'package:lmc/Utils/common_widgets/background_widget.dart';
import 'package:lmc/Utils/common_widgets/button_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_config.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/Utils/common_widgets/res/environment_config.dart';
import 'package:lmc/Utils/common_widgets/row_widget.dart';
import 'package:lmc/features/Installation/FormInstallation/presentation/form_installation_view.dart';
import 'package:lmc/features/Installation/FormRFCInstallation/presentation/form_rfc_installation_view.dart';

class PreviewInstallationView extends StatefulWidget {
  const PreviewInstallationView({super.key});

  @override
  State<PreviewInstallationView> createState() =>
      _PreviewInstallationViewState();
}

class _PreviewInstallationViewState extends State<PreviewInstallationView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBarWidget(title: AppString.lmcInstallH, boolLeading: true),
      body: SafeArea(
        child: BackgroundWidget(
          child: _itemBuilder(),
      ),
      ),
    );
  }

  _itemBuilder() {
    final data =   AppConfig.instanceInit()?.installationDoneRows;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 1.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      AppString.consumerDetailH,
                      style: Styles.appTitle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: EnvironmentConfig.of(context)!.primaryTheme,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                _rowItem(
                  textName: AppString.crNumber,
                  textValue: data!.crn ?? "",
                ),
                _rowItem(
                  textName: AppString.bpNumber,
                  textValue: data.bpNumber ?? "",
                ),
                _rowItem(
                  textName: AppString.lmcFeaDate,
                  textValue: data.feasibilityVisitDate  ?? "",
                ),
                _rowItem(
                  textName: AppString.chargeArea,
                  textValue: data.chargeAreaName  ?? "",
                ),
                _rowItem(textName: AppString.area, textValue: data.areaName  ?? "",),
                _rowItem(
                  textName: AppString.firstName,
                  textValue: data.firstName  ?? "",
                ),
                _rowItem(
                  textName: AppString.lastName,
                  textValue: data.lastName  ?? "",
                ),
                _rowItem(
                  textName: AppString.mobileNumber,
                  textValue: data.mobileNumber  ?? "",
                ),
                _rowItem(
                  textName: AppString.buildingNumber,
                  textValue: data.buildingNumber  ?? "",
                ),
                _rowItem(
                  textName: AppString.houseNumber,
                  textValue: data.houseNumber  ?? "",
                ),
                _rowItem(
                  textName: AppString.street,
                  textValue: data.locality  ?? "",
                ),
                _rowItem(textName: AppString.town, textValue: data.town  ?? "",),
                _rowItem(
                  textName: AppString.pinCode,
                  textValue: data.pinCode  ?? "",
                ),
                CommonStyle.vertical(context: context),
                CommonStyle.vertical(context: context),
                _button(),
                CommonStyle.vertical(context: context),
                CommonStyle.vertical(context: context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _rowItem({required String textName, required String textValue}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
      child: RowWidget(
        widget1: Text("${textName} :", style: Styles.labels),
        widget2: Text(
          textValue,
          style: Styles.texts,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  Widget _button() {
    final data =   AppConfig.instanceInit()?.installationDoneRows;
    return ButtonWidget(
          text: AppString.installation,
          onPressed: () {
            if (data!.rfcProcessStatus == '' &&
                data.lmcInstallId == "") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormInstallationView()),
              );
            } else if (data.rfcProcessStatus == '') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormRFCInstallationView(),
                ),
              );
            }
          },
        );
  }
}
