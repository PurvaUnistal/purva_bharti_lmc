import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
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
import 'package:lmc/Utils/common_widgets/message_box_two_button_pop.dart';
import 'package:lmc/Utils/common_widgets/styles_widget.dart';
import 'package:lmc/Utils/common_widgets/text_form_widget.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/bloc/form_installation_bloc.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/bloc/form_installation_event.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/bloc/form_installation_state.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/DelayReasonModel.dart';
import 'package:lmc/features/Installation/FormInstallation/presentation/Widgets/image_widget.dart';

class FormInstallationView extends StatefulWidget {
  const FormInstallationView({
    super.key,
  });

  @override
  State<FormInstallationView> createState() => _FormInstallationViewState();
}

class _FormInstallationViewState extends State<FormInstallationView> {
  @override
  void initState() {
    BlocProvider.of<FormInstallationBloc>(context).add(FormInstallationPageLoadEvent(context: context));
    super.initState();
  }

  GlobalKey<AutoCompleteTextFieldState<String>> globalSearchKey = GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> globalSearchKey1 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBarWidget(
          title: RoutesName.installation,
          boolLeading: true,
        ),
        body: BlocBuilder<FormInstallationBloc, FormInstallationState>(
          builder: (context, state) {
            if (state is FormInstallationDataState) {
              return _itemBuilder(dataState: state);
            } else {
              return Center(child: SpinLoader());
            }
          },
        ),
      ),
    );
  }
  Future<bool> _onWillPop() async {
    return (await showDialog(
        context: context,
        builder: (BuildContext mContext) => MessageBoxTwoButtonPopWidget(
            message: "Do you want to Installation?",
            okButtonText: "Exit",
            onPressed: () =>  Navigator.of(context).pop(true)
        ))
    ) ?? false;
  }
  _itemBuilder({required FormInstallationDataState dataState}) {
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
            _srNumberController(stateData: dataState),
            _regulatorController(stateData: dataState),
            _verticalSpace(),
            _rfcConDateController(stateData: dataState),
            _verticalSpace(),
            _proConDateController(stateData: dataState),
            _verticalSpace(),
            _locationOfSR(stateData: dataState),
            _verticalSpace(),
            _locationOfHouse(stateData: dataState),
            _verticalSpace(),
            _materialList(stateData: dataState),
            _verticalSpace(),
            _checkListRFC(stateData: dataState),
            _verticalSpace(),
            _image(stateData: dataState),
            _verticalSpace(),
            _verticalSpace(),
            _button(dataState: dataState),
          ],
        ),
      ),
    );
  }

  Widget _bpNumberController({required FormInstallationDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.bpNumber,
      label: AppString.bpNumber,
      enabled: false,
      controller: stateData.bpNumberController,
    );
  }

  Widget _typeOfNRDropdown({required FormInstallationDataState stateData}) {
    return DropdownWidget<GetConstantModel>(
      star: AppString.star,
      label: AppString.typeOfNR,
      hint: AppString.typeOfNR,
      dropdownValue: stateData.typeOfNrValue == null ? null : stateData.typeOfNrValue,
      items: stateData.listOfTypeOfNr,
      onChanged: (val) {
        BlocProvider.of<FormInstallationBloc>(context).add(SelectTypeNRValueEvent(typeOfNRValue: val));
      },
    );
  }

  Widget _meterNumberController({required FormInstallationDataState stateData}) {
    return AutoSuggestionTextFieldWidget(
      globalKey: globalSearchKey,
      star: AppString.star,
      label: AppString.meterNumber,
      hintText: AppString.meterNumber,
      suggestions: stateData.listOfMeterNumber,
      keyboardType: TextInputType.text,
      textSubmitted: (val) {
        print(val);
        BlocProvider.of<FormInstallationBloc>(context).add(SelectMeterNumberValueEvent(
            context: context,
            meterReadingValue: val
        ));
      },
    );
  }

  Widget _meterReadingDateController({required FormInstallationDataState stateData}) {
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
          BlocProvider.of<FormInstallationBloc>(context).add(SelectMeterReadingDateEvent(context: context));
        },
      ),
      onTap: () {
        BlocProvider.of<FormInstallationBloc>(context).add(SelectMeterReadingDateEvent(context: context));
      },
    );
  }

  Widget _meterReading1Controller({required FormInstallationDataState stateData}) {
    return TextFieldWidget(
      hintText: "0",
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
        BlocProvider.of<FormInstallationBloc>(context).add(MeterInitReadingEvent());
      },
    );
  }
  Widget _meterReading2Controller({required FormInstallationDataState stateData}) {
    return TextFieldWidget(
      hintText: "0",
      labelText: "0",
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
        BlocProvider.of<FormInstallationBloc>(context).add(MeterInitReadingEvent());
      },
    );
  }
  Widget _meterReading3Controller({required FormInstallationDataState stateData}) {
    return TextFieldWidget(
      hintText: "0",
      labelText: "0",
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
        BlocProvider.of<FormInstallationBloc>(context).add(MeterInitReadingEvent());
      },
    );
  }

  Widget _initialMeterReading({required FormInstallationDataState stateData}){
    var w = MediaQuery.of(context).size.width;
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

  Widget _delayReasonDropdown({required FormInstallationDataState stateData}) {
    return DropdownWidget<DelayReasonModel>(
      star: AppString.star,
      label: AppString.reasonDelay,
      hint: AppString.reasonDelay,
      dropdownValue: stateData.delayReasonValue == null ? null : stateData.delayReasonValue,
      items: stateData.listOfDelayReason,
      onChanged: (val) {
        BlocProvider.of<FormInstallationBloc>(context).add(SelectDelayReasonValueEvent(delayReasonValue: val));
      },
    );
  }


  Widget _button({required FormInstallationDataState dataState}) {
    return dataState.isBtnLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        onPressed: () {
          BlocProvider.of<FormInstallationBloc>(context).add(SubmitFormInstallationEvent(context: context));
        })
        : DottedLoaderWidget();
  }

  Widget _srNumberController({required FormInstallationDataState stateData}) {
    return TextFieldWidget(
      //  star: AppString.star,
      hintText: AppString.srNumber,
      label: AppString.srNumber,
      keyboardType: TextInputType.number,
      enabled: true,
      maxLength: 10,
      textInputAction: TextInputAction.done,
      controller: stateData.srNumberController,
    );
  }

  Widget _regulatorController({required FormInstallationDataState stateData}) {
    return AutoSuggestionTextFieldWidget(
      globalKey: globalSearchKey1,
      star: AppString.star,
      label: AppString.regulator,
      hintText: AppString.regulator,
      suggestions: stateData.listOfRegulator,
      keyboardType:  TextInputType.text,
      textSubmitted: (val) {
        BlocProvider.of<FormInstallationBloc>(context).add(SelectRegulatorsValueEvent(
            context: context,
            regulatorsValue: val
        ));
      },
    );
  }

  Widget _rfcConDateController({required FormInstallationDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.rfcDeclarationDate,
      label: AppString.rfcDeclarationDate,
      enabled: true,
      controller: stateData.rfcConDateController,
      suffixIcon: IconButton(
        icon: Icon(
          Icons.calendar_today,
          color: AppColor.primer,
        ),
        onPressed: () {
          BlocProvider.of<FormInstallationBloc>(context).add(SelectRFCDeclarationDateEvent(context: context));
        },
      ),
      onTap: () {
        BlocProvider.of<FormInstallationBloc>(context).add(SelectRFCDeclarationDateEvent(context: context));
      },
    );
  }

  Widget _proConDateController({required FormInstallationDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.proConDate,
      label: AppString.proConDate,
      enabled: true,
      controller: stateData.proConDateController,
      suffixIcon: IconButton(
        icon: Icon(
          Icons.calendar_today,
          color: AppColor.primer,
        ),
        onPressed: () {
          BlocProvider.of<FormInstallationBloc>(context).add(SelectProposedConDateEvent(context: context));
        },
      ),
      onTap: () {
        BlocProvider.of<FormInstallationBloc>(context).add(SelectProposedConDateEvent(context: context));
      },
    );
  }

  Widget _materialList({required FormInstallationDataState stateData}){
    return Column(
      children: stateData.materialList.mapIndexed((index, e) {
        return Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 7,
                  child: TextFieldWidget(
                    hintText: AppString.material,
                    label: AppString.material,
                    initialValue : e.name,
                    enabled: false,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                Flexible(
                  flex: 3,
                  child: TextFieldWidget(
                    hintText: e.unit,
                    label: e.unit,
                    initialValue : e.controller.text,
                    enabled: true,
                    keyboardType: TextInputType.number,
                    onChanged: (val){
                      BlocProvider.of<FormInstallationBloc>(context).add(SelectQTYLMCEvent(context: context, qtyValue: val, index: index));
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          ],
        );
      }).toList(),
    );
  }


  Widget _locationOfSR({required FormInstallationDataState stateData}){
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: TextFieldWidget(
            enabled: false,
            star: AppString.star,
            hintText: AppString.latOfSR,
            label: AppString.latOfSR,
            controller: stateData.latOfSRController,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
        Flexible(
          flex: 3,
          child: TextFieldWidget(
            enabled: false,
            star: AppString.star,
            hintText: AppString.longOfSR,
            label: AppString.longOfSR,
            controller: stateData.longOfSRController,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
        IconButton(
          icon: Icon(Icons.location_on, color: AppColor.primer,),
          onPressed: (){
            BlocProvider.of<FormInstallationBloc>(context).add(SelectLocationOfSREvent(context: context));
          }, )
      ],
    );
  }

  Widget _locationOfHouse({required FormInstallationDataState stateData}){
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: TextFieldWidget(
            enabled: false,
            star: AppString.star,
            hintText: AppString.latOfHouse,
            label: AppString.latOfHouse,
            controller: stateData.latOfHouseController,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
        Flexible(
          flex: 3,
          child: TextFieldWidget(
            enabled: false,
            star: AppString.star,
            hintText: AppString.longOfHouse,
            label: AppString.longOfHouse,
            controller: stateData.longOfHouseController,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
        IconButton(
          icon: Icon(Icons.location_on, color: AppColor.primer,),
          onPressed: (){
            BlocProvider.of<FormInstallationBloc>(context).add(SelectLocationOfSREvent(context: context));
          }, )
      ],
    );
  }

  Widget _image({required FormInstallationDataState stateData}){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImageWidget(
              star: AppString.star,
              title: AppString.rfc,
              imgFile: stateData.rfcCardImg,
              onPressed: (){
                showModalBottomSheet(
                    enableDrag: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return ImagePopWidget(
                        onTapCamera: () async {
                          Navigator.of(context).pop();
                          BlocProvider.of<FormInstallationBloc>(context).add(
                              CaptureCameraRFCCardEvent());
                        },
                        onTapGallery: () async {
                          Navigator.of(context).pop();
                          BlocProvider.of<FormInstallationBloc>(context).add(
                              CaptureGalleryRFCCardEvent());
                        },
                      );
                    });
              },
            ),
            ImageWidget(
              title: AppString.pneumatic,
              imgFile: stateData.pneumaticTestReportImg,
              onPressed: (){
                showModalBottomSheet(
                    enableDrag: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return ImagePopWidget(
                        onTapCamera: () async {
                          Navigator.of(context).pop();
                          BlocProvider.of<FormInstallationBloc>(context).add(
                              CaptureCameraPneumaticEvent());
                        },
                        onTapGallery: () async {
                          Navigator.of(context).pop();
                          BlocProvider.of<FormInstallationBloc>(context).add(
                              CaptureGalleryPneumaticEvent());
                        },
                      );
                    });
              },
            ),
          ],
        ),
        _verticalSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImageWidget(
              star: AppString.star,
              title: AppString.meter,
              imgFile: stateData.meterImg,
              onPressed: (){
                showModalBottomSheet(
                    enableDrag: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return ImagePopWidget(
                        onTapCamera: () async {
                          Navigator.of(context).pop();
                          BlocProvider.of<FormInstallationBloc>(context).add(CaptureCameraMeterEvent());
                        },
                        onTapGallery: () async {
                          Navigator.of(context).pop();
                          BlocProvider.of<FormInstallationBloc>(context).add(CaptureGalleryMeterEvent());
                        },
                      );
                    });
              },
            ),
            ImageWidget(
              star: AppString.star,
              title: AppString.installation,
              imgFile: stateData.installationImg,
              onPressed: (){
                showModalBottomSheet(
                    enableDrag: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return ImagePopWidget(
                        onTapCamera: () async {
                          Navigator.of(context).pop();
                          BlocProvider.of<FormInstallationBloc>(context).add(
                              CaptureCameraInstallationEvent());
                        },
                        onTapGallery: () async {
                          Navigator.of(context).pop();
                          BlocProvider.of<FormInstallationBloc>(context).add(
                              CaptureGalleryInstallationEvent());
                        },
                      );
                    });
              },
            ),
          ],
        )
      ],
    );
  }


  Widget _checkListRFC({required FormInstallationDataState stateData}){
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount : stateData.listOfAllRFC.length,
        itemBuilder: (context, index){
          return CheckboxListTile(
            value: stateData.listOfAllRFC[index].isSelected,
            title: Text( stateData.listOfAllRFC[index].value, style: Styles.labels,),
            onChanged: (newVal){
              BlocProvider.of<FormInstallationBloc>(context).add(
                  SelectRFCCheckValueEvent(
                      context: context,
                      isSelected: newVal!,
                      index: index
                  ));},
          );
        }
    );
  }


  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}

