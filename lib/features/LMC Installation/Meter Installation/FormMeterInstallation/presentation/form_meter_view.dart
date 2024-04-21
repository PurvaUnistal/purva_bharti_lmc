import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/app_color.dart';
import 'package:lmc/Utils/common_widgets/app_string.dart';
import 'package:lmc/Utils/common_widgets/button_widget.dart';
import 'package:lmc/Utils/common_widgets/dropdown_widget.dart';
import 'package:lmc/Utils/common_widgets/text_form_widget.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/bloc/form_meter_bloc.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/bloc/form_meter_event.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/bloc/form_meter_state.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/model/DelayReasonModel.dart';

class FormMeterView extends StatefulWidget {
  const FormMeterView({
    super.key,
  });

  @override
  State<FormMeterView> createState() => _FormMeterViewState();
}

class _FormMeterViewState extends State<FormMeterView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FormMeterBloc>(context).add(FormMeterPageLoadEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: RoutesName.meterInstallation,
        boolLeading: true,
      ),
      body: BlocBuilder<FormMeterBloc, FormMeterState>(
        builder: (context, state) {
          if (state is FormMeterDataState) {
            return _itemBuilder(dataState: state);
          } else {
            return Center(child: SpinLoader());
          }
        },
      ),
    );
  }

  _itemBuilder({required FormMeterDataState dataState}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _bpNumberController(stateData: dataState),
            _verticalSpace(),
            _typeOfNRDropdown(stateData: dataState),
            _verticalSpace(),
            _actualWorkDateController(stateData: dataState),
            _verticalSpace(),
            _delayReasonDropdown(stateData: dataState),
            _verticalSpace(),
            _verticalSpace(),
            _button(dataState: dataState),
          ],
        ),
      ),
    );
  }

  Widget _bpNumberController({required FormMeterDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.bpNumber,
      label: AppString.bpNumber,
      enabled: false,
      controller: stateData.bpNumberController,
    );
  }

  Widget _typeOfNRDropdown({required FormMeterDataState stateData}) {
    return DropdownWidget<GetConstantModel>(
      star: AppString.star,
      label: AppString.typeOfNR,
      hint: AppString.typeOfNR,
      dropdownValue: stateData.typeOfNrValue == null ? null : stateData.typeOfNrValue,
      items: stateData.listOfTypeOfNr,
      onChanged: (val) {
        BlocProvider.of<FormMeterBloc>(context).add(SelectTypeNRValueEvent(typeOfNRValue: val));
      },
    );
  }

  Widget _actualWorkDateController({required FormMeterDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.actualWorkStart,
      label: AppString.actualWorkStart,
      enabled: true,
      controller: stateData.actualWorkDateController,
      suffixIcon: IconButton(
        icon: Icon(
          Icons.calendar_today,
          color: AppColor.primer,
        ),
        onPressed: () {
          BlocProvider.of<FormMeterBloc>(context).add(SelectActualWorkDateEvent(context: context));
        },
      ),
      onTap: () {
        BlocProvider.of<FormMeterBloc>(context).add(SelectActualWorkDateEvent(context: context));
      },
    );
  }

  Widget _delayReasonDropdown({required FormMeterDataState stateData}) {
    return DropdownWidget<DelayReasonModel>(
      star: AppString.star,
      label: AppString.reasonDelay,
      hint: AppString.reasonDelay,
      dropdownValue: stateData.delayReasonValue == null ? null : stateData.delayReasonValue,
      items: stateData.listOfDelayReason,
      onChanged: (val) {
        BlocProvider.of<FormMeterBloc>(context).add(SelectDelayReasonValueEvent(delayReasonValue: val));
      },
    );
  }

  Widget _button({required FormMeterDataState dataState}) {
    return dataState.isBtnLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            onPressed: () {
              BlocProvider.of<FormMeterBloc>(context).add(SubmitFormMeterEvent(context: context));
            })
        : DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
