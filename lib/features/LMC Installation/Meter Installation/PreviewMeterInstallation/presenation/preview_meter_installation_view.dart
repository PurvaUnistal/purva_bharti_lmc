import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/app_color.dart';
import 'package:lmc/Utils/common_widgets/app_string.dart';
import 'package:lmc/Utils/common_widgets/button_widget.dart';
import 'package:lmc/Utils/common_widgets/styles_widget.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/presentation/form_meter_view.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/PreviewMeterInstallation/domain/bloc/preview_meter_installation_bloc.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/PreviewMeterInstallation/domain/bloc/preview_meter_installation_event.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/PreviewMeterInstallation/domain/bloc/preview_meter_installation_state.dart';

class PreviewMeterInstalView extends StatefulWidget {
  const PreviewMeterInstalView({
    super.key,
  });

  @override
  State<PreviewMeterInstalView> createState() => _PreviewMeterInstalViewState();
}

class _PreviewMeterInstalViewState extends State<PreviewMeterInstalView> {
  @override
  void initState() {
    BlocProvider.of<PreviewMeterInstallationBloc>(context).add(PreviewMeterInstallationPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: RoutesName.meterInstallation,
        boolLeading: true,
      ),
      body: BlocBuilder<PreviewMeterInstallationBloc, PreviewMeterInstallationState>(
        builder: (context, state) {
          if (state is PreviewMeterInstallationDataState) {
            return _itemBuilder(dataState: state, context: context);
          } else {
            return Center(child: SpinLoader());
          }
        },
      ),
    );
  }

  _itemBuilder({required PreviewMeterInstallationDataState dataState, required BuildContext context}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _rowItem(textName: AppString.custReg, textValue: dataState.custRegNo),
            _rowItem(textName: AppString.lmcFeaDate, textValue: dataState.feasibilityVisitDate),
            _rowItem(textName: AppString.area, textValue: dataState.areaName),
            _rowItem(textName: AppString.firstName, textValue: dataState.firstName),
            _rowItem(textName: AppString.lastName, textValue: dataState.lastName),
            _rowItem(textName: AppString.guardianName, textValue: dataState.guardianName),
            _rowItem(textName: AppString.propertyCategory, textValue: dataState.proCateName),
            _rowItem(textName: AppString.propertyClass, textValue: dataState.propClass),
            _rowItem(textName: AppString.buildingNumber, textValue: dataState.buildingNumber),
            _rowItem(textName: AppString.houseNumber, textValue: dataState.houseNumber),
            _rowItem(textName: AppString.colony, textValue: dataState.locality),
            _rowItem(textName: AppString.town, textValue: dataState.town),
            _rowItem(textName: AppString.street, textValue: dataState.street),
            _rowItem(textName: AppString.district, textValue: dataState.district),
            _rowItem(textName: AppString.pinCode, textValue: dataState.pinCode),
            _verticalSpace(),
            _verticalSpace(),
            _button(dataState: dataState),
          ],
        ),
      ),
    );
  }

  Widget _rowItem({required String textName, required String textValue}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Text(
                "${textName} :",
                style: Styles.labels,
              )),
              Flexible(
                  child: Text(
                textValue,
              )),
            ],
          ),
        ),
        Divider(
          color: AppColor.primer1,
        )
      ],
    );
  }

  Widget _button({required PreviewMeterInstallationDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.meterInstal,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FormMeterView()));
            })
        : DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
