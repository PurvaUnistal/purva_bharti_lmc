import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'package:lmc/Utils/common_widgets/styles_widget.dart';
import 'package:lmc/Utils/common_widgets/text_form_widget.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/InternetConnection/domain/bloc/network_bloc.dart';
import 'package:lmc/features/InternetConnection/domain/bloc/network_event.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/FormRFCSection/domain/bloc/form_rfc_bloc.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/FormRFCSection/domain/bloc/form_rfc_event.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/FormRFCSection/domain/bloc/form_rfc_state.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/FormRFCSection/presentation/Widgets/image_widget.dart';

class FormRFCView extends StatefulWidget {
  const FormRFCView({
    super.key,
  });

  @override
  State<FormRFCView> createState() => _FormRFCViewState();
}

class _FormRFCViewState extends State<FormRFCView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NetworkBloc>(context)
        .add(NetworkObserveEvent(context: context));
    BlocProvider.of<FormRFCBloc>(context).add(FormRFCPageLoadEvent(context: context));
  }

  GlobalKey<AutoCompleteTextFieldState<String>> globalSearchKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: RoutesName.rfcSection,
        boolLeading: true,
      ),
      body: BlocBuilder<FormRFCBloc, FormRFCState>(
        builder: (context, state) {
          if (state is FormRFCDataState) {
            return _itemBuilder(dataState: state);
          } else {
            return Center(child: SpinLoader());
          }
        },
      ),
    );
  }

  _itemBuilder({required FormRFCDataState dataState}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
            _extraPipePrice(stateData: dataState),
            _verticalSpace(),
            _checkListRFC(stateData: dataState),
            _verticalSpace(),
            _image(stateData: dataState),
            _verticalSpace(),
            _verticalSpace(),
            _button(stateData: dataState),
          ],
        ),
      ),
    );
  }
  Widget _srNumberController({required FormRFCDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.srNumber,
      label: AppString.srNumber,
      keyboardType: TextInputType.number,
      enabled: true,
      maxLength: 10,
      controller: stateData.srNumberController,
    );
  }


  Widget _regulatorController({required FormRFCDataState stateData}) {
    return AutoSuggestionTextFieldWidget(
      globalKey: globalSearchKey,
      star: AppString.star,
      label: AppString.regulator,
      hintText: AppString.regulator,
      controller: stateData.regulatorController,
      suggestions: stateData.listOfRegulator,
      keyboardType:  TextInputType.number,
      textSubmitted: (val) {
        print(val);
        BlocProvider.of<FormRFCBloc>(context).add(SelectRegulatorsValueEvent(
            context: context,
            regulatorsValue: val
        ));
      },
      textChanged: (val) {
        print(val);
        BlocProvider.of<FormRFCBloc>(context).add(SelectRegulatorsValueEvent(
            context: context,
            regulatorsValue: val
        ));
      },
    );
  }

  Widget _rfcConDateController({required FormRFCDataState stateData}) {
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
          BlocProvider.of<FormRFCBloc>(context).add(SelectRFCDeclarationDateEvent(context: context));
        },
      ),
      onTap: () {
        BlocProvider.of<FormRFCBloc>(context).add(SelectRFCDeclarationDateEvent(context: context));
      },
    );
  }

  Widget _proConDateController({required FormRFCDataState stateData}) {
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
          BlocProvider.of<FormRFCBloc>(context).add(SelectProposedConDateEvent(context: context));
        },
      ),
      onTap: () {
        BlocProvider.of<FormRFCBloc>(context).add(SelectProposedConDateEvent(context: context));
      },
    );
  }

  Widget _materialList({required FormRFCDataState stateData}){
    return Column(
      children: stateData.materialList.map((e) {
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
                    enabled: true,
                    controller: e.controller,
                    onChanged: (val){
                      BlocProvider.of<FormRFCBloc>(context).add(SelectQTYLMCEvent(context: context, qtyValue: val));
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


  Widget _extraPipePrice({required FormRFCDataState stateData}){
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: TextFieldWidget(
            hintText: AppString.extraPrice,
            label: AppString.extraPrice,
            enabled: false,
            controller: stateData.extraPriceController,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
        Flexible(
          flex: 3,
          child: TextFieldWidget(
            hintText: AppString.extraPrice,
            label: AppString.extraPrice,
            enabled: false,
            controller: stateData.extraPriceController,
          ),
        )
      ],
    );
  }
  Widget _locationOfSR({required FormRFCDataState stateData}){
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: TextFieldWidget(
            enabled: false,
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
            hintText: AppString.longOfSR,
            label: AppString.longOfSR,
            controller: stateData.longOfSRController,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
        IconButton(
          icon: Icon(Icons.location_on, color: AppColor.primer,),
          onPressed: (){
            BlocProvider.of<FormRFCBloc>(context).add(SelectLocationOfSREvent(context: context));
          }, )
      ],
    );
  }
  Widget _locationOfHouse({required FormRFCDataState stateData}){
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: TextFieldWidget(
            enabled: false,
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
            hintText: AppString.longOfHouse,
            label: AppString.longOfHouse,
            controller: stateData.longOfHouseController,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
        IconButton(
          icon: Icon(Icons.location_on, color: AppColor.primer,),
          onPressed: (){
            BlocProvider.of<FormRFCBloc>(context).add(SelectLocationOfSREvent(context: context));
          }, )
      ],
    );
  }

  Widget _image({required FormRFCDataState stateData}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ImageWidget(
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
                      BlocProvider.of<FormRFCBloc>(context).add(
                          CaptureCameraRFCCardEvent());
                    },
                    onTapGallery: () async {
                      Navigator.of(context).pop();
                      BlocProvider.of<FormRFCBloc>(context).add(
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
                      BlocProvider.of<FormRFCBloc>(context).add(
                          CaptureCameraPneumaticEvent());
                    },
                    onTapGallery: () async {
                      Navigator.of(context).pop();
                      BlocProvider.of<FormRFCBloc>(context).add(
                          CaptureGalleryPneumaticEvent());
                    },
                  );
                });
          },
        ),
        ImageWidget(
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
                      BlocProvider.of<FormRFCBloc>(context).add(
                          CaptureCameraInstallationEvent());
                    },
                    onTapGallery: () async {
                      Navigator.of(context).pop();
                      BlocProvider.of<FormRFCBloc>(context).add(
                          CaptureGalleryInstallationEvent());
                    },
                  );
                });
          },
        ),
      ],
    );
  }

  Widget _checkListRFC({required FormRFCDataState stateData}){
    return Column(
        children: List.generate(
            stateData.listOfAllRFC.length,
                (index) => CheckboxListTile(
              value: stateData.listOfAllRFC[index].isSelected!,
              title: Text(stateData.listOfAllRFC[index].value!, style: Styles.labels,),
              onChanged: (val){
                BlocProvider.of<FormRFCBloc>(context).add(
                    SelectRFCCheckValueEvent(
                        context: context,
                        isSelected: val!,
                        index: index
                    ));
              },

            ))
    );
  }

  Widget _button({required FormRFCDataState stateData}) {
    return stateData.isBtnLoader == false
        ? ButtonWidget(
        text: AppString.submit,
        onPressed: () {
          BlocProvider.of<FormRFCBloc>(context).add(SubmitFormRFCEvent(context: context));
        })
        : DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
