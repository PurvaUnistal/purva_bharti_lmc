import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/WidgetStyles/common_style.dart';
import 'package:lmc/Utils/common_widgets/background_widget.dart';
import 'package:lmc/Utils/common_widgets/button_widget.dart';
import 'package:lmc/Utils/common_widgets/dropdown_widget.dart';
import 'package:lmc/Utils/common_widgets/icon_button.dart';
import 'package:lmc/Utils/common_widgets/message_box_two_button_pop.dart';
import 'package:lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/Utils/common_widgets/row_widget.dart';
import 'package:lmc/Utils/common_widgets/text_form_widget.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/bloc/form_feasibility_bloc.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/bloc/form_feasibility_event.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/bloc/form_feasibility_state.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';

class FormFeasibilityView extends StatefulWidget {
  const FormFeasibilityView({
    super.key,
  });

  @override
  State<FormFeasibilityView> createState() => _FormFeasibilityViewState();
}

class _FormFeasibilityViewState extends State<FormFeasibilityView> {
  @override
  void initState() {
    BlocProvider.of<FormFeasibilityBloc>(context)
        .add(FormFeasibilityPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBarWidget(
        title: AppString.lmcFeaH,
        boolLeading: true,
    ),
    body: SafeArea(
      child: BackgroundWidget(
          child: BlocBuilder<FormFeasibilityBloc, FormFeasibilityState>(
            builder: (context, state) {
              if (state is FormFeasibilityDataState) {
                return _itemBuilder(dataState: state);
              } else {
                return Center(child: SpinLoader());
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
                message: "Do you want to Feasibility Installation?",
                okButtonText: "Exit",
                onPressed: () => Navigator.of(context).pop(true)))) ??
        false;
  }

  _itemBuilder({required FormFeasibilityDataState dataState}) {
    return ListView(
        padding: EdgeInsets.all(8),
        children: [
          Text(
            AppString.feasibilityForm,
            style: Styles.text,
            textAlign: TextAlign.center,
          ),
          CommonStyle.vertical(context: context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 1, child: _bpNumberController(stateData: dataState)),
              CommonStyle.widthSpace(context: context),
              Flexible(
                  flex: 1, child: _trNumberController(stateData: dataState)),
              CommonStyle.widthSpace(context: context),
              Flexible(
                  flex: 1,
                  child: _assignedDateController(stateData: dataState)),
            ],
          ),
          _feasibilityDateController(stateData: dataState),
          CommonStyle.vertical(context: context),
          _checkFeasibilityDropdown(stateData: dataState),
          CommonStyle.vertical(context: context),
          _materialList(dataState: dataState),
          _proposedDateController(stateData: dataState),
          _lmcReasonDropdown(stateData: dataState),
          _reasonController(stateData: dataState),
          _followUpDateController(stateData: dataState),
          _remarksController(stateData: dataState),
          CommonStyle.vertical(context: context),
          CommonStyle.vertical(context: context),
          _button(dataState: dataState),
          CommonStyle.vertical(context: context),
          CommonStyle.vertical(context: context),
        ],
    );
  }

  Widget _bpNumberController({required FormFeasibilityDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.trNumber,
      label: AppString.trNumber,
      enabled: false,
      controller: stateData.bpNumberController,
    );
  }

  Widget _trNumberController({required FormFeasibilityDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.crNumber,
      label: AppString.crNumber,
      enabled: false,
      controller: stateData.trNumberController,
    );
  }

  Widget _assignedDateController(
      {required FormFeasibilityDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.assignedDate,
      label: AppString.assignedDate,
      enabled: false,
      controller: stateData.assignedDateController,
    );
  }

  Widget _feasibilityDateController(
      {required FormFeasibilityDataState stateData}) {
    return stateData.checkFeasibleValue?.key == "2" ||
            stateData.checkFeasibleValue?.key == "3"
        ? Container()
        : CommonStyle.col(
            context: context,
            child: TextFieldWidget(
              star: AppString.star,
              hintText: AppString.lmcFeaDate,
              label: AppString.lmcFeaDate,
              enabled: true,
              controller: stateData.feasibilityDateController,
              suffixIcon: IconButtonWidget(
                iconData: Icons.calendar_today,
                onPressed: () {
                  BlocProvider.of<FormFeasibilityBloc>(context)
                      .add(SelectFeasibilityDateEvent(context: context));
                },
              ),
              onTap: () {
                BlocProvider.of<FormFeasibilityBloc>(context)
                    .add(SelectFeasibilityDateEvent(context: context));
              },
            ),
          );
  }

  Widget _checkFeasibilityDropdown(
      {required FormFeasibilityDataState stateData}) {
    return DropdownWidget<GetConstantModel>(
      star: AppString.star,
      label: AppString.checkFeasibility,
      hint: AppString.checkFeasibility,
      dropdownValue: stateData.checkFeasibleValue?.value == null
          ? null
          : stateData.checkFeasibleValue,
      items: stateData.listOfCheckFeasible,
      onChanged: (val) {
        BlocProvider.of<FormFeasibilityBloc>(context)
            .add(SelectCheckFeasibilityValueEvent(checkFeasibility: val));
      },
    );
  }

  Widget _materialList({required FormFeasibilityDataState dataState}) {
    return dataState.checkFeasibleValue?.key == "1"
        ? Column(
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
                                      BlocProvider.of<FormFeasibilityBloc>(
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
              dataState.isExtraPipe == false
                  ? _extraPipeWidget(dataState: dataState)
                  : DottedLoaderWidget(),
              CommonStyle.vertical(context: context),
            ],
          )
        : Container();
  }

  Widget _extraPipeWidget({required FormFeasibilityDataState dataState}) {
    return RowWidget(
      widget1: TextFieldWidget(
        enabled: false,
        hintText: AppString.extraPipe,
        label: AppString.extraPipe,
        controller: dataState.extraPipeController,
      ),
      widget2: TextFieldWidget(
        enabled: false,
        hintText: AppString.extraPrice,
        label: AppString.extraPrice,
        controller: dataState.extraPriceController,
      ),
    );
  }

  Widget _proposedDateController(
      {required FormFeasibilityDataState stateData}) {
    return stateData.checkFeasibleValue?.key == "2" ||
            stateData.checkFeasibleValue?.key == "3"
        ? Container()
        : TextFieldWidget(
            star: AppString.star,
            hintText: AppString.lmcProDate,
            label: AppString.lmcProDate,
            enabled: true,
            controller: stateData.proposedDateController,
            suffixIcon: IconButtonWidget(
              iconData: Icons.calendar_today,
              onPressed: () {
                BlocProvider.of<FormFeasibilityBloc>(context)
                    .add(SelectProposedDateEvent(context: context));
              },
            ),
            onTap: () {
              BlocProvider.of<FormFeasibilityBloc>(context)
                  .add(SelectProposedDateEvent(context: context));
            },
          );
  }

  Widget _lmcReasonDropdown({required FormFeasibilityDataState stateData}) {
    return stateData.checkFeasibleValue?.key == "2" ||
            stateData.checkFeasibleValue?.key == "3"
        ? Center(
            child: DropdownWidget<GetConstantModel>(
              star: AppString.star,
              label: AppString.lmcReason,
              hint: AppString.lmcReason,
              dropdownValue: stateData.lmcReasonValue?.key == null
                  ? null
                  : stateData.lmcReasonValue,
              items: stateData.listOfLMCReason,
              onChanged: (val) {
                print(
                    "stateData.lmcReasonValue -->${stateData.lmcReasonValue}");
                BlocProvider.of<FormFeasibilityBloc>(context)
                    .add(SelectLMCReasonValueEvent(lmcReasonValue: val));
              },
            ),
          )
        : Container();
  }

  Widget _reasonController({required FormFeasibilityDataState stateData}) {
    return stateData.checkFeasibleValue?.key == "2" ||
            stateData.checkFeasibleValue?.key == "3"
        ? stateData.lmcReasonValue?.key == "Others"
            ? CommonStyle.col(
                context: context,
                child: TextFieldWidget(
                  star: AppString.star,
                  hintText: AppString.reason,
                  label: AppString.reason,
                  enabled: true,
                  maxLine: 2,
                  inputType: TextInputType.text,
                  controller: stateData.reasonController,
                ),
              )
            : Container()
        : Container();
  }

  Widget _remarksController({required FormFeasibilityDataState stateData}) {
    return stateData.checkFeasibleValue?.key == "3"
        ? CommonStyle.col(
            context: context,
            child: TextFieldWidget(
              hintText: AppString.remarks,
              label: AppString.remarks,
              enabled: true,
              maxLine: 3,
              inputType: TextInputType.text,
              controller: stateData.remarksController,
            ),
          )
        : Container();
  }

  Widget _followUpDateController(
      {required FormFeasibilityDataState stateData}) {
    return stateData.checkFeasibleValue?.key == "3"
        ? CommonStyle.col(
            context: context,
            child: TextFieldWidget(
              star: AppString.star,
              hintText: AppString.followUpDate,
              label: AppString.followUpDate,
              enabled: true,
              controller: stateData.followUpDateController,
              suffixIcon: IconButtonWidget(
                iconData: Icons.calendar_today,
                onPressed: () {
                  BlocProvider.of<FormFeasibilityBloc>(context)
                      .add(SelectFollowUpDateEvent(context: context));
                },
              ),
              onTap: () {
                BlocProvider.of<FormFeasibilityBloc>(context)
                    .add(SelectFollowUpDateEvent(context: context));
              },
            ),
          )
        : Container();
  }

  Widget _button({required FormFeasibilityDataState dataState}) {
    return dataState.isBtnLoader == false
        ? ButtonWidget(
            text: AppString.submit,
            onPressed: () {
              BlocProvider.of<FormFeasibilityBloc>(context)
                  .add(SubmitFormFeasibilityEvent(context: context));
            })
        : DottedLoaderWidget();
  }
}
