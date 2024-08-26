import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/auto_complete_text_field_widget.dart';
import 'package:lmc/Utils/common_widgets/background_widget.dart';
import 'package:lmc/Utils/common_widgets/button_widget.dart';
import 'package:lmc/Utils/common_widgets/dropdown_widget.dart';
import 'package:lmc/Utils/common_widgets/icon_button.dart';
import 'package:lmc/Utils/common_widgets/image_pop_widget.dart';
import 'package:lmc/Utils/common_widgets/message_box_two_button_pop.dart';
import 'package:lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/Utils/common_widgets/row_widget.dart';
import 'package:lmc/Utils/common_widgets/text_form_widget.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/bloc/form_installation_bloc.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/bloc/form_installation_event.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/bloc/form_installation_state.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:lmc/features/Installation/FormInstallation/presentation/Widgets/image_widget.dart';
import 'package:lmc/features/Installation/FormInstallation/presentation/Widgets/meter_no_widget.dart';
import 'package:lmc/features/Installation/LMCInstallation/presentation/Widgets/cameraPopWidget.dart';

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

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.green50,
      body: BlocBuilder<FormInstallationBloc, FormInstallationState>(
        builder: (context, state) {
          if (state is FormInstallationDataState) {
            return  Form(
                key: formKey,
                onWillPop: _onWillPop,
                child: BackgroundWidget(
                    child: _itemBuilder(dataState: state)));
          } else {
            return Center(child: SpinLoader());
          }
        },
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
        context: context,
        builder: (BuildContext mContext) =>
            MessageBoxTwoButtonPopWidget(message: "Do you want to Installation?", okButtonText: "Exit", onPressed: () => Navigator.of(context).pop(true)))) ??
        false;
  }

  _itemBuilder({required FormInstallationDataState dataState}) {
    return Scaffold(
      appBar: AppBarWidget(
        title: AppString.lmcInstallH,
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
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          Text(AppString.installationForm,style: Styles.text,textAlign: TextAlign.center,),
          _verticalSpace(),
          RowWidget(
              widget1: _bpNumberController(stateData: dataState),
              widget2: _trNumberController(stateData: dataState)
          ),
          _verticalSpace(),
          RowWidget(
              widget1: _proposedDateController(stateData: dataState),
              widget2: _feasibilityDateController(stateData: dataState)
          ),
          _verticalSpace(),
          _installationDateController(stateData: dataState),
          _delayReasonDropdown(stateData: dataState),
          _verticalSpace(),
          _meterConnectionDropdown(stateData: dataState),
          _verticalSpace(),
          _meterNumberController(stateData: dataState),
          _verticalSpace(),
          _initialMeterReading(stateData: dataState),
          _verticalSpace(),
          _installRegulatorCheck(stateData: dataState),
          _regulatorTypeDropdown(stateData: dataState),
          _srNumberController(stateData: dataState),
          _regulatorController(stateData: dataState),
          _verticalSpace(),
          _ngConversionDateController(stateData: dataState),
          _verticalSpace(),
          _verticalSpace(),
          _materialList(stateData: dataState),
          _checkListRFC(stateData: dataState),
          _verticalSpace(),
          _locationOfHouse(stateData: dataState),
          _verticalSpace(),
          _image(stateData: dataState),
          _verticalSpace(),
          _verticalSpace(),
          _button(dataState: dataState),
          _verticalSpace(),
          _verticalSpace(),
        ],
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

  Widget _trNumberController({required FormInstallationDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.trNumber,
      label: AppString.trNumber,
      enabled: false,
      controller: stateData.trNumberController,
    );
  }

  Widget _proposedDateController({required FormInstallationDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.lmcProDate,
      label: AppString.lmcProDate,
      enabled: false,
      controller: stateData.proposedDateController,
    );
  }

  Widget _feasibilityDateController({required FormInstallationDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.lmcFeaDate,
      label: AppString.lmcFeaDate,
      enabled: false,
      controller: stateData.feasibilityDateController,
    );
  }

  Widget _installationDateController({required FormInstallationDataState stateData}) {
    return TextFieldWidget(
      star: AppString.star,
      hintText: AppString.installationDate,
      label: AppString.installationDate,
      textInputAction: TextInputAction.next,
      enabled: true,
      controller: stateData.installationDateController,
      suffixIcon: IconButtonWidget(
        iconData: Icons.calendar_today,
        onPressed: () {
          BlocProvider.of<FormInstallationBloc>(context).add(SelectInstallationDateEvent(context: context));
        },
      ),
      onChanged: (val) {
        BlocProvider.of<FormInstallationBloc>(context).add(SelectInstallationDateEvent(context: context));
      },
      onTap: () {
        BlocProvider.of<FormInstallationBloc>(context).add(SelectInstallationDateEvent(context: context));
      },
    );
  }

  Widget _delayReasonDropdown({required FormInstallationDataState stateData}) {
    return stateData.isDelayReason == true ? _col(
      child: DropdownWidget<LmcReasonModel>(
        star: AppString.star ,
        label: AppString.reasonDelay,
        hint: AppString.reasonDelay,
        dropdownValue: stateData.delayReasonValue?.name == null ? null : stateData.delayReasonValue,
        items: stateData.listOfDelayReason,
        onChanged: (val) {
          BlocProvider.of<FormInstallationBloc>(context).add(SelectDelayReasonValueEvent(delayReasonValue: val));
        },
      ),
    ): Container();
  }

  Widget _meterConnectionDropdown({required FormInstallationDataState stateData}) {
    return DropdownWidget<GetConstantModel>(
      label: AppString.meterConnection,
      hint: AppString.meterConnection,
      dropdownValue: stateData.typeOfNrValue?.value == null ? null : stateData.typeOfNrValue,
      items: stateData.listOfTypeOfNr,
      onChanged: (val) {
        BlocProvider.of<FormInstallationBloc>(context).add(SelectTypeNRValueEvent(typeOfNRValue: val));
      },
    );
  }

  Widget _meterNumberController({required FormInstallationDataState stateData}) {
    return AutoCompleteTextFieldWidget(
      star: AppString.star,
      hintText: AppString.meterNumber,
      label: AppString.meterNumber,
      suggestions: stateData.listOfMeterNumberSerial.length == 0 ? ["No Data Found"] : stateData.listOfMeterNumberSerial,
      keyboardType: TextInputType.text,
      controller: stateData.meterNumberSerialController,
      validator: (value) {
        if(value != null && value.isNotEmpty && !stateData.listOfMeterNumberSerial.contains(value)) {
          return AppString.meterNoErrorMsg;
        }
        return null;
      },
      onSelected: (val) {
        formKey.currentState?.validate();
        BlocProvider.of<FormInstallationBloc>(context).add(SelectMeterNumberValueEvent(context: context, meterReadingValue: val));
      },
      onChanged: (val) {
        formKey.currentState?.validate();
        BlocProvider.of<FormInstallationBloc>(context).add(SelectMeterNumberValueEvent(context: context, meterReadingValue: val));
      },
    );
  }

  Widget _initialMeterReading({required FormInstallationDataState stateData}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.meterInitNumber,
          style: Styles.labels,
        ),
        Row(
          children: [
            MeterNoWidget(enabled: false),
            _widthSpace(),
            MeterNoWidget(enabled: false),
            _widthSpace(),
            MeterNoWidget(enabled: false),
            _widthSpace(),
            MeterNoWidget(enabled: false),
            _widthSpace(),
            MeterNoWidget(enabled: false),
            _widthSpace(),
            MeterNoWidget(enabled: false),
            _widthSpace(),
            MeterNoWidget(enabled: false),
            _widthSpace(),
            _meterReading1Controller(stateData: stateData),
            _widthSpace(),
            _meterReading2Controller(stateData: stateData),
            _widthSpace(),
            _meterReading3Controller(stateData: stateData),
          ],
        ),
      ],
    );
  }

  Widget _meterReading1Controller({required FormInstallationDataState stateData}) {
    return MeterNoWidget(
      maxLength: 1,
      enabled: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.previous,
      controller: stateData.meterIniReading1Controller,
      focusNode: stateData.meterIniReading1FocusNode,
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(stateData.meterIniReading1FocusNode);
      },
      onChanged: (val) {
        if (stateData.meterIniReading1Controller.text.length == 1) {
          FocusScope.of(context).nextFocus();
        } else {
          FocusScope.of(context).unfocus();
        }
        BlocProvider.of<FormInstallationBloc>(context).add(MeterInitReadingEvent());
      },
    );
  }

  Widget _meterReading2Controller({required FormInstallationDataState stateData}) {
    return MeterNoWidget(
      maxLength: 1,
      enabled: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.previous,
      controller: stateData.meterIniReading2Controller,
      focusNode: stateData.meterIniReading2FocusNode,
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(stateData.meterIniReading2FocusNode);
      },
      onChanged: (val) {
        if (stateData.meterIniReading2Controller.text.length == 1) {
          FocusScope.of(context).nextFocus();
        } else {
          FocusScope.of(context).unfocus();
        }
        BlocProvider.of<FormInstallationBloc>(context).add(MeterInitReadingEvent());
      },
    );
  }

  Widget _meterReading3Controller({required FormInstallationDataState stateData}) {
    return MeterNoWidget(
      maxLength: 1,
      enabled: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      controller: stateData.meterIniReading3Controller,
      focusNode: stateData.meterIniReading3FocusNode,
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(stateData.meterIniReading3FocusNode);
      },
      onChanged: (val) {
        if (stateData.meterIniReading3Controller.text.length == 1) {
          FocusScope.of(context).unfocus();
        } else {
          FocusScope.of(context).unfocus();
        }
        BlocProvider.of<FormInstallationBloc>(context).add(MeterInitReadingEvent());
      },
    );
  }


  Widget _installRegulatorCheck({required FormInstallationDataState stateData}) {
    return  Card(
      child: Row(
        children: [
          Checkbox(
            value:stateData.isInstallRegulator,
            onChanged: (newVal){
              BlocProvider.of<FormInstallationBloc>(context).add(SelectInstallRegulatorEvent(
                  context: context,
                  installRegulator: newVal!
              ));
            },
          ),
          Text(AppString.installRegulator, style: Styles.labels,),
        ],
      ),
    );
  }
  Widget _regulatorTypeDropdown({required FormInstallationDataState stateData}) {
    return stateData.isInstallRegulator == true ? _col(
      child: DropdownWidget<LmcReasonModel>(
        star: AppString.star,
        label: AppString.regulatorType,
        hint: AppString.regulatorType,
        dropdownValue: stateData.regulatorTypeValue?.name == null ? null : stateData.regulatorTypeValue,
        items: stateData.listOfRegulatorType,
        onChanged: (val) {
          BlocProvider.of<FormInstallationBloc>(context).add(SelectRegulatorTypeValueEvent(regulatorTypeValue: val!, context: context));
        },
      ),
    ) : Container();
  }

  Widget _regulatorController({required FormInstallationDataState stateData}) {
    return stateData.isInstallRegulator == true ? stateData.isRegulator == false
        ? _col(
        child: stateData.regulatorTypeValue?.name != null ? AutoCompleteTextFieldWidget(
        star: AppString.star,
        enabled: stateData.regulatorTypeValue?.name == null ? false : true,
        label: stateData.regulatorTypeValue?.name != "PRV" ? AppString.meterRegulator : AppString.regulator,
        hintText: stateData.regulatorTypeValue?.name != "PRV" ? AppString.meterRegulator : AppString.regulator,
        suggestions: stateData.listOfRegulatorSerial.length == 0 ? ["No Data Found"] : stateData.listOfRegulatorSerial,
        keyboardType: TextInputType.text,
        controller: stateData.regulatorSerialController,
        onSelected: (val) {
          formKey.currentState?.validate();
          BlocProvider.of<FormInstallationBloc>(context).add(SelectRegulatorsValueEvent(context: context, regulatorsValue: val));
        },
        validator: (value) {
          if(value != null && value.isNotEmpty && !stateData.listOfRegulatorSerial.contains(value)) {
            return AppString.regulatorNoErrorMsg;
          }
          return null;
        },
        onChanged: (val) async {
          await formKey.currentState?.validate();
          BlocProvider.of<FormInstallationBloc>(context).add(SelectRegulatorsValueEvent(context: context, regulatorsValue: val));
        },
      ) : Container(),
    ) : DottedLoaderWidget()
        : Container();
  }

  Widget _srNumberController({required FormInstallationDataState stateData}) {
    return stateData.isInstallRegulator == true ? stateData.regulatorTypeValue?.name == "SR" ? _col(
      child: AutoCompleteTextFieldWidget(
        star: AppString.star,
        label:  AppString.srNumber,
        hintText: AppString.srNumber,
        suggestions: stateData.listOfSRSerial.length == 0 ? ["No Data Found"] : stateData.listOfSRSerial,
        keyboardType: TextInputType.text,
        controller: stateData.srNumberController,
        onSelected: (val) {
          formKey.currentState?.validate();
          BlocProvider.of<FormInstallationBloc>(context).add(SelectSREvent(context: context, sRegulators: val));
        },
        validator: (value) {
          if(value != null && value.isNotEmpty && !stateData.listOfSRSerial.contains(value)) {
            return AppString.srNoErrorMsg;
          }
          return null;
        },
        onChanged: (val) async {
          await formKey.currentState?.validate();
          BlocProvider.of<FormInstallationBloc>(context).add(SelectSREvent(context: context, sRegulators: val));
        },
      ),
    ): Container(): Container();
  }



  Widget _ngConversionDateController({required FormInstallationDataState stateData}) {
    return TextFieldWidget(
      star: AppString.star,
      hintText: AppString.ngConversionDate,
      label: AppString.ngConversionDate,
      controller: stateData.ngConversionDateController,
      suffixIcon: IconButtonWidget(
        iconData: Icons.calendar_today,
        onPressed: () {
          BlocProvider.of<FormInstallationBloc>(context).add(SelectNGConversionDateEvent(context: context));
        },
      ),
      onTap: () {
        BlocProvider.of<FormInstallationBloc>(context).add(SelectNGConversionDateEvent(context: context));
      },
    );
  }


  Widget _locationOfHouse({required FormInstallationDataState stateData}) {
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
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.02,
        ),
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
        /* SizedBox(
          width: MediaQuery.of(context).size.width * 0.02,
        ),
        IconButtonWidget(
          iconData: Icons.location_on,
          onPressed: () {
            BlocProvider.of<FormInstallationBloc>(context).add(SelectLocationOfSREvent(context: context));
          },
        )*/
      ],
    );
  }

  Widget _materialList({required FormInstallationDataState stateData}) {
    return Column(
      children: [
        Column(
          children: stateData.materialList.mapIndexed((index, e) {
            return Column(
              children: [
                Row(
                  children: [
                    e.name.toLowerCase().contains("pipe") ?
                    Flexible(
                      flex: 7,
                      child: TextFieldWidget(
                        hintText: AppString.pipe,
                        label: AppString.pipe,
                        initialValue: e.name,
                        enabled: false,
                      ),
                    )
                        : Flexible(
                      flex: 7,
                      child: TextFieldWidget(
                        hintText: AppString.material,
                        label: AppString.material,
                        initialValue: e.name,
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    e.name.toLowerCase().contains("pipe") ?  Flexible(
                      flex: 3,
                      child: TextFieldWidget(
                        hintText: e.unit,
                        label: e.unit,
                        controller: e.controller,
                        enabled: true,
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          BlocProvider.of<FormInstallationBloc>(context).add(SelectQTYLMCEvent(context: context, qtyValue: val));
                        },
                      ),
                    ):
                    Flexible(
                      flex: 3,
                      child: TextFieldWidget(
                        hintText: e.unit,
                        label: e.unit,
                        controller: e.controller,
                        enabled: true,
                        keyboardType: TextInputType.number,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              ],
            );
          }).toList(),
        ),
        stateData.isExtraPipe == false ?
        _extraPipeWidget(stateData: stateData) : DottedLoaderWidget(),
        _verticalSpace(),
      ],
    );
  }

  Widget _extraPipeWidget({required FormInstallationDataState stateData}){
    return RowWidget(
      widget1:  TextFieldWidget(
        enabled: false,
        hintText: AppString.extraPipe,
        label: AppString.extraPipe,
        controller: stateData.extraPipeController,
      ),
      widget2:  TextFieldWidget(
        enabled: false,
        hintText: AppString.extraPrice,
        label: AppString.extraPrice,
        controller: stateData.extraPriceController,
      ),
    );
  }




  Widget _checkListRFC({required FormInstallationDataState stateData}) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 4.0,
      ),
      shrinkWrap: true,
      itemCount: stateData.listOfAllRFC.length,
      itemBuilder: (context, index) {
        return Card(
          child: Row(
            children: [
              Checkbox(
                value: stateData.listOfAllRFC[index].isSelected,
                onChanged: (newVal) {
                  BlocProvider.of<FormInstallationBloc>(context).add(SelectRFCCheckValueEvent(context: context, isSelected: newVal!, index: index));
                },
              ),
              Text(
                stateData.listOfAllRFC[index].value!,
                style: Styles.labels,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _image({required FormInstallationDataState stateData}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ImageWidget(
          star: AppString.star,
          title: AppString.meter,
          imgFile: stateData.meterPhoto,
          onPressed: () {
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
          title: AppString.rfc,
          imgFile: stateData.rfcCardPhoto,
          onPressed: () {
            showModalBottomSheet(
                enableDrag: true,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return ImagePopWidget(
                    onTapCamera: () async {
                      Navigator.of(context).pop();
                      BlocProvider.of<FormInstallationBloc>(context).add(CaptureCameraRFCCardEvent());
                    },
                    onTapGallery: () async {
                      Navigator.of(context).pop();
                      BlocProvider.of<FormInstallationBloc>(context).add(CaptureGalleryRFCCardEvent());
                    },
                  );
                });
          },
        ),
        ImageWidget(
          star: AppString.star,
          title: AppString.pneumatic,
          imgFile: stateData.pneumaticTestReportPhoto,
          onPressed: () {
            showModalBottomSheet(
                enableDrag: true,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return ImagePopWidget(
                    onTapCamera: () async {
                      Navigator.of(context).pop();
                      BlocProvider.of<FormInstallationBloc>(context).add(CaptureCameraPneumaticEvent());
                    },
                    onTapGallery: () async {
                      Navigator.of(context).pop();
                      BlocProvider.of<FormInstallationBloc>(context).add(CaptureGalleryPneumaticEvent());
                    },
                  );
                });
          },
        ),
        ImageWidget(
          star: AppString.star,
          title: AppString.housePhoto,
          imgFile: stateData.housePhoto,
          onPressed: () {
            showModalBottomSheet(
                enableDrag: true,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return CameraPopWidget(
                    onTapCamera: () async {
                      Navigator.of(context).pop();
                      BlocProvider.of<FormInstallationBloc>(context).add(CaptureCameraHouseEvent());
                    },
                  );
                });
          },
        ),
      ],
    );
  }

  Widget _button({required FormInstallationDataState dataState}) {
    return dataState.isBtnLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        onPressed: () {
        //  formKey.currentState?.validate();
          BlocProvider.of<FormInstallationBloc>(context).add(SubmitFormInstallationEvent(context: context));
        })
        : DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }

  Widget _widthSpace() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.02,
    );
  }

  Widget _col({required Widget child}){
    return Column(
      children: [
        _verticalSpace(),
        child,
      ],
    );
  }
}
