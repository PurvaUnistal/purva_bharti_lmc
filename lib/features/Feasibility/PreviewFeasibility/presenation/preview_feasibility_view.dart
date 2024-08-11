import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/background_widget.dart';
import 'package:lmc/Utils/common_widgets/button_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/presentation/form_feasibility_view.dart';
import 'package:lmc/features/Feasibility/PreviewFeasibility/domain/bloc/preview_feasibility_bloc.dart';
import 'package:lmc/features/Feasibility/PreviewFeasibility/domain/bloc/preview_feasibility_event.dart';
import 'package:lmc/features/Feasibility/PreviewFeasibility/domain/bloc/preview_feasibility_state.dart';

class PreviewFeasibilityView extends StatefulWidget {
  const PreviewFeasibilityView({
    super.key,
  });

  @override
  State<PreviewFeasibilityView> createState() => _PreviewFeasibilityViewState();
}

class _PreviewFeasibilityViewState extends State<PreviewFeasibilityView> {
  @override
  void initState() {
    BlocProvider.of<PreviewFeasibilityBloc>(context).add(PreviewFeasibilityPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: BlocBuilder<PreviewFeasibilityBloc, PreviewFeasibilityState>(
        builder: (context, state) {
          if (state is PreviewFeasibilityDataState) {
            return BackgroundWidget(
              child: _itemBuilder(dataState: state, context: context),
            );
          } else {
            return Center(child: SpinLoader());
          }
        },
      ),
    );
  }

  _itemBuilder({required PreviewFeasibilityDataState dataState, required BuildContext context}) {
    return Scaffold(
      appBar: AppBarWidget(
        title: AppString.lmcFeaDetailH,
        boolLeading: true,
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dataState.userName,
                textAlign: TextAlign.start,
                style: Styles.rel,
              ),
              Text(
                dataState.schema,
                textAlign: TextAlign.start,
                style: Styles.rel,
              )
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            _rowItem(textName: AppString.custReg, textValue: dataState.custRegNo),
            _rowItem(textName: AppString.chargeArea, textValue: dataState.chargeArea),
            _rowItem(textName: AppString.area, textValue: dataState.areaName),
            _rowItem(textName: AppString.firstName, textValue: dataState.firstName),
            _rowItem(textName: AppString.lastName, textValue: dataState.lastName),
            _rowItem(textName: AppString.mobileNumber, textValue: dataState.mobileNumber),
            _rowItem(textName: AppString.buildingNumber, textValue: dataState.buildingNumber),
            _rowItem(textName: AppString.houseNumber, textValue: dataState.houseNumber),
            _rowItem(textName: AppString.street, textValue: dataState.locality),
            _rowItem(textName: AppString.town, textValue: dataState.town),
            _rowItem(textName: AppString.pinCode, textValue: dataState.pinCode),
            _verticalSpace(),
            _verticalSpace(),
            _button(dataState: dataState),
            _verticalSpace(),
            _verticalSpace(),
          ],
        ),
      ),
    );
  }

  Widget _rowItem({required String textName, required String textValue}) {
    return Card(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Text(
              "${textName} :",
              style: Styles.labels,
            )),
            Flexible(child: Text(textValue, style: Styles.texts, textAlign: TextAlign.right)),
          ],
        ),
      ),
    );
  }

  Widget _button({required PreviewFeasibilityDataState dataState}) {
    return dataState.isLoader == false
        ? ButtonWidget(
            text: AppString.checkFea,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FormFeasibilityView()));
            })
        : DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
