import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/button_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/features/Installation/FormInstallation/presentation/form_installation_view.dart';
import 'package:lmc/features/Installation/PreviewInstallation/domain/bloc/preview_installation_bloc.dart';
import 'package:lmc/features/Installation/PreviewInstallation/domain/bloc/preview_installation_event.dart';
import 'package:lmc/features/Installation/PreviewInstallation/domain/bloc/preview_installation_state.dart';

class PreviewInstallationView extends StatefulWidget {
  const PreviewInstallationView({
    super.key,
  });

  @override
  State<PreviewInstallationView> createState() => _PreviewInstallationViewState();
}

class _PreviewInstallationViewState extends State<PreviewInstallationView> {
  @override
  void initState() {
    BlocProvider.of<PreviewInstallationBloc>(context).add(PreviewInstallationPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: RoutesName.installation,
        boolLeading: true,
      ),
      body: BlocBuilder<PreviewInstallationBloc, PreviewInstallationState>(
        builder: (context, state) {
          if (state is PreviewInstallationDataState) {
            return _itemBuilder(dataState: state, context: context);
          } else {
            return Center(child: SpinLoader());
          }
        },
      ),
    );
  }

  _itemBuilder({required PreviewInstallationDataState dataState, required BuildContext context}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _rowItem(textName: AppString.custReg, textValue: dataState.custRegNo),
            _rowItem(textName: AppString.lmcFeaDate, textValue: dataState.feasibilityVisitDate),
            _rowItem(textName: AppString.chargeArea, textValue: dataState.chargeArea),
            _rowItem(textName: AppString.area, textValue: dataState.areaName),
            _rowItem(textName: AppString.firstName, textValue: dataState.firstName),
            _rowItem(textName: AppString.lastName, textValue: dataState.lastName),
            _rowItem(textName: AppString.mobileNumber, textValue: dataState.mobileNumber),
            _rowItem(textName: AppString.buildingNumber,textValue: dataState.buildingNumber),
            _rowItem(textName: AppString.houseNumber,textValue: dataState.houseNumber),
            _rowItem(textName: AppString.street,textValue: dataState.locality),
            _rowItem(textName: AppString.town,textValue: dataState.town),
            _rowItem(textName: AppString.pinCode,textValue: dataState.pinCode),
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

  Widget _button({required PreviewInstallationDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.installation,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FormInstallationView()));
            })
        : DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
