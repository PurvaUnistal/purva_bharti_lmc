import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_lmc/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:new_lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:new_lmc/Utils/common_widgets/WidgetStyles/common_style.dart';
import 'package:new_lmc/Utils/common_widgets/auto_complete_text_field_widget.dart';
import 'package:new_lmc/Utils/common_widgets/background_widget.dart';
import 'package:new_lmc/Utils/common_widgets/button_widget.dart';
import 'package:new_lmc/Utils/common_widgets/dropdown_widget.dart';
import 'package:new_lmc/Utils/common_widgets/icon_button.dart';
import 'package:new_lmc/Utils/common_widgets/image_pop_widget.dart';
import 'package:new_lmc/Utils/common_widgets/message_box_two_button_pop.dart';
import 'package:new_lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:new_lmc/Utils/common_widgets/res/app_color.dart';
import 'package:new_lmc/Utils/common_widgets/res/app_string.dart';
import 'package:new_lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:new_lmc/Utils/common_widgets/row_widget.dart';
import 'package:new_lmc/Utils/common_widgets/text_form_widget.dart';
import 'package:new_lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:new_lmc/features/Installation/FormInstallation/presentation/Widgets/meter_no_widget.dart';
import 'package:new_lmc/features/Installation/FormRFCInstallation/domain/bloc/form_rfc_installation_bloc.dart';
import 'package:new_lmc/features/Installation/FormRFCInstallation/domain/bloc/form_rfc_installation_event.dart';
import 'package:new_lmc/features/Installation/FormRFCInstallation/domain/bloc/form_rfc_installation_state.dart';
import 'package:new_lmc/features/Installation/LMCInstallation/presentation/Widgets/cameraPopWidget.dart';
import 'package:new_lmc/features/NGC/NGCForm/presentation/Widget/network_file_image.dart';

class FormRFCInstallationView extends StatefulWidget {
  const FormRFCInstallationView({
    super.key,
  });

  @override
  State<FormRFCInstallationView> createState() => _FormRFCInstallationViewState();
}

