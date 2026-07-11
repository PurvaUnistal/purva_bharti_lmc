import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            message: "Do you want to exit Installation?",
            okButtonText: "Exit",
            onPressed: () => Navigator.of(context).pop(true)))) ??
        false;
  }

  _itemBuilder({required FormInstallationDataState dataState}) {
    return ListView(
      padding: EdgeInsets.all(8),
      children: [
        Text(
          AppString.installationForm,
          style: Styles.text,
          textAlign: TextAlign.center,
        ),
        CommonStyle.vertical(context: context),
        RowWidget(
            widget1: _bpNumberController(stateData: dataState),
            widget2: _trNumberController(stateData: dataState)),
        CommonStyle.vertical(context: context),
        RowWidget(
            widget1: _proposedDateController(stateData: dataState),
            widget2: _feasibilityDateController(stateData: dataState)),
        CommonStyle.vertical(context: context),
        _installationDateController(stateData: dataState),
        _delayReasonDropdown(stateData: dataState),
        CommonStyle.vertical(context: context),
        _meterNumberController(stateData: dataState),
        _initialMeterReading(stateData: dataState),
        _installRegulatorCheck(stateData: dataState),
        _regulatorTypeDropdown(stateData: dataState),
        _regulatorController(stateData: dataState),
        _mrNumberController(stateData: dataState),
        _ngConversionDateController(stateData: dataState),
        _rfcDateControllerController(stateData: dataState),
        CommonStyle.vertical(context: context),
        _materialList(stateData: dataState),
        _checkListRFC(stateData: dataState),
        CommonStyle.vertical(context: context),
        _locationOfHouse(stateData: dataState),
        CommonStyle.vertical(context: context),
        AppConfig.instanceInit()!.client == Client.mahaNagar
            ? Column(
          children: [
            _checkCoatTap(stateData: dataState),
            dataState.tapOffValue == "1"
                ? CommonStyle.vertical(context: context)
                : SizedBox.shrink(),
            dataState.tapOffValue == "1"
                ? _tapOffLengthController(stateData: dataState)
                : SizedBox.shrink(),
            CommonStyle.vertical(context: context),
            _gasifiedRadioBtn(stateData: dataState),
            CommonStyle.vertical(context: context),
          ],
        )
            : SizedBox.shrink(),
        _image(stateData: dataState),
        CommonStyle.vertical(context: context),
        CommonStyle.vertical(context: context),
        _button(dataState: dataState),
        CommonStyle.vertical(context: context),
        CommonStyle.vertical(context: context),
      ],
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
      hintText: AppString.crNumber,
      label: AppString.crNumber,
      enabled: false,
      controller: stateData.trNumberController,
    );
  }

  Widget _proposedDateController(
      {required FormInstallationDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.lmcProDate,
      label: AppString.lmcProDate,
      enabled: false,
      controller: stateData.proposedDateController,
    );
  }

  Widget _feasibilityDateController(
      {required FormInstallationDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.lmcFeaDate,
      label: AppString.lmcFeaDate,
      enabled: false,
      controller: stateData.feasibilityDateController,
    );
  }

  Widget _installationDateController(
      {required FormInstallationDataState stateData}) {
    return TextFieldWidget(
      star: AppString.star,
      hintText: AppString.installationDate,
      label: AppString.installationDate,
      textInputAction: TextInputAction.done,
      enabled: true,
      controller: stateData.installationDateController,
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

  Widget _delayReasonDropdown({required FormInstallationDataState stateData}) {
    return stateData.isDelayReason == true
        ? CommonStyle.col(
      context: context,
      child: DropdownWidget<LmcReasonModel>(
        star: AppString.star,
        label: AppString.reasonDelay,
        hint: AppString.reasonDelay,
        dropdownValue: stateData.delayReasonValue.name == null
            ? null
            : stateData.delayReasonValue,
        items: stateData.listOfDelayReason,
        onChanged: (val) {
          BlocProvider.of<FormInstallationBloc>(context)
              .add(SelectDelayReasonValueEvent(delayReasonValue: val));
        },
      ),
    )
        : Container();
  }

  Widget _meterNumberController(
      {required FormInstallationDataState stateData}) {
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
            suggestions: stateData.listOfMeterNumberSerial.length == 0
                ? ["No Data Found"]
                : stateData.listOfMeterNumberSerial,
            keyboardType: TextInputType.text,
            controller: stateData.meterNumberSerialController,
            validator: (value) {
              if (value != null &&
                  value.isNotEmpty &&
                  !stateData.listOfMeterNumberSerial.contains(value)) {
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
            controller: stateData.meterConnectionMeterController,
          ),
        )
      ],
    );
  }

  Widget _initialMeterReading({required FormInstallationDataState stateData}) {
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
            _meterReading1Controller(stateData: stateData),
            CommonStyle.widthSpace(context: context),
            _meterReading2Controller(stateData: stateData),
            CommonStyle.widthSpace(context: context),
            _meterReading3Controller(stateData: stateData),
          ],
        ),
      ],
    );
  }

  Widget _meterReading1Controller(
      {required FormInstallationDataState stateData}) {
    return MeterNoWidget(
      maxLength: 1,
      enabled: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      controller: stateData.meterIniReading1Controller,
      focusNode: stateData.meterIniReading1FocusNode,
      onFieldSubmitted: (String value) {
        FocusScope.of(context)
            .requestFocus(stateData.meterIniReading2FocusNode);
      },
      onChanged: (val) {
        if (stateData.meterIniReading1Controller.text.length == 1) {
          FocusScope.of(context).nextFocus();
        }
        BlocProvider.of<FormInstallationBloc>(context)
            .add(MeterInitReadingEvent());
      },
    );
  }

  Widget _meterReading2Controller(
      {required FormInstallationDataState stateData}) {
    return MeterNoWidget(
      maxLength: 1,
      enabled: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      controller: stateData.meterIniReading2Controller,
      focusNode: stateData.meterIniReading2FocusNode,
      onFieldSubmitted: (String value) {
        FocusScope.of(context)
            .requestFocus(stateData.meterIniReading3FocusNode);
      },
      onChanged: (val) {
        if (stateData.meterIniReading2Controller.text.length == 1) {
          FocusScope.of(context).nextFocus();
        }
        BlocProvider.of<FormInstallationBloc>(context)
            .add(MeterInitReadingEvent());
      },
    );
  }

  Widget _meterReading3Controller(
      {required FormInstallationDataState stateData}) {
    return MeterNoWidget(
      maxLength: 1,
      enabled: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      controller: stateData.meterIniReading3Controller,
      focusNode: stateData.meterIniReading3FocusNode,
      onFieldSubmitted: (String value) {
        FocusScope.of(context).unfocus();
      },
      onChanged: (val) {
        if (stateData.meterIniReading3Controller.text.length == 1) {
          FocusScope.of(context).unfocus();
        }
        BlocProvider.of<FormInstallationBloc>(context)
            .add(MeterInitReadingEvent());
      },
    );
  }

  Widget _installRegulatorCheck(
      {required FormInstallationDataState stateData}) {
    return CommonStyle.col(
      context: context,
      child: Card(
        child: Row(
          children: [
            Checkbox(
              value: stateData.isInstallRegulator,
              onChanged: (newVal) {
                BlocProvider.of<FormInstallationBloc>(context).add(
                    SelectInstallRegulatorEvent(
                        context: context, installRegulator: newVal!));
              },
            ),
            Text(
              AppString.installRegulator,
              style: Styles.labels,
            ),
          ],
        ),
      ),
    );
  }

  Widget _regulatorTypeDropdown(
      {required FormInstallationDataState stateData}) {
    return stateData.isInstallRegulator == true
        ? CommonStyle.col(
      context: context,
      child: DropdownWidget<LmcReasonModel>(
        star: AppString.star,
        label: AppString.regulatorType,
        hint: AppString.regulatorType,
        dropdownValue: stateData.regulatorTypeValue.name == null
            ? null
            : stateData.regulatorTypeValue,
        items: stateData.listOfRegulatorType,
        onChanged: (val) {
          // Clear stale serials from the previous type before switching,
          // so an old PRV/SR value doesn't linger in the fields.
          stateData.regulatorSerialController.clear();
          stateData.mrNumberController.clear();
          regulatorFieldKey.currentState?.reset();
          mRegulatorFieldKey.currentState?.reset();
          BlocProvider.of<FormInstallationBloc>(context).add(
              SelectRegulatorTypeValueEvent(
                  regulatorTypeValue: val!, context: context));
        },
      ),
    )
        : Container();
  }

  /// Regulator / SR Number field.
  /// - Hidden until "Install Regulator" is checked AND a type is selected.
  /// - Shows a single DottedLoaderWidget while serials are loading.
  /// - Label/hint switch between "SR Number" and "Regulator" based on type.
  Widget _regulatorController({required FormInstallationDataState stateData}) {
    if (stateData.isInstallRegulator != true) {
      return Container();
    }

    if (stateData.isRegulator == true) {
      // Loading serials -> show the loader FIRST, before the type-null check,
      // so it is visible even if the type value hasn't been committed to
      // state yet by the bloc. (MR widget below shows nothing while loading.)
      return DottedLoaderWidget();
    }

    if (stateData.regulatorTypeValue.name == null) {
      return Container();
    }

    return CommonStyle.col(
      context: context,
      child: AutoCompleteTextFieldWidget(
        fieldKey: regulatorFieldKey,
        star: AppString.star,
        enabled: true,
        label: stateData.regulatorTypeValue.name == "SR"
            ? AppString.srNumber
            : AppString.regulator,
        hintText: stateData.regulatorTypeValue.name == "SR"
            ? AppString.srNumber
            : AppString.regulator,
        suggestions: stateData.listOfRegulatorSerial.length == 0
            ? ["No Data Found"]
            : stateData.listOfRegulatorSerial,
        keyboardType: TextInputType.text,
        controller: stateData.regulatorSerialController,
        onSelected: (val) {
          regulatorFieldKey.currentState?.validate();
          BlocProvider.of<FormInstallationBloc>(context).add(
              SelectRegulatorsValueEvent(
                  context: context, regulatorsValue: val));
        },
        validator: (value) {
          if (value != null &&
              value.isNotEmpty &&
              !stateData.listOfRegulatorSerial.contains(value)) {
            return stateData.regulatorTypeValue.name == "SR"
                ? AppString.srNoErrorMsg
                : AppString.regulatorNoErrorMsg;
          }
          return null;
        },
        onChanged: (val) async {
          await regulatorFieldKey.currentState?.validate();
        },
      ),
    );
  }

  /// Meter Regulator (MR) field.
  /// - Only ever shown when the selected regulator type is "SR".
  /// - Never renders its own loader (the regulator field above owns the
  ///   loading indicator), so PRV selection and loading states no longer
  ///   show a stray MR field/loader.
  Widget _mrNumberController({required FormInstallationDataState stateData}) {
    if (stateData.isInstallRegulator != true ||
        stateData.regulatorTypeValue.name != "SR") {
      return Container();
    }

    if (stateData.isRegulator == true) {
      // Loader already displayed by _regulatorController.
      return Container();
    }

    return CommonStyle.col(
      context: context,
      child: AutoCompleteTextFieldWidget(
        fieldKey: mRegulatorFieldKey,
        star: AppString.star,
        label: AppString.meterRegulator,
        hintText: AppString.meterRegulator,
        suggestions: stateData.listOfMRSerial.length == 0
            ? ["No Data Found"]
            : stateData.listOfMRSerial,
        keyboardType: TextInputType.text,
        controller: stateData.mrNumberController,
        onSelected: (val) {
          mRegulatorFieldKey.currentState?.validate();
          BlocProvider.of<FormInstallationBloc>(context)
              .add(SelectMREvent(context: context, mRegulators: val));
        },
        validator: (value) {
          if (value != null &&
              value.isNotEmpty &&
              !stateData.listOfMRSerial.contains(value)) {
            return AppString.mrNoErrorMsg;
          }
          return null;
        },
        onChanged: (val) async {
          await mRegulatorFieldKey.currentState?.validate();
        },
      ),
    );
  }

  Widget _rfcDateControllerController(
      {required FormInstallationDataState stateData}) {
    return stateData.isInstallRegulator == true
        ? CommonStyle.col(
      context: context,
      child: TextFieldWidget(
        star: AppString.star,
        hintText: AppString.rfcDate,
        label: AppString.rfcDate,
        textInputAction: TextInputAction.done,
        enabled: true,
        controller: stateData.rfcDateController,
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
      {required FormInstallationDataState stateData}) {
    return stateData.isInstallRegulator == true
        ? CommonStyle.col(
      context: context,
      child: TextFieldWidget(
        star: AppString.star,
        hintText: AppString.ngProposedDate,
        label: AppString.ngProposedDate,
        controller: stateData.ngConversionDateController,
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
        CommonStyle.widthSpace(context: context),
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
            final isPipe = e.name.toLowerCase().contains("pipe");
            return Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 7,
                      child: TextFieldWidget(
                        hintText: isPipe ? AppString.pipe : AppString.material,
                        label: isPipe ? AppString.pipe : AppString.material,
                        initialValue: e.name,
                        enabled: false,
                      ),
                    ),
                    CommonStyle.widthSpace(context: context),
                    Flexible(
                      flex: 3,
                      child: TextFieldWidget(
                        hintText: e.unit,
                        label: e.unit,
                        controller: e.controller,
                        enabled: true,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        onChanged: isPipe
                            ? (val) {
                          BlocProvider.of<FormInstallationBloc>(context)
                              .add(SelectQTYLMCEvent(
                              context: context, qtyValue: val));
                        }
                            : null,
                      ),
                    ),
                  ],
                ),
                CommonStyle.vertical(context: context),
              ],
            );
          }).toList(),
        ),
        stateData.isExtraPipe == false
            ? _extraPipeWidget(stateData: stateData)
            : DottedLoaderWidget(),
        CommonStyle.vertical(context: context),
      ],
    );
  }

  Widget _extraPipeWidget({required FormInstallationDataState stateData}) {
    return RowWidget(
      widget1: TextFieldWidget(
        enabled: false,
        hintText: AppString.extraPipe,
        label: AppString.extraPipe,
        controller: stateData.extraPipeController,
      ),
      widget2: TextFieldWidget(
        enabled: false,
        hintText: AppString.extraPrice,
        label: AppString.extraPrice,
        controller: stateData.extraPriceController,
      ),
    );
  }

  Widget _checkListRFC({required FormInstallationDataState stateData}) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 4.0,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: stateData.listOfAllRFC.length,
      itemBuilder: (context, index) {
        return Card(
          child: Row(
            children: [
              Checkbox(
                value: stateData.listOfAllRFC[index].isSelected,
                onChanged: (newVal) {
                  BlocProvider.of<FormInstallationBloc>(context).add(
                      SelectRFCCheckValueEvent(
                          context: context,
                          isSelected: newVal!,
                          index: index));
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

  Widget _checkCoatTap({required FormInstallationDataState stateData}) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 4.0,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: stateData.coatTapList.length,
      itemBuilder: (context, index) {
        final option = stateData.coatTapList[index];
        final isSelected = stateData.selectedCoatTap.contains(option);
        return Card(
          child: Row(
            children: [
              Checkbox(
                value: isSelected,
                onChanged: (bool? value) {
                  BlocProvider.of<FormInstallationBloc>(context).add(
                      ToggleOptionEvent(
                          option: option, isSelected: isSelected));
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

  Widget _tapOffLengthController(
      {required FormInstallationDataState stateData}) {
    return TextFieldWidget(
      star: "* ",
      hintText: "Tap Off Length",
      label: "Tap Off Length",
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      controller: stateData.tapOffLengthController,
    );
  }

  Widget _gasifiedRadioBtn({required FormInstallationDataState stateData}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            children: stateData.gasifiedList.map((option) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: stateData.selectedGasified == option
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
                    groupValue: stateData.selectedGasified,
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
        stateData.isInstallRegulator == true
            ? ImageWidget(
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
        stateData.isInstallRegulator == true
            ? ImageWidget(
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
