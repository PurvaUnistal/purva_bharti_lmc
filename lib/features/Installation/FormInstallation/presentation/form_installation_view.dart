import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/CheckboxWidget.dart';
import 'package:lmc/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/WidgetStyles/common_style.dart';
import 'package:lmc/Utils/common_widgets/auto_complete_text_field_widget.dart';
import 'package:lmc/Utils/common_widgets/background_widget.dart';
import 'package:lmc/Utils/common_widgets/button_widget.dart';
import 'package:lmc/Utils/common_widgets/dropdown_widget.dart';
import 'package:lmc/Utils/common_widgets/icon_button.dart';
import 'package:lmc/Utils/common_widgets/image_pop_widget.dart';
import 'package:lmc/Utils/common_widgets/message_box_two_button_pop.dart';
import 'package:lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_config.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/Utils/common_widgets/res/enums.dart';
import 'package:lmc/Utils/common_widgets/res/environment_config.dart';
import 'package:lmc/Utils/common_widgets/row_widget.dart';
import 'package:lmc/Utils/common_widgets/text_form_widget.dart';
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
    BlocProvider.of<FormInstallationBloc>(context)
        .add(FormInstallationPageLoadEvent(context: context));
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  final meterFieldKey = GlobalKey<FormFieldState>();
  final regulatorFieldKey = GlobalKey<FormFieldState>();
  final mRegulatorFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBarWidget(
        title: AppString.lmcInstallH,
        boolLeading: true,
    ),
    body: SafeArea(
      child: BackgroundWidget(
        child: BlocBuilder<FormInstallationBloc, FormInstallationState>(
          builder: (context, state) {
            if (state is FormInstallationDataState) {
              return Form(
                  onWillPop: _onWillPop,
                  child: _itemBuilder(dataState: state));
            } else {
              return Center(child: SpinLoader());
            }
          },
        ),
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
                onPressed: () => Navigator.of(context).pop(true)))) ??
        false;
  }

  _itemBuilder({required FormInstallationDataState dataState}) {
    return  ListView(
        padding: EdgeInsets.all(8),
        children: [
          Text(
            AppString.installationForm,
            style: Styles.text,
            textAlign: TextAlign.center,
          ),
          CommonStyle.vertical(context: context),
          RowWidget(
              widget1: _bpNumberController(dataState: dataState),
              widget2: _trNumberController(dataState: dataState)),
          CommonStyle.vertical(context: context),
          RowWidget(
              widget1: _proposedDateController(dataState: dataState),
              widget2: _feasibilityDateController(dataState: dataState)),
          CommonStyle.vertical(context: context),
          _installationDateController(dataState: dataState),
          _delayReasonDropdown(dataState: dataState),
          CommonStyle.vertical(context: context),
          _meterNumberController(dataState: dataState),
          _initialMeterReading(dataState: dataState),
          _installRegulatorCheck(dataState: dataState),
          _regulatorTypeDropdown(dataState: dataState),
          _regulatorController(dataState: dataState),
          _mrNumberController(dataState: dataState),
          _ngConversionDateController(dataState: dataState),
          _rfcDateControllerController(dataState: dataState),
          CommonStyle.vertical(context: context),
          _materialList(dataState: dataState),
          _materialCopperList(dataState: dataState),
          _checkListRFC(dataState: dataState),
          CommonStyle.vertical(context: context),
          _locationOfHouse(dataState: dataState),
          CommonStyle.vertical(context: context),
          AppConfig.instanceInit()!.client == Client.mahaNagar ? Column(
            children: [
              _checkCoatTap(dataState: dataState),
              dataState.tapOffValue == "1" ? CommonStyle.vertical(context: context) : SizedBox.shrink(),
              dataState.tapOffValue == "1" ? _tapOffLengthController(dataState: dataState) : SizedBox.shrink(),
              CommonStyle.vertical(context: context),
              _gasifiedRadioBtn(dataState: dataState),
              CommonStyle.vertical(context: context),
            ],
          ) : SizedBox.shrink(),
          _image(dataState: dataState),
          CommonStyle.vertical(context: context),
          CommonStyle.vertical(context: context),
          _button(dataState: dataState),
          CommonStyle.vertical(context: context),
          CommonStyle.vertical(context: context),
        ],
    );
  }

  Widget _bpNumberController({required FormInstallationDataState dataState}) {
    return TextFieldWidget(
      hintText: AppString.bpNumber,
      label: AppString.bpNumber,
      enabled: false,
      controller: dataState.bpNumberController,
    );
  }

  Widget _trNumberController({required FormInstallationDataState dataState}) {
    return TextFieldWidget(
      hintText: AppString.crNumber,
      label: AppString.crNumber,
      enabled: false,
      controller: dataState.trNumberController,
    );
  }

  Widget _proposedDateController(
      {required FormInstallationDataState dataState}) {
    return TextFieldWidget(
      hintText: AppString.lmcProDate,
      label: AppString.lmcProDate,
      enabled: false,
      controller: dataState.proposedDateController,
    );
  }

  Widget _feasibilityDateController(
      {required FormInstallationDataState dataState}) {
    return TextFieldWidget(
      hintText: AppString.lmcFeaDate,
      label: AppString.lmcFeaDate,
      enabled: false,
      controller: dataState.feasibilityDateController,
    );
  }

  Widget _installationDateController({required FormInstallationDataState dataState}) {
    return TextFieldWidget(
      star: AppString.star,
      hintText: AppString.installationDate,
      label: AppString.installationDate,
      textInputAction: TextInputAction.done,
      enabled: true,
      readOnly: true,
      controller: dataState.installationDateController,
      suffixIcon: IconButtonWidget(
        iconData: Icons.calendar_today,
        onPressed: () {
          BlocProvider.of<FormInstallationBloc>(context)
              .add(SelectInstallationDateEvent(context: context));
        },
      ),
      onTap: () {
        BlocProvider.of<FormInstallationBloc>(context)
            .add(SelectInstallationDateEvent(context: context));
      },
    );
  }

  Widget _delayReasonDropdown({required FormInstallationDataState dataState}) {
    return dataState.isDelayReason == true
        ? CommonStyle.col(
            context: context,
            child: DropdownWidget<LmcReasonModel>(
              star: AppString.star,
              label: AppString.reasonDelay,
              hint: AppString.reasonDelay,
              dropdownValue: dataState.delayReasonValue.name == null
                  ? null
                  : dataState.delayReasonValue,
              items: dataState.listOfDelayReason,
              onChanged: (val) {
                BlocProvider.of<FormInstallationBloc>(context)
                    .add(SelectDelayReasonValueEvent(delayReasonValue: val));
              },
            ),
          )
        : Container();
  }


  Widget _meterNumberController(
      {required FormInstallationDataState dataState}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 8,
          child: AutoCompleteTextFieldWidget(
            fieldKey: meterFieldKey,
            star: AppString.star,
            hintText: AppString.meterNumber,
            label: AppString.meterNumber,
            suggestions: dataState.listOfMeterNumberSerial.length == 0
                ? ["No Data Found"]
                : dataState.listOfMeterNumberSerial,
            keyboardType: TextInputType.text,
            controller: dataState.meterNumberSerialController,
            validator: (value) {
              if (value != null &&
                  value.isNotEmpty &&
                  !dataState.listOfMeterNumberSerial.contains(value)) {
                return AppString.meterNoErrorMsg;
              }
              return null;
            },
            onSelected: (val) {
              meterFieldKey.currentState?.validate();
              BlocProvider.of<FormInstallationBloc>(context).add(
                  SelectMeterNumberValueEvent(
                      context: context, meterReadingValue: val));
            },
            onChanged: (val) {
              meterFieldKey.currentState?.validate();
              BlocProvider.of<FormInstallationBloc>(context).add(
                  SelectMeterNumberValueEvent(
                      context: context, meterReadingValue: val));
            },
          ),
        ),
        CommonStyle.widthSpace(context: context),
        Flexible(
          flex: 4,
          child: TextFieldWidget(
            hintText: AppString.meterConnection,
            label: AppString.meterConnection,
            enabled: false,
            controller: dataState.meterConnectionMeterController,
          ),
        )
      ],
    );
  }

  Widget _initialMeterReading({required FormInstallationDataState dataState}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppString.star,
              style: Styles.stars,
            ),
            Text(
              AppString.meterInitNumber,
              style: Styles.labels,
            ),
          ],
        ),
        Row(
          children: [
            MeterNoWidget(enabled: false),
            CommonStyle.widthSpace(context: context),
            MeterNoWidget(enabled: false),
            CommonStyle.widthSpace(context: context),
            MeterNoWidget(enabled: false),
            CommonStyle.widthSpace(context: context),
            MeterNoWidget(enabled: false),
            CommonStyle.widthSpace(context: context),
            MeterNoWidget(enabled: false),
            CommonStyle.widthSpace(context: context),
            MeterNoWidget(enabled: false),
            CommonStyle.widthSpace(context: context),
            MeterNoWidget(enabled: false),
            CommonStyle.widthSpace(context: context),
            _meterReading1Controller(dataState: dataState),
            CommonStyle.widthSpace(context: context),
            _meterReading2Controller(dataState: dataState),
            CommonStyle.widthSpace(context: context),
            _meterReading3Controller(dataState: dataState),
          ],
        ),
      ],
    );
  }

  Widget _meterReading1Controller(
      {required FormInstallationDataState dataState}) {
    return MeterNoWidget(
      maxLength: 1,
      enabled: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.previous,
      controller: dataState.meterIniReading1Controller,
      focusNode: dataState.meterIniReading1FocusNode,
      onFieldSubmitted: (String value) {
        FocusScope.of(context)
            .requestFocus(dataState.meterIniReading1FocusNode);
      },
      onChanged: (val) {
        if (dataState.meterIniReading1Controller.text.length == 1) {
          FocusScope.of(context).nextFocus();
        } else {
          FocusScope.of(context).unfocus();
        }
        BlocProvider.of<FormInstallationBloc>(context)
            .add(MeterInitReadingEvent());
      },
    );
  }

  Widget _meterReading2Controller(
      {required FormInstallationDataState dataState}) {
    return MeterNoWidget(
      maxLength: 1,
      enabled: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.previous,
      controller: dataState.meterIniReading2Controller,
      focusNode: dataState.meterIniReading2FocusNode,
      onFieldSubmitted: (String value) {
        FocusScope.of(context)
            .requestFocus(dataState.meterIniReading2FocusNode);
      },
      onChanged: (val) {
        if (dataState.meterIniReading2Controller.text.length == 1) {
          FocusScope.of(context).nextFocus();
        } else {
          FocusScope.of(context).unfocus();
        }
        BlocProvider.of<FormInstallationBloc>(context)
            .add(MeterInitReadingEvent());
      },
    );
  }

  Widget _meterReading3Controller(
      {required FormInstallationDataState dataState}) {
    return MeterNoWidget(
      maxLength: 1,
      enabled: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      controller: dataState.meterIniReading3Controller,
      focusNode: dataState.meterIniReading3FocusNode,
      onFieldSubmitted: (String value) {
        FocusScope.of(context)
            .requestFocus(dataState.meterIniReading3FocusNode);
      },
      onChanged: (val) {
        if (dataState.meterIniReading3Controller.text.length == 1) {
          FocusScope.of(context).unfocus();
        } else {
          FocusScope.of(context).unfocus();
        }
        BlocProvider.of<FormInstallationBloc>(context)
            .add(MeterInitReadingEvent());
      },
    );
  }

  Widget _installRegulatorCheck({required FormInstallationDataState dataState}) {
    return CommonStyle.col(
      context: context,
      child: CheckboxWidget(
        isRequired: AppConfig.instanceInit()!.client == Client.hpoil ? true : false,
        title:  AppString.installRegulator,
        value: dataState.isInstallRegulator,
        onChanged: (v) => BlocProvider.of<FormInstallationBloc>(context).add(SelectInstallRegulatorEvent(context: context, installRegulator: v!)),

      )
      // Card(
      //   CheckBoxWidget
      //   child: Row(
      //     children: [
      //       Checkbox(
      //         value: dataState.isInstallRegulator,
      //         onChanged: (newVal) {
      //           BlocProvider.of<FormInstallationBloc>(context).add(
      //               SelectInstallRegulatorEvent(
      //                   context: context, installRegulator: newVal!));
      //         },
      //       ),
      //       Text(
      //         AppString.installRegulator,
      //         style: Styles.labels,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget _regulatorTypeDropdown(
      {required FormInstallationDataState dataState}) {
    return dataState.isInstallRegulator == true
        ? CommonStyle.col(
            context: context,
            child: DropdownWidget<LmcReasonModel>(
              star: AppString.star,
              label: AppString.regulatorType,
              hint: AppString.regulatorType,
              dropdownValue: dataState.regulatorTypeValue.name == null
                  ? null
                  : dataState.regulatorTypeValue,
              items: dataState.listOfRegulatorType,
              onChanged: (val) {
                BlocProvider.of<FormInstallationBloc>(context).add(
                    SelectRegulatorTypeValueEvent(
                        regulatorTypeValue: val!, context: context));
              },
            ),
          )
        : Container();
  }

  Widget _regulatorController({required FormInstallationDataState dataState}) {
    return dataState.isInstallRegulator == true
        ? dataState.isRegulator == false
            ? dataState.regulatorTypeValue.name != null
                ? CommonStyle.col(
                    context: context,
                    child: AutoCompleteTextFieldWidget(
                      fieldKey: regulatorFieldKey,
                      star: AppString.star,
                      enabled: dataState.regulatorTypeValue.name == null
                          ? false
                          : true,
                      label: dataState.regulatorTypeValue.name != "PRV"
                          ? AppString.srNumber
                          : AppString.regulator,
                      hintText: dataState.regulatorTypeValue.name != "PRV"
                          ? AppString.srNumber
                          : AppString.regulator,
                      suggestions: dataState.listOfRegulatorSerial.length == 0
                          ? ["No Data Found"]
                          : dataState.listOfRegulatorSerial,
                      keyboardType: TextInputType.text,
                      controller: dataState.regulatorSerialController,
                      onSelected: (val) {
                        regulatorFieldKey.currentState?.validate();
                        BlocProvider.of<FormInstallationBloc>(context).add(
                            SelectRegulatorsValueEvent(
                                context: context, regulatorsValue: val));
                      },
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            !dataState.listOfRegulatorSerial.contains(value)) {
                          return dataState.regulatorTypeValue.name != "PRV"
                              ? AppString.srNoErrorMsg
                              : AppString.regulatorNoErrorMsg;
                        }
                        return null;
                      },
                      onChanged: (val) async {
                        await regulatorFieldKey.currentState?.validate();
                        // BlocProvider.of<FormInstallationBloc>(context).add(
                        //     SelectRegulatorsValueEvent(
                        //         context: context, regulatorsValue: val));
                      },
                    ),
                  )
                : Container()
            : DottedLoaderWidget()
        : Container();
  }

  Widget _mrNumberController({required FormInstallationDataState dataState}) {
    return dataState.isInstallRegulator == true
        ? dataState.isRegulator == false
            ? dataState.regulatorTypeValue.name == "SR"
                ? CommonStyle.col(
                    context: context,
                    child: AutoCompleteTextFieldWidget(
                      fieldKey: mRegulatorFieldKey,
                      star: AppString.star,
                      label: AppString.meterRegulator,
                      hintText: AppString.meterRegulator,
                      suggestions: dataState.listOfMRSerial.length == 0
                          ? ["No Data Found"]
                          : dataState.listOfMRSerial,
                      keyboardType: TextInputType.text,
                      controller: dataState.mrNumberController,
                      onSelected: (val) {
                        mRegulatorFieldKey.currentState?.validate();
                        BlocProvider.of<FormInstallationBloc>(context).add(
                            SelectMREvent(context: context, mRegulators: val));
                      },
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            !dataState.listOfMRSerial.contains(value)) {
                          return AppString.mrNoErrorMsg;
                        }
                        return null;
                      },
                      onChanged: (val) async {
                        await mRegulatorFieldKey.currentState?.validate();
                        // BlocProvider.of<FormInstallationBloc>(context).add(
                        //     SelectMREvent(context: context, mRegulators: val));
                      },
                    ),
                  )
                : Container()
            : DottedLoaderWidget()
        : Container();
  }

  Widget _rfcDateControllerController(
      {required FormInstallationDataState dataState}) {
    return dataState.isInstallRegulator == true
        ? CommonStyle.col(
            context: context,
            child: TextFieldWidget(
              star: AppString.star,
              hintText: AppString.rfcDate,
              label: AppString.rfcDate,
              textInputAction: TextInputAction.done,
              enabled: true,
              readOnly: true,
              controller: dataState.rfcDateController,
              suffixIcon: IconButtonWidget(
                iconData: Icons.calendar_today,
                onPressed: () {
                  BlocProvider.of<FormInstallationBloc>(context)
                      .add(SelectRFCDateEvent(context: context));
                },
              ),
              onTap: () {
                BlocProvider.of<FormInstallationBloc>(context)
                    .add(SelectRFCDateEvent(context: context));
              },
            ),
          )
        : Container();
  }

  Widget _ngConversionDateController(
      {required FormInstallationDataState dataState}) {
    return dataState.isInstallRegulator == true
        ? CommonStyle.col(
            context: context,
            child: TextFieldWidget(
              star: AppString.star,
              hintText: AppString.ngProposedDate,
              label: AppString.ngProposedDate,
              readOnly: true,
              controller: dataState.ngConversionDateController,
              suffixIcon: IconButtonWidget(
                iconData: Icons.calendar_today,
                onPressed: () {
                  BlocProvider.of<FormInstallationBloc>(context)
                      .add(SelectNGConversionDateEvent(context: context));
                },
              ),
              onTap: () {
                BlocProvider.of<FormInstallationBloc>(context)
                    .add(SelectNGConversionDateEvent(context: context));
              },
            ),
          )
        : Container();
  }

  Widget _locationOfHouse({required FormInstallationDataState dataState}) {
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: TextFieldWidget(
            enabled: false,
            star: AppString.star,
            hintText: AppString.latOfHouse,
            label: AppString.latOfHouse,
            controller: dataState.latOfHouseController,
          ),
        ),
        CommonStyle.widthSpace(context: context),
        Flexible(
          flex: 3,
          child: TextFieldWidget(
            enabled: false,
            star: AppString.star,
            hintText: AppString.longOfHouse,
            label: AppString.longOfHouse,
            controller: dataState.longOfHouseController,
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

  Widget _materialList({required FormInstallationDataState dataState}) {
    return Column(
      children: [
        Column(
          children: dataState.materialList.mapIndexed((index, e) {
            return Column(
              children: [
                Row(
                  children: [
                    e.name.toLowerCase().contains("pipe")
                        ? Flexible(
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
                    CommonStyle.widthSpace(context: context),
                    e.name.toLowerCase().contains("pipe")
                        ? Flexible(
                      flex: 3,
                      child: TextFieldWidget(
                        hintText: e.unit,
                        label: e.unit,
                        controller: e.controller,
                        enabled: true,
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          BlocProvider.of<FormInstallationBloc>(
                              context)
                              .add(SelectQTYLMCEvent(
                              context: context, qtyValue: val));
                        },
                      ),
                    )
                        : Flexible(
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
                CommonStyle.vertical(context: context),
              ],
            );
          }).toList(),
        ),
        dataState.isGiExtraPipe == false
            ? _extraGiPipeWidget(dataState: dataState)
            : DottedLoaderWidget(),
        CommonStyle.vertical(context: context),
      ],
    );
  }

  Widget _materialCopperList({required FormInstallationDataState dataState}) {
    return AppConfig.instanceInit()!.client == Client.hpoil
        ? Column(
      children: [
        Column(
          children: dataState.materialListCopper.mapIndexed((index, e) {
            return Column(
              children: [
                Row(
                  children: [
                    e.name.toLowerCase().contains("pipe")
                        ? Flexible(
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
                    CommonStyle.widthSpace(context: context),
                    e.name.toLowerCase().contains("pipe")
                        ? Flexible(
                      flex: 3,
                      child: TextFieldWidget(
                        hintText: e.unit,
                        label: e.unit,
                        controller: e.controller,
                        enabled: true,
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          BlocProvider.of<FormInstallationBloc>(
                              context)
                              .add(SelectQTYLMCCopperEvent(
                              context: context, qtyValue: val));
                        },
                      ),
                    )
                        : Flexible(
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
                CommonStyle.vertical(context: context),
              ],
            );
          }).toList(),
        ),
        dataState.isCopperExtraPipe == false
            ? _extraCopperPipeWidget(dataState: dataState)
            : DottedLoaderWidget(),
        CommonStyle.vertical(context: context),
        _extraTotalPipeWidget(dataState: dataState),
        CommonStyle.vertical(context: context),
        // if(AppConfig.instanceInit()!.client == Client.hpoil)...[
        //   _manualPipeCheckbox(dataState: dataState),
        //   CommonStyle.vertical(context: context),
        //   _manualPipLengthWidget(dataState: dataState),
        //   CommonStyle.vertical(context: context),
        // ],
      ],
    )
        : SizedBox.shrink();
  }

  Widget _manualPipeCheckbox({required FormInstallationDataState dataState}){
    return CheckboxWidget(
      title: "Manual Pipe",
      value: dataState.isManualPipe,
      onChanged: (v) => BlocProvider.of<FormInstallationBloc>(context).add(SelectManualPipeEvent(isValue: v!)),
    );
  }
  Widget _manualPipLengthWidget({required FormInstallationDataState dataState}){
    return dataState.isManualPipe ? TextFieldWidget(
      hintText: AppString.extraPipe,
      label: AppString.extraPipe,
      controller: dataState.manualPipLengthCtrl,
    ) : SizedBox.shrink();
  }


  Widget _extraGiPipeWidget({required FormInstallationDataState dataState}) {
    return RowWidget(
      widget1: TextFieldWidget(
        enabled: false,
        hintText: AppString.extraPipe,
        label: AppString.extraPipe,
        controller: dataState.extraGiPipeCtrl,
      ),
      widget2: TextFieldWidget(
        enabled: false,
        hintText: AppString.extraPrice,
        label: AppString.extraPrice,
        controller: dataState.extraGiPriceCtrl,
      ),
    );
  }


  Widget _extraCopperPipeWidget({required FormInstallationDataState dataState}) {
    return RowWidget(
      widget1: TextFieldWidget(
        enabled: false,
        hintText: AppString.extraPipeCopper,
        label: AppString.extraPipeCopper,
        controller: dataState.extraCopperPipeCtrl,
      ),
      widget2: TextFieldWidget(
        enabled: false,
        hintText: AppString.extraPriceCopper,
        label: AppString.extraPriceCopper,
        controller: dataState.extraCopperPriceCtrl,
      ),
    );
  }

  Widget _extraTotalPipeWidget({required FormInstallationDataState dataState}) {
    return RowWidget(
      widget1: TextFieldWidget(
        enabled: false,
        hintText: AppString.extraPipeTotal,
        label: AppString.extraPipeTotal,
        controller: dataState.extraTotalPipeCtrl,
      ),
      widget2: TextFieldWidget(
        enabled: false,
        hintText: AppString.extraPriceTotal,
        label: AppString.extraPriceTotal,
        controller: dataState.extraTotalPriceCtrl,
      ),
    );
  }

  Widget _checkListRFC({required FormInstallationDataState dataState}) {
    var w = MediaQuery.of(context).size.width * 0.5;
    print("_checkListRFC-->${w}");
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 4.0,
      ),
      shrinkWrap: true,
      itemCount: dataState.listOfAllRFC.length,
      itemBuilder: (context, index) {
        return Card(
          child: Row(
            children: [
              Checkbox(
                value: dataState.listOfAllRFC[index].isSelected,
                onChanged: (newVal) {
                  BlocProvider.of<FormInstallationBloc>(context).add(
                      SelectRFCCheckValueEvent(
                          context: context, isSelected: newVal!, index: index));
                },
              ),
              Text(
                dataState.listOfAllRFC[index].value!,
                style: Styles.labels,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _checkCoatTap({required FormInstallationDataState dataState}) {
    var w = MediaQuery.of(context).size.width * 0.5;
    print("_checkListRFC-->${w}");
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 4.0,
      ),
      shrinkWrap: true,
      itemCount: dataState.coatTapList.length,
      itemBuilder: (context, index) {
        final option = dataState.coatTapList[index];
        final isSelected = dataState.selectedCoatTap.contains(option);
        return Card(
          child: Row(
            children: [
              Checkbox(
                value: isSelected,
              onChanged: (bool? value) {
                    BlocProvider.of<FormInstallationBloc>(context).add(
                        ToggleOptionEvent(
                          option: option,isSelected: isSelected));

                  },
              ),
              Text(
                option,
                style: Styles.labels,
              ),
            ],
          ),
        );
      },
    );
  }


  Widget _tapOffLengthController({required FormInstallationDataState dataState}) {
    return TextFieldWidget(
      star: "* ",
      hintText: "Tap Off Length",
      label: "Tap Off Length",
      keyboardType: TextInputType.number,
      controller: dataState.tapOffLengthController,
    );
  }

  Widget _gasifiedRadioBtn({required FormInstallationDataState dataState}) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
       padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label with underline or bold text
          const Text(
            "Gasified",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: dataState.gasifiedList.map((option) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: dataState.selectedGasified == option
                          ? EnvironmentConfig.of(context)!.primaryTheme
                          : Colors.grey.shade300,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: RadioListTile<String>(
                    title: Text(
                      option,
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    value: option,
                    groupValue: dataState.selectedGasified,
                    onChanged: (value) {
                      if (value != null) {
                        context
                            .read<FormInstallationBloc>()
                            .add(SelectGasifiedRadioEvent(option: value));
                      }
                    },
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }




  Widget _image({required FormInstallationDataState dataState}) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ImageWidget(
          isRequired: true,
          title: AppString.meter,
          imgFile: dataState.meterPhoto,
          onPressed: () {
            showModalBottomSheet(
                enableDrag: true,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return ImagePopWidget(
                    onTapCamera: () async {
                      Navigator.of(context).pop();
                      BlocProvider.of<FormInstallationBloc>(context)
                          .add(CaptureCameraMeterEvent());
                    },
                    onTapGallery: () async {
                      Navigator.of(context).pop();
                      BlocProvider.of<FormInstallationBloc>(context)
                          .add(CaptureGalleryMeterEvent());
                    },
                  );
                });
          },
        ),
        dataState.isInstallRegulator == true
            ? ImageWidget(
          isRequired: AppConfig.instanceInit()!.client == Client.hpoil ? true : false,
                title: AppString.rfc,
                imgFile: dataState.rfcCardPhoto,
                onPressed: () {
                  showModalBottomSheet(
                      enableDrag: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return ImagePopWidget(
                          onTapCamera: () async {
                            Navigator.of(context).pop();
                            BlocProvider.of<FormInstallationBloc>(context)
                                .add(CaptureCameraRFCCardEvent());
                          },
                          onTapGallery: () async {
                            Navigator.of(context).pop();
                            BlocProvider.of<FormInstallationBloc>(context)
                                .add(CaptureGalleryRFCCardEvent());
                          },
                        );
                      });
                },
              )
            : Container(),
        dataState.isInstallRegulator == true
            ? ImageWidget(
                isRequired: AppConfig.instanceInit()!.client == Client.hpoil ? true : false,
                title: AppString.pneumatic,
                imgFile: dataState.pneumaticTestReportPhoto,
                onPressed: () {
                  showModalBottomSheet(
                      enableDrag: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return ImagePopWidget(
                          onTapCamera: () async {
                            Navigator.of(context).pop();
                            BlocProvider.of<FormInstallationBloc>(context)
                                .add(CaptureCameraPneumaticEvent());
                          },
                          onTapGallery: () async {
                            Navigator.of(context).pop();
                            BlocProvider.of<FormInstallationBloc>(context)
                                .add(CaptureGalleryPneumaticEvent());
                          },
                        );
                      });
                },
              )
            : Container(),
        ImageWidget(
          isRequired: true,
          title: AppString.housePhoto,
          imgFile: dataState.housePhoto,
          onPressed: () {
            showModalBottomSheet(
                enableDrag: true,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return CameraPopWidget(
                    onTapCamera: () async {
                      Navigator.of(context).pop();
                      BlocProvider.of<FormInstallationBloc>(context)
                          .add(CaptureCameraHouseEvent(context: context));
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
              BlocProvider.of<FormInstallationBloc>(context)
                  .add(SubmitFormInstallationEvent(context: context));
            })
        : DottedLoaderWidget();
  }
}