class _FormRFCInstallationViewState extends State<FormRFCInstallationView> {
  @override
  void initState() {
    BlocProvider.of<FormRFCInstallationBloc>(context).add(FormRFCInstallationPageLoadEvent(context: context));
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.green50,
      body: BlocBuilder<FormRFCInstallationBloc, FormRFCInstallationState>(
        builder: (context, state) {
          if (state is FormRFCInstallationDataState) {
            return Form(key: formKey, onWillPop: _onWillPop, child: BackgroundWidget(child: _itemBuilder(dataState: state)));
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

  _itemBuilder({required FormRFCInstallationDataState dataState}) {
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
          Text(
            AppString.installationForm,
            style: Styles.text,
            textAlign: TextAlign.center,
          ),
          CommonStyle.vertical(context: context),
          RowWidget(widget1: _bpNumberController(stateData: dataState), widget2: _trNumberController(stateData: dataState)),
          CommonStyle.vertical(context: context),
          RowWidget(widget1: _proposedDateController(stateData: dataState), widget2: _feasibilityDateController(stateData: dataState)),
          CommonStyle.vertical(context: context),
          _installationDateController(stateData: dataState),
          _delayReasonDropdown(stateData: dataState),
          CommonStyle.vertical(context: context),
          _meterNumberController(stateData: dataState),
          /* CommonStyle.vertical(context: context),
          _meterConnectionDropdown(stateData: dataState),*/
          _initialMeterReading(stateData: dataState),
          _installRegulatorCheck(stateData: dataState),
          _regulatorTypeDropdown(stateData: dataState),
          _srNumberController(stateData: dataState),
          _regulatorController(stateData: dataState),
          _ngConversionDateController(stateData: dataState),
          _rfcDateControllerController(stateData: dataState),
          CommonStyle.vertical(context: context),
          _materialList(stateData: dataState),
          _checkListRFC(stateData: dataState),
          CommonStyle.vertical(context: context),
          _locationOfHouse(stateData: dataState),
          CommonStyle.vertical(context: context),
          _image(stateData: dataState),
          CommonStyle.vertical(context: context),
          CommonStyle.vertical(context: context),
          _button(dataState: dataState),
          CommonStyle.vertical(context: context),
          CommonStyle.vertical(context: context),
        ],
      ),
    );
  }

  Widget _bpNumberController({required FormRFCInstallationDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.bpNumber,
      label: AppString.bpNumber,
      enabled: false,
      controller: stateData.bpNumberController,
    );
  }

  Widget _trNumberController({required FormRFCInstallationDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.crNumber,
      label: AppString.crNumber,
      enabled: false,
      controller: stateData.trNumberController,
    );
  }

  Widget _proposedDateController({required FormRFCInstallationDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.lmcProDate,
      label: AppString.lmcProDate,
      enabled: false,
      controller: stateData.proposedDateController,
    );
  }

  Widget _feasibilityDateController({required FormRFCInstallationDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.lmcFeaDate,
      label: AppString.lmcFeaDate,
      enabled: false,
      controller: stateData.feasibilityDateController,
    );
  }

  Widget _installationDateController({required FormRFCInstallationDataState stateData}) {
    return TextFieldWidget(
      star: AppString.star,
      hintText: AppString.installationDate,
      label: AppString.installationDate,
      enabled: true,
      controller: stateData.installationDateController,
      textInputAction: TextInputAction.done,
      enableInteractiveSelection: false,
      suffixIcon: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Icon(Icons.calendar_today, color: AppColor.primer,),
      ),
      keyboardType: TextInputType.datetime,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        BlocProvider.of<FormRFCInstallationBloc>(context).add(SelectInstallationDateEvent(context: context));
      },
    );
  }

  Widget _delayReasonDropdown({required FormRFCInstallationDataState stateData}) {
    return stateData.isDelayReason == true
        ? CommonStyle.col(
            context: context,
            child: DropdownWidget<LmcReasonModel>(
              star: AppString.star,
              label: AppString.reasonDelay,
              hint: AppString.reasonDelay,
              dropdownValue: stateData.delayReasonValue?.name == null ? null : stateData.delayReasonValue,
              items: stateData.listOfDelayReason,
              onChanged: (val) {
                BlocProvider.of<FormRFCInstallationBloc>(context).add(SelectDelayReasonValueEvent(delayReasonValue: val));
              },
            ),
          )
        : Container();
  }

  Widget _meterNumberController({required FormRFCInstallationDataState stateData}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 8,
          child: AutoCompleteTextFieldWidget(
            star: AppString.star,
            hintText: AppString.meterNumber,
            label: AppString.meterNumber,
            suggestions: stateData.listOfMeterNumberSerial.length == 0 ? ["No Data Found"] : stateData.listOfMeterNumberSerial,
            keyboardType: TextInputType.text,
            controller: stateData.meterNumberSerialController,
            validator: (value) {
              if(stateData.meterNumberSerialController.text.isEmpty){
                if (value != null && value.isNotEmpty && !stateData.listOfMeterNumberSerial.contains(value)) {
                  return AppString.meterNoErrorMsg;
                }
              }
              return null;
            },
            onSelected: (val) {
              formKey.currentState?.validate();
              BlocProvider.of<FormRFCInstallationBloc>(context).add(SelectMeterNumberValueEvent(context: context, meterReadingValue: val));
            },
            onChanged: (val) {
              formKey.currentState?.validate();
              BlocProvider.of<FormRFCInstallationBloc>(context).add(SelectMeterNumberValueEvent(context: context, meterReadingValue: val));
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

  Widget _initialMeterReading({required FormRFCInstallationDataState stateData}) {
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

  Widget _meterReading1Controller({required FormRFCInstallationDataState stateData}) {
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
        BlocProvider.of<FormRFCInstallationBloc>(context).add(MeterInitReadingEvent());
      },
    );
  }

  Widget _meterReading2Controller({required FormRFCInstallationDataState stateData}) {
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
        BlocProvider.of<FormRFCInstallationBloc>(context).add(MeterInitReadingEvent());
      },
    );
  }

  Widget _meterReading3Controller({required FormRFCInstallationDataState stateData}) {
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
        BlocProvider.of<FormRFCInstallationBloc>(context).add(MeterInitReadingEvent());
      },
    );
  }

  Widget _installRegulatorCheck({required FormRFCInstallationDataState stateData}) {
    return CommonStyle.col(
      context: context,
      child: Card(
        child: Row(
          children: [
            Checkbox(
              value: stateData.isInstallRegulator,
              onChanged: (newVal) {
                BlocProvider.of<FormRFCInstallationBloc>(context).add(SelectInstallRegulatorEvent(context: context, installRegulator: newVal!));
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

  Widget _regulatorTypeDropdown({required FormRFCInstallationDataState stateData}) {
    return stateData.isInstallRegulator == true
        ? CommonStyle.col(
            context: context,
            child: DropdownWidget<LmcReasonModel>(
              star: AppString.star,
              label: AppString.regulatorType,
              hint: AppString.regulatorType,
              dropdownValue: stateData.regulatorTypeValue?.name == null ? null : stateData.regulatorTypeValue,
              items: stateData.listOfRegulatorType,
              onChanged: (val) {
                BlocProvider.of<FormRFCInstallationBloc>(context).add(SelectRegulatorTypeValueEvent(regulatorTypeValue: val!, context: context));
              },
            ),
          )
        : Container();
  }

  Widget _regulatorController({required FormRFCInstallationDataState stateData}) {
    return stateData.isInstallRegulator == true
        ? stateData.isRegulator == false
            ? stateData.regulatorTypeValue?.name != null
                ? CommonStyle.col(
                    context: context,
                    child: AutoCompleteTextFieldWidget(
                      star: AppString.star,
                      enabled: stateData.regulatorTypeValue?.name == null ? false : true,
                      label: stateData.regulatorTypeValue?.name != "PRV" ? AppString.meterRegulator : AppString.regulator,
                      hintText: stateData.regulatorTypeValue?.name != "PRV" ? AppString.meterRegulator : AppString.regulator,
                      suggestions: stateData.listOfRegulatorSerial.length == 0 ? ["No Data Found"] : stateData.listOfRegulatorSerial,
                      keyboardType: TextInputType.text,
                      controller: stateData.regulatorSerialController,
                      onSelected: (val) {
                        BlocProvider.of<FormRFCInstallationBloc>(context).add(SelectRegulatorsValueEvent(context: context, regulatorsValue: val));
                      },
                      validator: (value) {
                        if(stateData.regulatorSerialController.text.isEmpty){
                          if (value != null && value.isNotEmpty && !stateData.listOfRegulatorSerial.contains(value)) {
                            return AppString.regulatorNoErrorMsg;
                          }
                        }
                        return null;
                      },
                      onChanged: (val) async {
                        await formKey.currentState?.validate();
                        BlocProvider.of<FormRFCInstallationBloc>(context).add(SelectRegulatorsValueEvent(context: context, regulatorsValue: val));
                      },
                    ),
                  )
                : Container()
            : DottedLoaderWidget()
        : Container();
  }

  Widget _srNumberController({required FormRFCInstallationDataState stateData}) {
    return stateData.isInstallRegulator == true
        ? stateData.isRegulator == false
            ? stateData.regulatorTypeValue?.name == "SR"
                ? CommonStyle.col(
                    context: context,
                    child: AutoCompleteTextFieldWidget(
                      star: AppString.star,
                      label: AppString.srNumber,
                      hintText: AppString.srNumber,
                      suggestions: stateData.listOfSRSerial.length == 0 ? ["No Data Found"] : stateData.listOfSRSerial,
                      keyboardType: TextInputType.text,
                      controller: stateData.srNumberController,
                      onSelected: (val) {
                        formKey.currentState?.validate();
                        BlocProvider.of<FormRFCInstallationBloc>(context).add(SelectSREvent(context: context, sRegulators: val));
                      },
                      validator: (value) {
                        if(stateData.srNumberController.text.isEmpty){
                          if (value != null && value.isNotEmpty && !stateData.listOfSRSerial.contains(value)) {
                            return AppString.srNoErrorMsg;
                          }
                        }
                        return null;
                      },
                      onChanged: (val) async {
                        formKey.currentState?.validate();
                        BlocProvider.of<FormRFCInstallationBloc>(context).add(SelectSREvent(context: context, sRegulators: val));
                      },
                    ),
                  )
                : Container()
            : DottedLoaderWidget()
        : Container();
  }

  Widget _rfcDateControllerController({required FormRFCInstallationDataState stateData}) {
    return stateData.isInstallRegulator == true
        ? CommonStyle.col(
            context: context,
            child: TextFieldWidget(
              star: AppString.star,
              hintText: AppString.rfcDate,
              label: AppString.rfcDate,
              controller: stateData.rfcDateController,
              textInputAction: TextInputAction.done,
              enableInteractiveSelection: false,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.calendar_today, color: AppColor.primer,),
              ),
              keyboardType: TextInputType.datetime,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                BlocProvider.of<FormRFCInstallationBloc>(context).add(SelectRFCDateEvent(context: context));
              },
            ),
          )
        : Container();
  }

  Widget _ngConversionDateController({required FormRFCInstallationDataState stateData}) {
    return stateData.isInstallRegulator == true
        ? CommonStyle.col(
            context: context,
            child: TextFieldWidget(
              star: AppString.star,
              hintText: AppString.ngProposedDate,
              label: AppString.ngProposedDate,
              controller: stateData.ngConversionDateController,
              enableInteractiveSelection: false,
              suffixIcon: IconButtonWidget(
                iconData: Icons.calendar_today,
                onPressed: () {
                  BlocProvider.of<FormRFCInstallationBloc>(context).add(SelectNGConversionDateEvent(context: context));
                },
              ),
              onTap: () {
                BlocProvider.of<FormRFCInstallationBloc>(context).add(SelectNGConversionDateEvent(context: context));
              },
            ),
          )
        : Container();
  }

  Widget _locationOfHouse({required FormRFCInstallationDataState stateData}) {
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: stateData.isLatLongOfHouseLoader == false ?  TextFieldWidget(
            enabled: false,
            star: AppString.star,
            hintText: AppString.latOfHouse,
            label: AppString.latOfHouse,
            controller: stateData.latOfHouseController,
          ) : DottedLoaderWidget(),
        ),
        CommonStyle.widthSpace(context: context),
        Flexible(
          flex: 3,
          child:stateData.isLatLongOfHouseLoader == false ? TextFieldWidget(
            enabled: false,
            star: AppString.star,
            hintText: AppString.longOfHouse,
            label: AppString.longOfHouse,
            controller: stateData.longOfHouseController,
          ) : DottedLoaderWidget(),
        ),
      ],
    );
  }

  Widget _materialList({required FormRFCInstallationDataState stateData}) {
    return Column(
      children: [
        Column(
          children: stateData.materialList.mapIndexed((index, e) {
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
                              textInputAction: TextInputAction.done,
                            ),
                          )
                        : Flexible(
                            flex: 7,
                            child: TextFieldWidget(
                              hintText: AppString.material,
                              label: AppString.material,
                              initialValue: e.name,
                              enabled: false,
                              textInputAction: TextInputAction.done,
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
                              textInputAction: TextInputAction.done,
                              onChanged: (val) {
                                BlocProvider.of<FormRFCInstallationBloc>(context).add(SelectQTYLMCEvent(context: context, qtyValue: val));
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
                              textInputAction: TextInputAction.done,
                            ),
                          )
                  ],
                ),
                CommonStyle.vertical(context: context),
              ],
            );
          }).toList(),
        ),
        stateData.isExtraPipe == false ? _extraPipeWidget(stateData: stateData) : DottedLoaderWidget(),
        CommonStyle.vertical(context: context),
      ],
    );
  }

  Widget _extraPipeWidget({required FormRFCInstallationDataState stateData}) {
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

  Widget _checkListRFC({required FormRFCInstallationDataState stateData}) {
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
      itemCount: stateData.listOfAllRFC.length,
      itemBuilder: (context, index) {
        return Card(
          child: Row(
            children: [
              Checkbox(
                value: stateData.listOfAllRFC[index].isSelected,
                onChanged: (newVal) {
                  BlocProvider.of<FormRFCInstallationBloc>(context).add(SelectRFCCheckValueEvent(context: context, isSelected: newVal!, index: index));
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

  Widget _image({required FormRFCInstallationDataState stateData}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NetworkImageWidget(
          star: AppString.star,
          title: AppString.meter,
          baseUrl: stateData.baseUrl,
          networkPath: stateData.meterPhoto,
          onPressed: () {
            showModalBottomSheet(
                enableDrag: true,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return ImagePopWidget(
                    onTapCamera: () async {
                      Navigator.of(context).pop();
                      BlocProvider.of<FormRFCInstallationBloc>(context).add(CaptureCameraMeterEvent());
                    },
                    onTapGallery: () async {
                      Navigator.of(context).pop();
                      BlocProvider.of<FormRFCInstallationBloc>(context).add(CaptureGalleryMeterEvent());
                    },
                  );
                });
          },
        ),
        stateData.isInstallRegulator == true
            ? NetworkImageWidget(
                title: AppString.rfc,
          baseUrl: stateData.baseUrl,
          networkPath: stateData.rfcCardPhoto,
                onPressed: () {
                  showModalBottomSheet(
                      enableDrag: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return ImagePopWidget(
                          onTapCamera: () async {
                            Navigator.of(context).pop();
                            BlocProvider.of<FormRFCInstallationBloc>(context).add(CaptureCameraRFCCardEvent());
                          },
                          onTapGallery: () async {
                            Navigator.of(context).pop();
                            BlocProvider.of<FormRFCInstallationBloc>(context).add(CaptureGalleryRFCCardEvent());
                          },
                        );
                      });
                },
              )
            : Container(),
        stateData.isInstallRegulator == true
            ? NetworkImageWidget(
                title: AppString.pneumatic,
          baseUrl: stateData.baseUrl,
          networkPath: stateData.pneumaticTestReportPhoto,
                onPressed: () {
                  showModalBottomSheet(
                      enableDrag: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return ImagePopWidget(
                          onTapCamera: () async {
                            Navigator.of(context).pop();
                            BlocProvider.of<FormRFCInstallationBloc>(context).add(CaptureCameraPneumaticEvent());
                          },
                          onTapGallery: () async {
                            Navigator.of(context).pop();
                            BlocProvider.of<FormRFCInstallationBloc>(context).add(CaptureGalleryPneumaticEvent());
                          },
                        );
                      });
                },
              )
            : Container(),
        NetworkImageWidget(
          star: AppString.star,
          title: AppString.housePhoto,
          baseUrl: stateData.baseUrl,
          networkPath: stateData.housePhoto,
          onPressed: () {
            showModalBottomSheet(
                enableDrag: true,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext mContext) {
                  return CameraPopWidget(
                    onTapCamera: () async {
                      Navigator.of(mContext).pop();
                      BlocProvider.of<FormRFCInstallationBloc>(context).add(CaptureCameraHouseEvent());
                    },
                  );
                });
          },
        ),
      ],
    );
  }

  Widget _button({required FormRFCInstallationDataState dataState}) {
    return dataState.isBtnLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            onPressed: () {
              BlocProvider.of<FormRFCInstallationBloc>(context).add(SubmitFormRFCInstallation(context: context));
            })
        : DottedLoaderWidget();
  }
}
