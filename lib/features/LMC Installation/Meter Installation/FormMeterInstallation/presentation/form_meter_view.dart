import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/app_color.dart';
import 'package:lmc/Utils/common_widgets/app_string.dart';
import 'package:lmc/Utils/common_widgets/auto_suggestion_text_field_widget.dart';
import 'package:lmc/Utils/common_widgets/button_widget.dart';
import 'package:lmc/Utils/common_widgets/dropdown_widget.dart';
import 'package:lmc/Utils/common_widgets/image_pop_widget.dart';
import 'package:lmc/Utils/common_widgets/local_mg_widget.dart';
import 'package:lmc/Utils/common_widgets/styles_widget.dart';
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

  GlobalKey<AutoCompleteTextFieldState<String>> globalSearchKey = GlobalKey();

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
            _meterReadingDateController(stateData: dataState),
            _verticalSpace(),
            _meterNumberController(stateData: dataState),
            _verticalSpace(),
            _initialMeterReading(stateData: dataState),
            _verticalSpace(),
            _delayReasonDropdown(stateData: dataState),
            _verticalSpace(),
            _meterPhoto(stateData: dataState),
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

  Widget _meterNumberController({required FormMeterDataState stateData}) {
    return AutoSuggestionTextFieldWidget(
      globalKey: globalSearchKey,
      star: AppString.star,
      label: AppString.meterNumber,
      hintText: AppString.meterNumber,
      suggestions: stateData.listOfMeterNumber,
      keyboardType:  TextInputType.number,
      onChanged: (val) {
        print(val);
        BlocProvider.of<FormMeterBloc>(context).add(SelectMeterNumberValueEvent(
            context: context,
            meterReadingValue: val
        ));
      },
    );
  }
  Widget _meterReadingDateController({required FormMeterDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.meterReadingDate,
      label: AppString.meterReadingDate,
      enabled: true,
      controller: stateData.meterReadingDateController,
      suffixIcon: IconButton(
        icon: Icon(
          Icons.calendar_today,
          color: AppColor.primer,
        ),
        onPressed: () {
          BlocProvider.of<FormMeterBloc>(context).add(SelectMeterReadingDateEvent(context: context));
        },
      ),
      onTap: () {
        BlocProvider.of<FormMeterBloc>(context).add(SelectMeterReadingDateEvent(context: context));
      },
    );
  }

  Widget _meterReading1Controller({required FormMeterDataState stateData}) {
    return TextFieldWidget(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      controller: stateData.meterIniReading1Controller,
      focusNode: stateData.meterIniReading1FocusNode,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
      ],
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(stateData.meterIniReading1FocusNode);
      },
      onChanged: (val){
        BlocProvider.of<FormMeterBloc>(context).add(MeterInitReadingEvent());
      },
    );
  }
  Widget _meterReading2Controller({required FormMeterDataState stateData}) {
    return TextFieldWidget(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.previous,
      controller: stateData.meterIniReading2Controller,
      focusNode: stateData.meterIniReading2FocusNode,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
      ],
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(stateData.meterIniReading2FocusNode);
      },
      onChanged: (val){
        BlocProvider.of<FormMeterBloc>(context).add(MeterInitReadingEvent());
      },
    );
  }
  Widget _meterReading3Controller({required FormMeterDataState stateData}) {
    return TextFieldWidget(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.previous,
      controller: stateData.meterIniReading3Controller,
      focusNode: stateData.meterIniReading3FocusNode,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
      ],
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(stateData.meterIniReading3FocusNode);
      },
      onChanged: (val){
        BlocProvider.of<FormMeterBloc>(context).add(MeterInitReadingEvent());
      },
    );
  }

  Widget _initialMeterReading({required FormMeterDataState stateData}){
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppString.meterInitNumber,style: Styles.labels,),
        Row(
          children: [
            SizedBox(width:  w * 0.09, child: _meterReading1Controller(stateData: stateData)),
            SizedBox(width: w * 0.02,),
            SizedBox(width: w * 0.09, child: _meterReading2Controller(stateData: stateData)),
            SizedBox(width: w * 0.02,),
            SizedBox(width: w * 0.09, child: _meterReading3Controller(stateData: stateData)),
          ],
        ),
      ],
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

  Widget _meterPhoto({required FormMeterDataState stateData}) {
    return LocalImgWidget(
      file: stateData.meterImg,
      onTap: () {
        showModalBottomSheet(
            enableDrag: true,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return ImagePopWidget(
                onTapCamera: () async {
                  Navigator.of(context).pop();
                  BlocProvider.of<FormMeterBloc>(context).add(CaptureCameraMeterEvent());
                },
                onTapGallery: () async {
                  Navigator.of(context).pop();
                  BlocProvider.of<FormMeterBloc>(context).add(CaptureGalleryMeterEvent());
                },
              );
            });
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
