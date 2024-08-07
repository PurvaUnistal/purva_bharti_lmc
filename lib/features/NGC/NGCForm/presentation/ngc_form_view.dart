import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/auto_complete_text_field_widget.dart';
import 'package:lmc/Utils/common_widgets/button_widget.dart';
import 'package:lmc/Utils/common_widgets/dropdown_widget.dart';
import 'package:lmc/Utils/common_widgets/icon_button.dart';
import 'package:lmc/Utils/common_widgets/image_pop_widget.dart';
import 'package:lmc/Utils/common_widgets/local_mg_widget.dart';
import 'package:lmc/Utils/common_widgets/message_box_two_button_pop.dart';
import 'package:lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/Utils/common_widgets/text_form_widget.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:lmc/features/NGC/NGCForm/domain/bloc/ngc_form_bloc.dart';
import 'package:lmc/features/NGC/NGCForm/domain/bloc/ngc_form_event.dart';
import 'package:lmc/features/NGC/NGCForm/domain/bloc/ngc_form_state.dart';


class NGCFormView extends StatefulWidget {
  const NGCFormView({Key? key}) : super(key: key);

  @override
  State<NGCFormView> createState() => _NGCFormViewState();
}

class _NGCFormViewState extends State<NGCFormView> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<NGCFormBloc>(context).add(NGCFormLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBarWidget(
          title: "Add NGC Report",
          boolLeading: true,
        ),
        body: BlocBuilder<NGCFormBloc, NGCFormState>(
          builder: (context, state) {
            print(state);
            if (state is NGCFormPageLoadState) {
              return Center(
                child: SpinLoader(),
              );
            } else if (state is NGCFormDataState) {
              return _buildLayout(dataState: state);
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bpNumberWidget(dataState : dataState),
            _sizedBox(),
            _delayReasonControllerWidget(dataState : dataState),
            _sizedBox(),
            _typeOfNrControllerWidget(dataState : dataState),
            _sizedBox(),
            _meterReplaceWidget(dataState : dataState),
            _sizedBox(),
            _meterReplaceController(dataState : dataState),
            _sizedBox(),
            _meterReaderWidget(dataState : dataState),
            _sizedBox(),
            _regulatorTypeDropdown(dataState : dataState),
            _sizedBox(),
            _regulatorController(dataState : dataState),
            _sizedBox(),
            _rfcDecDateController(dataState : dataState),
            _sizedBox(),
            _proposedNgcConversionDateController(dataState : dataState),
            _sizedBox(),
            _delayReasonDropdown(dataState : dataState),
            _sizedBox(),
            _locationOfSR(dataState : dataState),
            _sizedBox(),
            _locationOfHouse(dataState : dataState),
            _sizedBox(),
            _contractorWidget(dataState : dataState),
            _sizedBox(),
            _burnerNoWidget(dataState : dataState),
            _sizedBox(),
            _contactNoWidget(dataState : dataState),
            _sizedBox(),
            _altContactNoWidget(dataState : dataState),
            _sizedBox(),
            _emailWidget(dataState : dataState),
            _sizedBox(),
            _ngcChargeDateController(dataState : dataState),
            _sizedBox(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _meterPhoto(dataState: dataState),
                _ngcReportPhoto(dataState: dataState),
              ],
            ),
            _sizedBox(),
            _sizedBox(),
            _submitBtnWidget(dataState: dataState)
          ],
        ),
      ),
    );
  }

  Widget _contractorWidget({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      star: AppString.star,
      label: AppString.contractor,
      hintText: AppString.contractor,
      enabled: false,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: dataState.nameContractorController,
    );
  }

  Widget _bpNumberWidget({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      label: AppString.bpNumber,
      hintText: AppString.bpNumber,
      enabled: false,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: dataState.bpNumberController,
    );
  }

  Widget _delayReasonControllerWidget({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      label: AppString.reasonDelay,
      hintText: AppString.reasonDelay,
      enabled: false,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: dataState.delayReasonController,
    );
  }

  Widget _typeOfNrControllerWidget({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      label: AppString.typeOfNR,
      hintText: AppString.typeOfNR,
      enabled: false,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: dataState.typeOfNrController,
    );
  }

  Widget _meterReplaceWidget({required NGCFormDataState dataState}) {
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

  Widget _meterReplaceController({required NGCFormDataState dataState}) {
    return dataState.isMeterReplace == true ?AutoCompleteTextFieldWidget(
      star: AppString.star,
      hintText: AppString.meterNumber,
      label: AppString.meterNumber,
      suggestions: dataState.listOfRegulatorSerial,
      keyboardType: TextInputType.text,
      onSelected: (val) {
        BlocProvider.of<NGCFormBloc>(context).add(SelectMeterNumberValueEvent(
            context: context,
            meterReadingValue: val
        ));
      },
    ) : TextFieldWidget(
      label: AppString.meterNumber,
      hintText: AppString.meterNumber,
      enabled: false,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: dataState.meterNoMismatchController,
    );
  }

  Widget _meterReaderWidget({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      star: AppString.star,
      label: AppString.meterReading,
      hintText: AppString.meterReading,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: dataState.meterReaderController,
    );
  }

  Widget _regulatorTypeDropdown({required NGCFormDataState dataState}) {
    return DropdownWidget<LmcReasonModel>(
      label: AppString.regulatorType,
      hint: AppString.regulatorType,
      dropdownValue: dataState.regulatorTypeValue?.name == null ? null : dataState.regulatorTypeValue,
      items: dataState.listOfRegulatorType,
      onChanged: (val) {
        BlocProvider.of<NGCFormBloc>(context).add(SelectRegulatorTypeValueEvent(regulatorTypeValue: val!, context:context));
      },
    );
  }

  Widget _regulatorController({required NGCFormDataState dataState}) {
    return dataState.isRegulator == false ? AutoCompleteTextFieldWidget(
      label: dataState.regulatorTypeValue?.name!= "PRV" ? AppString.meterRegulator : AppString.regulator,
      hintText: dataState.regulatorTypeValue?.name!= "PRV" ? AppString.meterRegulator : AppString.regulator,
      suggestions: dataState.listOfRegulatorSerial.length == 0 ? ["No Data"] : dataState.listOfRegulatorSerial,
      keyboardType:  TextInputType.text,
      onSelected: (val) {
        BlocProvider.of<NGCFormBloc>(context).add(SelectRegulatorsValueEvent(
            context: context,
            regulatorsValue: val
        ));
      },
    ): DottedLoaderWidget();
  }

  Widget _rfcDecDateController({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      star: AppString.star,
      hintText: AppString.rfcDecDate,
      label: AppString.rfcDecDate,
      enabled: false,
      controller: dataState.rfcDecDateController,
      suffixIcon: IconButtonWidget(
        iconData:  Icons.calendar_today,
        onPressed: () {
        },
      ),
    );
  }

  Widget _proposedNgcConversionDateController({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      star: AppString.star,
      label: AppString.ngChargeDate,
      hintText: AppString.ngChargeDate,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.datetime,
      controller: dataState.proposedNgcConversionDateController,
      suffixIcon: IconButtonWidget(
        iconData:  Icons.calendar_today,
        onPressed: () {
          BlocProvider.of<NGCFormBloc>(context).add(SelectProposedNgcConversionDateEvent(context: context));
        },
      ),
      onTap: (){
        BlocProvider.of<NGCFormBloc>(context).add(SelectProposedNgcConversionDateEvent(context: context));
      },
    );
  }

  Widget _delayReasonDropdown({required NGCFormDataState dataState}) {
    return DropdownWidget<LmcReasonModel>(
      star: AppString.star,
      label: AppString.reasonDelay,
      hint: AppString.reasonDelay,
      dropdownValue: dataState.delayReasonValue?.name == null ? null : dataState.delayReasonValue,
      items: dataState.listOfDelayReason,
      onChanged: (val) {
        BlocProvider.of<NGCFormBloc>(context).add(SelectDelayReasonValueEvent(delayReasonValue: val!));
      },
    ) ;
  }

  Widget _locationOfSR({required NGCFormDataState dataState}){
    return Row(
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
        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
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
        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
        IconButtonWidget(
          iconData:Icons.location_on,
          onPressed: (){
            BlocProvider.of<NGCFormBloc>(context).add(SelectLocationOfSREvent(context: context));
          }, )
      ],
    );
  }

  Widget _locationOfHouse({required NGCFormDataState dataState}){
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
        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
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
        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
        IconButtonWidget(
          iconData:  Icons.location_on,
          onPressed: (){
            BlocProvider.of<NGCFormBloc>(context).add(SelectLocationOfSREvent(context: context));
          }, )
      ],
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


  Widget _contactNoWidget({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      star: AppString.star,
      label: AppString.mobileNumber,
      hintText: AppString.mobileNumber,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      controller: dataState.mobileNumberController,
    );
  }

  Widget _altContactNoWidget({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      label: AppString.altMobileNo,
      hintText: AppString.altMobileNo,
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

  Widget _ngcChargeDateController({required NGCFormDataState dataState}) {
    return TextFieldWidget(
      star: AppString.star,
      hintText: AppString.rfcDecDate,
      label: AppString.rfcDecDate,
      enabled: true,
      controller: dataState.ngcChargeDateController,
      suffixIcon: IconButtonWidget(
        iconData:  Icons.calendar_today,
        onPressed: () {
          BlocProvider.of<NGCFormBloc>(context).add(SelectNgcChargeDateEvent(context: context));
        },
      ),
      onTap: () {
        BlocProvider.of<NGCFormBloc>(context).add(SelectNgcChargeDateEvent(context: context));
      },
    );
  }

  Widget _meterPhoto({required NGCFormDataState dataState}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(flex : 1,child: Text("*",  style:Styles.stars)),
              Flexible(flex : 6,child: Text(AppString.meterFile ?? "", style:Styles.labels),
              ),
            ],
          ),
        ),
        LocalImgWidget(
          file: dataState.meterPhoto,
          onTap: () {
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
        ),
      ],
    );
  }

  Widget _ngcReportPhoto({required NGCFormDataState dataState}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(flex : 1,child: Text("*",  style:Styles.stars)),
              Flexible(flex : 6,child: Text(AppString.ngcReportFile ?? "", style:Styles.labels),
              ),
            ],
          ),
        ),
        LocalImgWidget(
          file: dataState.ngcReportPhoto,
          onTap: () {
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
        ),
      ],
    );
  }

  Widget _submitBtnWidget({required NGCFormDataState dataState}) {
    return dataState.isBtnLoader == false ? Center(
      child: ButtonWidget(
          text: AppString.submit,
          onPressed: () {
            FocusScope.of(context).unfocus();
            BlocProvider.of<NGCFormBloc>(context).add(NGCSubmitEvent(context: context,));
          }),
    ) : DottedLoaderWidget();
  }

  Widget _sizedBox() {
    var h = MediaQuery.of(context).size.height;
    return SizedBox(
      height: h * 0.02,
    );
  }

}
