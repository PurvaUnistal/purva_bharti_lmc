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
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/Utils/common_widgets/row_widget.dart';
import 'package:lmc/Utils/common_widgets/text_form_widget.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:lmc/features/Installation/FormInstallation/presentation/Widgets/image_widget.dart';
import 'package:lmc/features/Installation/FormInstallation/presentation/Widgets/meter_no_widget.dart';
import 'package:lmc/features/Installation/LMCInstallation/presentation/Widgets/cameraPopWidget.dart';
import 'package:lmc/features/NGC/NGCForm/domain/bloc/ngc_form_bloc.dart';
import 'package:lmc/features/NGC/NGCForm/domain/bloc/ngc_form_event.dart';
import 'package:lmc/features/NGC/NGCForm/domain/bloc/ngc_form_state.dart';
import 'package:lmc/features/NGC/NGCForm/presentation/Widget/network_file_image.dart';

class NGCFormView extends StatefulWidget {
  const NGCFormView({Key? key}) : super(key: key);

  @override
  State<NGCFormView> createState() => _NGCFormViewState();
}

class _NGCFormViewState extends State<NGCFormView> {
  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<NGCFormBloc>(context)
        .add(NGCFormLoadEvent(context: context));
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  final meterFieldKey = GlobalKey<FormFieldState>();
  final regulatorFieldKey = GlobalKey<FormFieldState>();
  final mRegulatorFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child:  Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBarWidget(
        title: AppString.ngConH,
        boolLeading: true,
    ),
    body: SafeArea(
      child: BackgroundWidget(
          child: BlocBuilder<NGCFormBloc, NGCFormState>(
            builder: (context, state) {
              if (state is NGCFormPageLoadState) {
                return Center(
                  child: SpinLoader(),
                );
              } else if (state is NGCFormDataState) {
                return Form(
                  child: _buildLayout(
                    dataState: state,
                  ),
                );
              } else {
                return const Center(
                  child: Text("No data"),
                );
              }
            },
          ),
        ),
    ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            builder: (BuildContext mContext) => MessageBoxTwoButtonPopWidget(
                message: "Do you want to NGC  Report??",
                okButtonText: "Exit",
                onPressed: () => Navigator.of(context).pop(true)))) ??
        false;
  }

  _buildLayout({required NGCFormDataState dataState}) {
    return ListView(
        padding: EdgeInsets.all(8),
        children: [
          Text(
            AppString.ngConversionForm,
            style: Styles.text,
            textAlign: TextAlign.center,
          ),
          CommonStyle.vertical(context: context),
          RowWidget(
            widget1: _bpNumberWidget(dataState: dataState),
            widget2: _dateInstallationController(dataState: dataState),
          ),
          CommonStyle.vertical(context: context),
          RowWidget(
            widget1: _proposedNgcDateController(dataState: dataState),
            widget2: _rfcDateController(dataState: dataState),
          ),
          CommonStyle.vertical(context: context),
          RowWidget(
            widget1: _extraPipeController(dataState: dataState),
            widget2: _extraPriceController(dataState: dataState),
          ),
          CommonStyle.vertical(context: context),
          RowWidget(
              widget1: _mobileNumberController(dataState: dataState),
              widget2: _altContactNoWidget(dataState: dataState)),
          CommonStyle.vertical(context: context),
          /* RowWidget(widget1: _contractorWidget(dataState: dataState), widget2: _emailWidget(dataState: dataState),),
          CommonStyle.vertical(context: context),*/
          RowWidget(
              widget1: _burnerNoWidget(dataState: dataState),
              widget2: _noOfFamilyMembersController(dataState: dataState)),
          CommonStyle.vertical(context: context),
          _emailWidget(dataState: dataState),
          CommonStyle.vertical(context: context),
          _ngConversionDateController(dataState: dataState),
          CommonStyle.vertical(context: context),
          _delayReasonDropdown(dataState: dataState),
          _delayReasonControllerWidget(dataState: dataState),
          _meterReplaceCheck(dataState: dataState),
          CommonStyle.vertical(context: context),
          Row(
            children: [
              Flexible(
                  flex: 8,
                  child: _meterReplaceController(dataState: dataState)),
              CommonStyle.widthSpace(context: context),
              Flexible(
                  flex: 4,
                  child:
                      _meterConnectionControllerWidget(dataState: dataState)),
            ],
          ),
          _changeMeterReasonDropdown(dataState: dataState),
          _remarkMeterChangeController(dataState: dataState),
          CommonStyle.vertical(context: context),
          _initialMeterReading(dataState: dataState),
          CommonStyle.vertical(context: context),
          _regulatorReplaceCheck(dataState: dataState),
          CommonStyle.vertical(context: context),
          _regulatorTypeDropdown(dataState: dataState),
          _regulatorController(dataState: dataState),
          _mrNumberController(dataState: dataState),
          _changeRegulatorReasonDropdown(dataState: dataState),
          _remarkRegulatorChangeController(dataState: dataState),
          _photoWidget(dataState: dataState),
          _locationOfSR(dataState: dataState),
          _locationOfMR(dataState: dataState),
          CommonStyle.vertical(context: context),
          Row(
            children: [
              Flexible(
                  child: RowWidget(
                      widget1: _meterPhoto(dataState: dataState),
                      widget2: _ngcReportPhoto(dataState: dataState))),
              dataState.regulatorCheck == "1"
                  ? Flexible(
                      child: RowWidget(
                          widget1: _rfcPhoto(dataState: dataState),
                          widget2: _pneumaticPhoto(dataState: dataState)))
                  : Container(),
            ],
          ),
          CommonStyle.vertical(context: context),
          CommonStyle.vertical(context: context),
          _submitBtnWidget(dataState: dataState),
          CommonStyle.vertical(context: context),
          CommonStyle.vertical(context: context),
        ],
    );
  }

  Widget _dateInstallationController({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      label: AppString.dateInstallation,
      hintText: AppString.dateInstallation,
      enabled: false,
      controller: dataState.dateInstallationController,
    );
  }

  Widget _proposedNgcDateController({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      label: AppString.ngProposedDate,
      hintText: AppString.ngProposedDate,
      enabled: false,
      controller: dataState.proposedNgcDateController,
    );
  }

  Widget _rfcDateController({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      label: AppString.rfcDate,
      hintText: AppString.rfcDate,
      enabled: false,
      controller: dataState.rfcDateController,
    );
  }

  Widget _extraPipeController({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      label: AppString.extraPipe,
      hintText: AppString.extraPipe,
      enabled: false,
      controller: dataState.extraPipeController,
    );
  }

  Widget _extraPriceController({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      label: AppString.extraPrice,
      hintText: AppString.extraPrice,
      enabled: false,
      controller: dataState.extraPriceController,
    );
  }

  Widget _burnerNoWidget({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      star: AppString.star,
      label: AppString.burnersNo,
      hintText: AppString.burnersNo,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: dataState.noOfBurnersController,
    );
  }

  Widget _noOfFamilyMembersController({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      enabled: true,
      label: AppString.noOfFamilyMembers,
      hintText: AppString.noOfFamilyMembers,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: dataState.noOfFamilyMembersController,
    );
  }



  Widget _mobileNumberController({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      label: AppString.mobileNumber,
      hintText: AppString.mobileNumber,
      enabled: false,
      controller: dataState.mobileNumberController,
    );
  }

  Widget _altContactNoWidget({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      maxLength: 10,
      hintText: AppString.altMobileNo,
      label: AppString.altMobileNo,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      controller: dataState.altMobileNumberController,
    );
  }

  Widget _emailWidget({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      label: AppString.email,
      hintText: AppString.email,
      enabled: false,
      controller: dataState.emailIdController,
    );
  }

  Widget _bpNumberWidget({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      star: AppString.star,
      label: AppString.bpNumber,
      hintText: AppString.bpNumber,
      enabled: false,
      controller: dataState.bpNumberController,
    );
  }

  Widget _meterConnectionDropdown({required NGCFormDataState dataState}) {
    return DropdownWidget<GetConstantModel>(
      label: AppString.meterConnection,
      hint: AppString.meterConnection,
      dropdownValue: dataState.typeOfNrValue.value!.isEmpty
          ? null
          : dataState.typeOfNrValue,
      items: dataState.listOfTypeOfNr,
      onChanged: (val) {
        BlocProvider.of<NGCFormBloc>(context)
            .add(SelectTypeNRValueEvent(typeOfNRValue: val!));
      },
    );
  }

  Widget _ngConversionDateController({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      label: AppString.ngConversionDate,
      hintText: AppString.ngConversionDate,
      enabled: true,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: dataState.ngConversionDateController,
      suffixIcon: IconButtonWidget(
        iconData: Icons.calendar_today,
        onPressed: () {
          BlocProvider.of<NGCFormBloc>(context)
              .add(SelectNGConversionDateEvent(context: context));
        },
      ),
      onTap: () {
        BlocProvider.of<NGCFormBloc>(context)
            .add(SelectNGConversionDateEvent(context: context));
      },
    );
  }

  Widget _delayReasonDropdown({required NGCFormDataState dataState}) {
    return dataState.isDelayReason == true
        ? CommonStyle.col(
            context: context,
            child: DropdownWidget<LmcReasonModel>(
              star: AppString.star,
              label: AppString.delayStatus,
              hint: AppString.delayStatus,
              dropdownValue: dataState.delayReasonValue.name == null
                  ? null
                  : dataState.delayReasonValue,
              items: dataState.listOfDelayReason,
              onChanged: (val) {
                BlocProvider.of<NGCFormBloc>(context)
                    .add(SelectDelayReasonValueEvent(delayReasonValue: val!));
              },
            ),
          )
        : Container();
  }

  Widget _delayReasonControllerWidget({required NGCFormDataState dataState}) {
    return dataState.isDelayReason == true
        ? CommonStyle.col(
            context: context,
            child: TextFieldWidget(
              label: AppString.delayReason,
              hintText: AppString.delayReason,
              textInputAction: TextInputAction.done,
              controller: dataState.delayReasonController,
              maxLine: 2,
            ),
          )
        : Container();
  }

  Widget _meterPhoto({required NGCFormDataState dataState}) {
    return NetworkImageWidget(
      star: AppString.star,
      title: AppString.meterPhoto,
      baseUrl: dataState.baseUrl,
      networkPath: dataState.meterPhoto,
      onPressed: () {
        showModalBottomSheet(
            enableDrag: true,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return ImagePopWidget(
                onTapCamera: () async {
                  Navigator.of(context).pop();
                  BlocProvider.of<NGCFormBloc>(context)
                      .add(CaptureCameraMeterEvent(context: context));
                },
                onTapGallery: () async {
                  Navigator.of(context).pop();
                  BlocProvider.of<NGCFormBloc>(context)
                      .add(CaptureGalleryMeterEvent(context: context));
                },
              );
            });
      },
    );
  }

  Widget _rfcPhoto({required NGCFormDataState dataState}) {
    return NetworkImageWidget(
      title: AppString.rfc,
      baseUrl: dataState.baseUrl,
      networkPath: dataState.rfcPhoto,
      onPressed: () {
        showModalBottomSheet(
            enableDrag: true,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return ImagePopWidget(
                onTapCamera: () async {
                  Navigator.of(context).pop();
                  BlocProvider.of<NGCFormBloc>(context)
                      .add(CaptureCameraRfcEvent(context: context));
                },
                onTapGallery: () async {
                  Navigator.of(context).pop();
                  BlocProvider.of<NGCFormBloc>(context)
                      .add(CaptureGalleryRfcEvent(context: context));
                },
              );
            });
      },
    );
  }

  Widget _pneumaticPhoto({required NGCFormDataState dataState}) {
    return NetworkImageWidget(
      title: AppString.pneumatic,
      baseUrl: dataState.baseUrl,
      networkPath: dataState.pneumaticPhoto,
      onPressed: () {
        showModalBottomSheet(
            enableDrag: true,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return ImagePopWidget(
                onTapCamera: () async {
                  Navigator.of(context).pop();
                  BlocProvider.of<NGCFormBloc>(context)
                      .add(CaptureCameraPneumaticEvent(context: context));
                },
                onTapGallery: () async {
                  Navigator.of(context).pop();
                  BlocProvider.of<NGCFormBloc>(context)
                      .add(CaptureGalleryPneumaticEvent(context: context));
                },
              );
            });
      },
    );
  }

  Widget _meterConnectionControllerWidget(
      {required NGCFormDataState dataState}) {
    return TextFieldWidget(
      star: AppString.star,
      label: AppString.meterConnection,
      hintText: AppString.meterConnection,
      enabled: false,
      controller: dataState.meterConnectionMeterController,
    );
  }

  Widget _meterReplaceCheck({required NGCFormDataState dataState}) {
    return Card(
      child: Row(
        children: [
          Checkbox(
            value: dataState.isMeterReplace,
            onChanged: (newVal) {
              BlocProvider.of<NGCFormBloc>(context).add(SelectMeterReplaceEvent(
                  context: context, meterReplace: newVal!));
            },
          ),
          Text(
            AppString.meterReplace,
            style: Styles.labels,
          ),
        ],
      ),
    );
  }

  Widget _meterReplaceController({required NGCFormDataState dataState}) {
    return dataState.isMeterReplace == true
        ? AutoCompleteTextFieldWidget(
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
              BlocProvider.of<NGCFormBloc>(context).add(
                  SelectMeterNumberValueEvent(
                      context: context, meterReadingValue: val));
            },
            onChanged: (val) async {
              await meterFieldKey.currentState?.validate();
              // BlocProvider.of<NGCFormBloc>(context).add(
              //     SelectMeterNumberValueEvent(
              //         context: context, meterReadingValue: val));
            },
          )
        : TextFieldWidget(
            star: AppString.star,
            label: AppString.meterNumber,
            hintText: AppString.meterNumber,
            controller: dataState.meterSerialController,
          );
  }

  Widget _changeMeterReasonDropdown({required NGCFormDataState dataState}) {
    return dataState.isMeterReplace == true
        ? CommonStyle.col(
            context: context,
            child: DropdownWidget<LmcReasonModel>(
              star: AppString.star,
              label: AppString.meterType,
              hint: AppString.meterType,
              dropdownValue: dataState.meterTypeValue.name == null
                  ? null
                  : dataState.meterTypeValue,
              items: dataState.listOfMeterType,
              onChanged: (val) {
                BlocProvider.of<NGCFormBloc>(context)
                    .add(SelectMeterTypeValueEvent(
                  meterTypeValue: val!,
                ));
              },
            ),
          )
        : Container();
  }

  Widget _remarkMeterChangeController({required NGCFormDataState dataState}) {
    return dataState.isMeterReplace == true
        ? CommonStyle.col(
            context: context,
            child: TextFieldWidget(
              label: AppString.remarks,
              hintText: AppString.remarks,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              controller: dataState.reasonMeterChangeController,
            ),
          )
        : Container();
  }

  Widget _initialMeterReading({required NGCFormDataState dataState}) {
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

  Widget _meterReading1Controller({required NGCFormDataState dataState}) {
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
        BlocProvider.of<NGCFormBloc>(context).add(MeterInitReadingEvent());
      },
    );
  }

  Widget _meterReading2Controller({required NGCFormDataState dataState}) {
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
        BlocProvider.of<NGCFormBloc>(context).add(MeterInitReadingEvent());
      },
    );
  }

  Widget _meterReading3Controller({required NGCFormDataState dataState}) {
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
        BlocProvider.of<NGCFormBloc>(context).add(MeterInitReadingEvent());
      },
    );
  }

  Widget _regulatorReplaceCheck({required NGCFormDataState dataState}) {
    return Card(
      child: Row(
        children: [
          Checkbox(
            value: dataState.isRegularReplace,
            onChanged: (newVal) {
              BlocProvider.of<NGCFormBloc>(context).add(
                  SelectRegularReplaceEvent(
                      context: context, regularReplace: newVal!));
            },
          ),
          Text(
            AppString.regulatorReplace,
            style: Styles.labels,
          ),
        ],
      ),
    );
  }

  Widget _regulatorTypeDropdown({required NGCFormDataState dataState}) {
    if (!dataState.isRegularReplace) {
      // Not regular replace → show disabled TextField
      return TextFieldWidget(
        star: AppString.star,
        label: AppString.regulatorType,
        hintText: AppString.regulatorType,
        enabled: false,
        controller: dataState.regulatorTypeController,
      );
    }

    // Regular replace → show dropdown
    return DropdownWidget<LmcReasonModel>(
      star: AppString.star,
      label: AppString.regulatorType,
      hint: AppString.regulatorType,
      dropdownValue: dataState.regulatorTypeValue.name == null
          ? null
          : dataState.regulatorTypeValue,
      items: dataState.listOfRegulatorType,
      onChanged: (val) {
        if (val != null) {
          BlocProvider.of<NGCFormBloc>(context).add(
            SelectRegulatorTypeValueEvent(
              regulatorTypeValue: val,
              context: context,
            ),
          );
        }
      },
    );
  }


  Widget _regulatorController({required NGCFormDataState dataState}) {
    String label = (dataState.regulatorTypeValue.name != "PRV")
        ? AppString.srNumber
        : AppString.regulator;

    if (!dataState.isRegularReplace) {
      // Not regular replace → show disabled TextField
      return CommonStyle.col(
        context: context,
        child: TextFieldWidget(
          star: AppString.star,
          label: label,
          hintText: label,
          enabled: false,
          controller: dataState.regulatorSerialController,
        ),
      );
    }

    if (dataState.isRegulator) {
      return const DottedLoaderWidget();
    }

    if (dataState.regulatorTypeValue.name == null) {
      return const SizedBox.shrink(); // nothing to render
    }

    // Regular Replace && !isRegulator && regulatorTypeValue.name != null
    return CommonStyle.col(
      context: context,
      child: AutoCompleteTextFieldWidget(
        fieldKey: regulatorFieldKey,
        star: AppString.star,
        label: label,
        hintText: label,
        suggestions: dataState.listOfRegulatorSerial.isEmpty
            ? ["No Data Found"]
            : dataState.listOfRegulatorSerial,
        keyboardType: TextInputType.text,
        controller: dataState.regulatorSerialSearchController,
        onSelected: (val) {
          regulatorFieldKey.currentState?.validate();
          BlocProvider.of<NGCFormBloc>(context).add(
            SelectRegulatorsValueEvent(context: context, regulatorsValue: val),
          );
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
          // BlocProvider.of<NGCFormBloc>(context).add(
          //   SelectRegulatorsValueEvent(context: context, regulatorsValue: val),
          // );
        },
      ),
    );
  }



  Widget _mrNumberController({required NGCFormDataState dataState,}) {
    final name = dataState.regulatorTypeValue.name;
    final text = dataState.regulatorTypeController.text;
    final isSR = name == "SR" || text == "SR";
    final isPRV = name == "PRV" && text == "SR";

    if (dataState.isRegulator) {
      return const DottedLoaderWidget();
    }
    if (!isSR) {
      return const SizedBox.shrink();
    }
    if (isPRV) {
      return const SizedBox();
    }
    // Now you know: isSR is true, and not PRV
    if (!dataState.isRegularReplace) {
      // isRegularReplace is false
      return CommonStyle.col(
        context: context,
        child: TextFieldWidget(
          star: AppString.star,
          label: AppString.meterRegulator,
          hintText: AppString.meterRegulator,
          enabled: false,
          controller: dataState.mrSerialNumberController,
        ),
      );
    } else {
      // isRegularReplace is true
      return CommonStyle.col(
        context: context,
        child: AutoCompleteTextFieldWidget(
          fieldKey: mRegulatorFieldKey,
          star: AppString.star,
          label: AppString.meterRegulator,
          hintText: AppString.meterRegulator,
          suggestions: dataState.listOfMRSerial.isEmpty
              ? ["No Data Found"]
              : dataState.listOfMRSerial,
          keyboardType: TextInputType.text,
          controller: dataState.mrNumberSearchController,
          onSelected: (val) {
            mRegulatorFieldKey.currentState?.validate();
            BlocProvider.of<NGCFormBloc>(context).add(
              SelectMRegulatorsEvent(context: context, mRegulators: val),
            );
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
            // BlocProvider.of<NGCFormBloc>(context).add(
            //   SelectMRegulatorsEvent(context: context, mRegulators: val),
            // );
          },
        ),
      );
    }
  }




  Widget _changeRegulatorReasonDropdown({required NGCFormDataState dataState}) {
    return dataState.isRegularReplace == true
        ? CommonStyle.col(
            context: context,
            child: DropdownWidget<LmcReasonModel>(
              star: AppString.star,
              label: AppString.regularType,
              hint: AppString.regularType,
              dropdownValue: dataState.regulatorTypeReasonValue.name == null
                  ? null
                  : dataState.regulatorTypeReasonValue,
              items: dataState.listOfRegulatorTypeReason,
              onChanged: (val) {
                BlocProvider.of<NGCFormBloc>(context)
                    .add(SelectRegulatorTypeReasonValueEvent(
                  regulatorTypeReasonValue: val!,
                ));
              },
            ),
          )
        : Container();
  }

  Widget _remarkRegulatorChangeController(
      {required NGCFormDataState dataState}) {
    return dataState.isRegularReplace == true
        ? CommonStyle.col(
            context: context,
            child: TextFieldWidget(
              label: AppString.remarks,
              hintText: AppString.remarks,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              controller: dataState.reasonRegulatorChangeController,
            ),
          )
        : Container();
  }

  Widget _locationOfMR({required NGCFormDataState dataState}) {
    final name = dataState.regulatorTypeValue.name;
    final text = dataState.regulatorTypeController.text;
    final isSR = name == "SR" || text == "SR";
    final isPRV = name == "PRV" && text == "SR";
    if (isPRV) {
      return const SizedBox();
    } else if (isSR){
    return CommonStyle.col(
        context: context,
        child: dataState.isMRLatLong == true ?  DottedLoaderWidget() : RowWidget(
          widget1: TextFieldWidget(
            enabled: false,
            star: AppString.star,
            hintText: AppString.latOfMR,
            label: AppString.latOfMR,
            controller: dataState.latOfMRController,
          ),
          widget2: TextFieldWidget(
            enabled: false,
            star: AppString.star,
            hintText: AppString.longOfMR,
            label: AppString.longOfMR,
            controller: dataState.longOfMRController,
          ),
        ),
      );
    }else {
      return const SizedBox();
    }
  }


  Widget _locationOfSR({required NGCFormDataState dataState}) {
    final name = dataState.regulatorTypeValue.name;
    final text = dataState.regulatorTypeController.text;
    final isSR = name == "SR" || text == "SR";
    final isPRV = name == "PRV" && text == "SR";
    if (isPRV) {
      return const SizedBox();
    } else if (isSR){
      return CommonStyle.col(
        context: context,
        child: dataState.isSRLatLong == true ?  DottedLoaderWidget() :RowWidget(
          widget1: TextFieldWidget(
            enabled: false,
            star: AppString.star,
            hintText: AppString.latOfSR,
            label: AppString.latOfSR,
            controller: dataState.latOfSRController,
          ),
          widget2: TextFieldWidget(
            enabled: false,
            star: AppString.star,
            hintText: AppString.longOfSR,
            label: AppString.longOfSR,
            controller: dataState.longOfSRController,
          ),
        ) ,
      );
    }else {
      return const SizedBox();
    }
  }


  Widget _photoWidget({required NGCFormDataState dataState}) {
    final name = dataState.regulatorTypeValue.name;
    final text = dataState.regulatorTypeController.text;
    final isSR = name == "SR" || text == "SR";
    final isPRV = name == "PRV" && text == "SR";
    if (isPRV) {
      return const SizedBox();
    } else if (isSR){
      return  CommonStyle.col(
        context: context,
        child: RowWidget(
          widget1: ImageWidget(
            star: AppString.star,
            title: AppString.mrPhoto,
            imgFile: dataState.mrPhoto,
            onPressed: () {
              showModalBottomSheet(
                enableDrag: true,
                isScrollControlled: true,
                context: context,
                builder: (context) => CameraPopWidget(
                  onTapCamera: () async {
                    Navigator.of(context).pop();
                    context.read<NGCFormBloc>().add(
                      CaptureCameraMREvent(context: context),
                    );
                  },
                ),
              );
            },
          ),
          widget2: ImageWidget(
            star: AppString.star,
            title: AppString.srPhoto,
            imgFile: dataState.srPhoto,
            onPressed: () {
              showModalBottomSheet(
                enableDrag: true,
                isScrollControlled: true,
                context: context,
                builder: (context) => CameraPopWidget(
                  onTapCamera: () async {
                    Navigator.of(context).pop();
                    context.read<NGCFormBloc>().add(
                      CaptureCameraSREvent(context: context),
                    );
                  },
                ),
              );
            },
          ),
        ),
      );
    }else {
      return const SizedBox();
    }
    }




    Widget _ngcReportPhoto({required NGCFormDataState dataState}) {
    return ImageWidget(
      title: AppString.ngcReportFile,
      imgFile: dataState.ngcReportPhoto,
      onPressed: () {
        showModalBottomSheet(
            enableDrag: true,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return ImagePopWidget(
                onTapCamera: () async {
                  Navigator.of(context).pop();
                  BlocProvider.of<NGCFormBloc>(context)
                      .add(CaptureCameraNGCReportEvent(context: context));
                },
                onTapGallery: () async {
                  Navigator.of(context).pop();
                  BlocProvider.of<NGCFormBloc>(context)
                      .add(CaptureGalleryNGCReportEvent(context: context));
                },
              );
            });
      },
    );
  }

  Widget _submitBtnWidget({required NGCFormDataState dataState}) {
    return dataState.isBtnLoader == false
        ? Center(
            child: ButtonWidget(
                text: AppString.submit,
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  BlocProvider.of<NGCFormBloc>(context).add(NGCSubmitEvent(
                    context: context,
                  ));
                }),
          )
        : DottedLoaderWidget();
  }
}
