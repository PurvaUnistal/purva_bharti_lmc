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
import 'package:lmc/Utils/common_widgets/local_mg_widget.dart';
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
    BlocProvider.of<NGCFormBloc>(context).add(NGCFormLoadEvent(context: context));
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColor.green50,
        body: BlocBuilder<NGCFormBloc, NGCFormState>(
          builder: (context, state) {
            if (state is NGCFormPageLoadState) {
              return Center(
                child: SpinLoader(),
              );
            } else if (state is NGCFormDataState) {
              return Form(
                key: formKey,
                child: BackgroundWidget(
                  child: _buildLayout(dataState: state,),
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
    );
  }
  Future<bool> _onWillPop() async {
    return (await showDialog(
        context: context,
        builder: (BuildContext mContext) => MessageBoxTwoButtonPopWidget(
            message: "Do you want to NGC  Report??",
            okButtonText: "Exit",
            onPressed: () =>  Navigator.of(context).pop(true)
        ))
    ) ?? false;
  }
  _buildLayout({required NGCFormDataState dataState}) {
    return Scaffold(
      appBar: AppBarWidget(
        title: AppString.ngConH,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(flex: 1,child: _bpNumberWidget(dataState : dataState)),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Flexible(flex: 1,child: _dateInstallationController(dataState : dataState)),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Flexible(flex: 1,child: _proposedNgcDateController(dataState : dataState)),
            ],
          ),
          _sizedBox(),
          _meterConnectionDropdown(dataState: dataState),
          _sizedBox(),
          _ngConversionDateController(dataState: dataState),
          _sizedBox(),
          _delayReasonDropdown(dataState : dataState),
          _delayReasonControllerWidget(dataState : dataState),
          _meterReplaceCheck(dataState : dataState),
          _sizedBox(),
          _meterReplaceController(dataState : dataState),
          _sizedBox(),
          _meterTypeDropdown(dataState : dataState),
          _reasonMeterChangeController(dataState : dataState),
          _meterInitialReadingController(dataState : dataState),
          _sizedBox(),
          _regulatorTypeDropdown(dataState : dataState),
          _sizedBox(),
          _srNumberController(dataState : dataState),
          _regulatorController(dataState : dataState),
          _mrPhoto(dataState : dataState),
          _locationOfSR(dataState : dataState),
          _locationOfMR(dataState : dataState),
          _contractorWidget(dataState : dataState),
          _sizedBox(),
          RowWidget(
              widget1: _burnerNoWidget(dataState : dataState),
              widget2: _noOfFamilyMembersController(dataState : dataState)
          ),
          _sizedBox(),
          _contactNoWidget(dataState : dataState),
          _sizedBox(),
          _altContactNoWidget(dataState : dataState),
          _sizedBox(),
          _emailWidget(dataState : dataState),
          _sizedBox(),
          RowWidget(
              widget1: _meterPhoto(dataState : dataState),
              widget2: _ngcReportPhoto(dataState: dataState)),
          _sizedBox(),
          _sizedBox(),
          _submitBtnWidget(dataState: dataState),
          _sizedBox(),
          _sizedBox(),
        ],
      ),
    );
  }


  Widget _dateInstallationController({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      label: AppString.dateInstallation,
      hintText: AppString.dateInstallation,
      enabled: false,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: dataState.dateInstallationController,
    );
  }
  Widget _proposedNgcDateController({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      label: AppString.proposedNgcDate,
      hintText: AppString.proposedNgcDate,
      enabled: false,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: dataState.proposedNgcDateController,
    );
  }

  Widget _bpNumberWidget({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      star: AppString.star,
      label: AppString.bpNumber,
      hintText: AppString.bpNumber,
      enabled: false,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: dataState.bpNumberController,
    );
  }

  Widget _meterConnectionDropdown({required NGCFormDataState dataState}) {
    return DropdownWidget<GetConstantModel>(
      label: AppString.meterConnection,
      hint: AppString.meterConnection,
      dropdownValue: dataState.typeOfNrValue!.value!.isEmpty ? null : dataState.typeOfNrValue,
      items: dataState.listOfTypeOfNr,
      onChanged: (val) {
        BlocProvider.of<NGCFormBloc>(context).add(SelectTypeNRValueEvent(typeOfNRValue: val!));
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
          BlocProvider.of<NGCFormBloc>(context).add(SelectNGConversionDateEvent(context: context));
        },
      ),
      onTap: () {
        BlocProvider.of<NGCFormBloc>(context).add(SelectNGConversionDateEvent(context: context));
      },
    );
  }

  Widget _delayReasonDropdown({required NGCFormDataState dataState}) {
    return dataState.isDelayReason == true ? _col(
      child: DropdownWidget<LmcReasonModel>(
        star: AppString.star ,
        label: AppString.delayStatus,
        hint: AppString.delayStatus,
        dropdownValue: dataState.delayReasonValue?.name == null ? null : dataState.delayReasonValue,
        items: dataState.listOfDelayReason,
        onChanged: (val) {
          BlocProvider.of<NGCFormBloc>(context).add(SelectDelayReasonValueEvent(delayReasonValue: val!));
        },
      ),
    ): Container();
  }
  Widget _delayReasonControllerWidget({required NGCFormDataState dataState}) {
    return dataState.isDelayReason == true ? _col(
      child: TextFieldWidget(
        label: AppString.delayReason,
        hintText: AppString.delayReason,
        textInputAction: TextInputAction.done,
        controller: dataState.delayReasonController,
        maxLine: 2,
      ),
    ): Container();
  }

  Widget _meterReplaceCheck({required NGCFormDataState dataState}) {
    return  Card(
      child: Row(
        children: [
          Checkbox(
            value:dataState.isMeterReplace,
            onChanged: (newVal){
              BlocProvider.of<NGCFormBloc>(context).add(SelectMeterReplaceEvent(
                  context: context,
                  meterReplace: newVal!
              ));
            },
          ),
          Text(AppString.meterReplace, style: Styles.labels,),
        ],
      ),
    );
  }

  Widget _meterPhoto({required NGCFormDataState dataState}){
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
                  BlocProvider.of<NGCFormBloc>(context).add(CaptureCameraMeterEvent());
                },
                onTapGallery: () async {
                  Navigator.of(context).pop();
                  BlocProvider.of<NGCFormBloc>(context).add(CaptureGalleryMeterEvent());
                },
              );
            });
      },
    );
  }

  Widget _meterReplaceController({required NGCFormDataState dataState}) {
    return dataState.isMeterReplace == true ?
    AutoCompleteTextFieldWidget(
      star: AppString.star,
      hintText: AppString.meterNumber,
      label: AppString.meterNumber,
      suggestions: dataState.listOfMeterNumberSerial.length == 0 ? ["No Data Found"] : dataState.listOfMeterNumberSerial,
      keyboardType: TextInputType.text,
      controller: dataState.meterNumberSerialController,
      validator: (value) {
        if(value != null && value.isNotEmpty && !dataState.listOfMeterNumberSerial.contains(value)) {
          return AppString.meterNoErrorMsg;
        }
        return null;
      },
      onSelected: (val) {
        formKey.currentState?.validate();
        BlocProvider.of<NGCFormBloc>(context).add(SelectMeterNumberValueEvent(context: context, meterReadingValue: val));
      },
      onChanged: (val) async {
        await formKey.currentState?.validate();
        BlocProvider.of<NGCFormBloc>(context).add(SelectMeterNumberValueEvent(context: context, meterReadingValue: val));
      },
    )
        : TextFieldWidget(
      star: AppString.star,
      label: AppString.meterNumber,
      hintText: AppString.meterNumber,
      enabled: false,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: dataState.meterSerialController,
    );
  }

  Widget _meterTypeDropdown({required NGCFormDataState dataState}) {
    return  dataState.isMeterReplace == true ? _col(
      child: DropdownWidget<LmcReasonModel>(
        star: AppString.star,
        label: AppString.meterType,
        hint: AppString.meterType,
        dropdownValue: dataState.meterTypeValue?.name == null ? null : dataState.meterTypeValue,
        items: dataState.listOfMeterType,
        onChanged: (val) {
          BlocProvider.of<NGCFormBloc>(context).add(SelectMeterTypeValueEvent(meterTypeValue: val!,));
        },
      ),
    ) : Container();
  }

  Widget _reasonMeterChangeController({required NGCFormDataState dataState}) {
    return  dataState.isMeterReplace == true ? _col(
      child: TextFieldWidget(
        label: AppString.reasonMeterChange,
        hintText: AppString.reasonMeterChange,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        controller: dataState.reasonMeterChangeController,
      ),
    ) : Container();
  }

  Widget _meterInitialReadingController({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      star: AppString.star,
      label: AppString.meterInitialReading,
      hintText: AppString.meterInitialReading,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: dataState.meterInitialReading,
    );
  }

  Widget _regulatorTypeDropdown({required NGCFormDataState dataState}) {
    return DropdownWidget<LmcReasonModel>(
      star: AppString.star,
      label: AppString.regulatorType,
      hint: AppString.regulatorType,
      dropdownValue: dataState.regulatorTypeValue!.name!.isEmpty  ? null : dataState.regulatorTypeValue,
      items: dataState.listOfRegulatorType,
      onChanged: (val) {
        BlocProvider.of<NGCFormBloc>(context).add(SelectRegulatorTypeValueEvent(regulatorTypeValue: val!, context:context));
      },
    );
  }

  Widget _regulatorController({required NGCFormDataState dataState}) {
    return  dataState.isRegulator == false ?  _col(
      child: dataState.regulatorTypeValue?.id != "0" ? AutoCompleteTextFieldWidget(
        star: AppString.star,
        enabled: dataState.regulatorTypeValue?.name == null ? false : true,
        label: dataState.regulatorTypeValue?.name != "PRV" ? AppString.meterRegulator : AppString.regulator,
        hintText: dataState.regulatorTypeValue?.name != "PRV" ? AppString.meterRegulator : AppString.regulator,
        suggestions: dataState.listOfRegulatorSerial.length == 0 ? ["No Data Found"] : dataState.listOfRegulatorSerial,
        keyboardType: TextInputType.text,
        controller: dataState.regulatorSerialController,
        onSelected: (val) {
          formKey.currentState?.validate();
          BlocProvider.of<NGCFormBloc>(context).add(SelectRegulatorsValueEvent(context: context, regulatorsValue: val));
        },
        validator: (value) {
          if(value != null && value.isNotEmpty && !dataState.listOfRegulatorSerial.contains(value)) {
            return AppString.regulatorNoErrorMsg;
          }
          return null;
        },
        onChanged: (val) async {
          await formKey.currentState?.validate();
          BlocProvider.of<NGCFormBloc>(context).add(SelectRegulatorsValueEvent(context: context, regulatorsValue: val));
        },
      )  : Container(),
    ): DottedLoaderWidget();
  }
  Widget _srNumberController({required NGCFormDataState dataState}) {
    return  dataState.isRegulator == false ? dataState.regulatorTypeValue?.name == "SR" ? _col(
      child:AutoCompleteTextFieldWidget(
        star: AppString.star,
        label:  AppString.srNumber,
        hintText: AppString.srNumber,
        suggestions: dataState.listOfSRSerial.length == 0 ? ["No Data Found"] : dataState.listOfSRSerial,
        keyboardType: TextInputType.text,
        controller: dataState.srNumberController,
        onSelected: (val) {
          formKey.currentState?.validate();
          BlocProvider.of<NGCFormBloc>(context).add(SelectSRegulatorsEvent(context: context, sRegulators: val));
        },
        validator: (value) {
          if(value != null && value.isNotEmpty && !dataState.listOfSRSerial.contains(value)) {
            return AppString.srNoErrorMsg;
          }
          return null;
        },
        onChanged: (val) async {
          await formKey.currentState?.validate();
          BlocProvider.of<NGCFormBloc>(context).add(SelectSRegulatorsEvent(context: context, sRegulators: val));
        },
      ),
    ): Container()
        : DottedLoaderWidget();
  }
  Widget _locationOfMR({required NGCFormDataState dataState}) {
    return dataState.regulatorTypeValue?.name == "SR" ? _col(
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: TextFieldWidget(
              enabled: false,
              star: AppString.star,
              hintText: AppString.latOfMR,
              label: AppString.latOfMR,
              controller: dataState.latOfMRController,
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
              hintText: AppString.longOfMR,
              label: AppString.longOfMR,
              controller: dataState.longOfMRController,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          IconButtonWidget(
            iconData: Icons.location_on,
            onPressed: () {
              BlocProvider.of<NGCFormBloc>(context).add(SelectLocationOfMREvent(context: context));
            },
          )
        ],
      ),
    ) : Container();
  }
  Widget _locationOfSR({required NGCFormDataState dataState}) {
    return  dataState.regulatorTypeValue?.name == "SR" ? _col(
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: TextFieldWidget(
              enabled: false,
              star: AppString.star,
              hintText: AppString.latOfSR,
              label: AppString.latOfSR,
              controller: dataState.latOfSRController,
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
              hintText: AppString.longOfSR,
              label: AppString.longOfSR,
              controller: dataState.longOfSRController,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          IconButtonWidget(
            iconData: Icons.location_on,
            onPressed: () {
              BlocProvider.of<NGCFormBloc>(context).add(SelectLocationOfSREvent(context: context));
            },
          )
        ],
      ),
    ): Container();
  }

  Widget _mrPhoto({required NGCFormDataState dataState}){
    return dataState.regulatorTypeValue?.name == "SR" ?  _col(
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
                builder: (BuildContext context) {
                  return ImagePopWidget(
                    onTapCamera: () async {
                      Navigator.of(context).pop();
                      BlocProvider.of<NGCFormBloc>(context).add(CaptureCameraMREvent());
                    },
                    onTapGallery: () async {
                      Navigator.of(context).pop();
                      BlocProvider.of<NGCFormBloc>(context).add(CaptureGalleryMREvent());
                    },
                  );
                });
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
                builder: (BuildContext context) {
                  return ImagePopWidget(
                    onTapCamera: () async {
                      Navigator.of(context).pop();
                      BlocProvider.of<NGCFormBloc>(context).add(CaptureCameraSREvent());
                    },
                    onTapGallery: () async {
                      Navigator.of(context).pop();
                      BlocProvider.of<NGCFormBloc>(context).add(CaptureGallerySREvent());
                    },
                  );
                });
          },
        ),
      ),
    ) : Container();
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

  Widget _contractorWidget({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      star: AppString.star,
      label: AppString.contractor,
      hintText: AppString.contractor,
      enabled: true,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: dataState.nameContractorController,
    );
  }

  Widget _contactNoWidget({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      star: AppString.star,
      maxLength: 10,
      label: AppString.mobileNumber,
      hintText: AppString.mobileNumber,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
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
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
      controller: dataState.emailIdController,
    );
  }

  Widget _ngcReportPhoto({required NGCFormDataState dataState}) {
    return  ImageWidget(
      star: AppString.star,
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
                  BlocProvider.of<NGCFormBloc>(context).add(CaptureCameraNGCReportEvent());
                },
                onTapGallery: () async {
                  Navigator.of(context).pop();
                  BlocProvider.of<NGCFormBloc>(context).add(CaptureGalleryNGCReportEvent());
                },
              );
            });
      },
    );
  }

  Widget _submitBtnWidget({required NGCFormDataState dataState}) {
    return dataState.isBtnLoader == false ? Center(
      child: ButtonWidget(
          text: AppString.submit,
          onPressed: () async {
            //   await  formKey.currentState?.validate();
            FocusScope.of(context).unfocus();
            BlocProvider.of<NGCFormBloc>(context).add(NGCSubmitEvent(context: context,));
          }
      ),
    ) : DottedLoaderWidget();
  }

  Widget _sizedBox() {
    var h = MediaQuery.of(context).size.height;
    return SizedBox(
      height: h * 0.02,
    );
  }

  Widget _col({required Widget child}){
    return Column(
      children: [
        child,
        _sizedBox()
      ],
    );
  }

}
