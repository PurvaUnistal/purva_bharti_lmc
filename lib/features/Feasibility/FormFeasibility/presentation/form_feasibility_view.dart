import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
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
    BlocProvider.of<FormFeasibilityBloc>(context).add(FormFeasibilityPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColor.green50,
        body: BlocBuilder<FormFeasibilityBloc, FormFeasibilityState>(
          builder: (context, state) {
            if (state is FormFeasibilityDataState) {
              return BackgroundWidget(
                child: _itemBuilder(dataState: state),
              );
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
            builder: (BuildContext mContext) =>
                MessageBoxTwoButtonPopWidget(message: "Do you want to Feasibility Installation?", okButtonText: "Exit", onPressed: () => Navigator.of(context).pop(true)))) ??
        false;
  }

  _itemBuilder({required FormFeasibilityDataState dataState}) {
    return Scaffold(
      appBar: AppBarWidget(
        title: AppString.lmcFeaH,
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
          Text("Feasibility Form",style: Styles.text,textAlign: TextAlign.center,),
          _verticalSpace(),
          RowWidget(
            widget1:  _bpNumberController(stateData: dataState),
            widget2: _trNumberController(stateData: dataState),
            widget3: _assignedDateController(stateData: dataState),
          ),
          _feasibilityDateController(stateData: dataState),
          _verticalSpace(),
          _checkFeasibilityDropdown(stateData: dataState),
          _verticalSpace(),
          _materialList(dataState: dataState),
          _proposedDateController(stateData: dataState),
          _lmcReasonDropdown(stateData: dataState),
          _reasonController(stateData: dataState),
          _followUpDateController(stateData: dataState),
          _remarksController(stateData: dataState),
          _verticalSpace(),
          _verticalSpace(),
          _button(dataState: dataState),
          _verticalSpace(),
          _verticalSpace(),
        ],
      ),
    );
  }


  Widget _bpNumberController({required FormFeasibilityDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.bpNumber,
      label: AppString.bpNumber,
      enabled: false,
      controller: stateData.bpNumberController,
    );
  }
  Widget _trNumberController({required FormFeasibilityDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.trNumber,
      label: AppString.trNumber,
      enabled: false,
      controller: stateData.trNumberController,
    );
  }

  Widget _assignedDateController({required FormFeasibilityDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.lmcAssignedDate,
      label: AppString.lmcAssignedDate,
      enabled: false,
      controller: stateData.assignedDateController,
    );
  }

  Widget _feasibilityDateController({required FormFeasibilityDataState stateData}) {
    return stateData.checkFeasibleValue?.key == "2" || stateData.checkFeasibleValue?.key == "3"
        ? Container()
        : _col(
            child: TextFieldWidget(
              star: AppString.star,
              hintText: AppString.lmcFeaDate,
              label: AppString.lmcFeaDate,
              enabled: true,
              controller: stateData.feasibilityDateController,
              suffixIcon: IconButtonWidget(
                iconData: Icons.calendar_today,
                onPressed: () {
                  BlocProvider.of<FormFeasibilityBloc>(context).add(SelectFeasibilityDateEvent(context: context));
                },
              ),
              onTap: () {
                BlocProvider.of<FormFeasibilityBloc>(context).add(SelectFeasibilityDateEvent(context: context));
              },
            ),
          );
  }

  Widget _checkFeasibilityDropdown({required FormFeasibilityDataState stateData}) {
    return DropdownWidget<GetConstantModel>(
      star: AppString.star,
      label: AppString.checkFeasibility,
      hint: AppString.checkFeasibility,
      dropdownValue: stateData.checkFeasibleValue?.value == null ? null : stateData.checkFeasibleValue,
      items: stateData.listOfCheckFeasible,
      onChanged: (val) {
        BlocProvider.of<FormFeasibilityBloc>(context).add(SelectCheckFeasibilityValueEvent(checkFeasibility: val));
      },
    );
  }

  Widget _materialList({required FormFeasibilityDataState dataState}) {
    return dataState.checkFeasibleValue?.key == "1"
        ? Column(
            children: dataState.materialList.mapIndexed((index, e) {
              return Column(
                children: [
                  Row(
                    children: [
                      Flexible(
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
                      Flexible(
                        flex: 3,
                        child: TextFieldWidget(
                          hintText: e.unit,
                          label: e.unit,
                          initialValue: e.controller.text,
                          enabled: true,
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            BlocProvider.of<FormFeasibilityBloc>(context).add(SelectQTYLMCEvent(context: context, qtyValue: val, index: index));
                          },
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
          )
        : Container();
  }

  Widget _proposedDateController({required FormFeasibilityDataState stateData}) {
    return stateData.checkFeasibleValue?.key == "2" || stateData.checkFeasibleValue?.key == "3"
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
                BlocProvider.of<FormFeasibilityBloc>(context).add(SelectProposedDateEvent(context: context));
              },
            ),
            onTap: () {
              BlocProvider.of<FormFeasibilityBloc>(context).add(SelectProposedDateEvent(context: context));
            },
          );
  }

  Widget _lmcReasonDropdown({required FormFeasibilityDataState stateData}) {
    return stateData.checkFeasibleValue?.key == "2" || stateData.checkFeasibleValue?.key == "3"
        ? Center(
            child: DropdownWidget<GetConstantModel>(
              star: AppString.star,
              label: AppString.lmcReason,
              hint: AppString.lmcReason,
              dropdownValue: stateData.lmcReasonValue?.key == null ? null : stateData.lmcReasonValue,
              items: stateData.listOfLMCReason,
              onChanged: (val) {
                print("stateData.lmcReasonValue -->${stateData.lmcReasonValue}");
                BlocProvider.of<FormFeasibilityBloc>(context).add(SelectLMCReasonValueEvent(lmcReasonValue: val));
              },
            ),
          )
        : Container();
  }

  Widget _reasonController({required FormFeasibilityDataState stateData}) {
    return stateData.checkFeasibleValue?.key == "2" || stateData.checkFeasibleValue?.key == "3"
        ? stateData.lmcReasonValue?.key == "Others"
            ? _col(
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
        ? _col(
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

  Widget _followUpDateController({required FormFeasibilityDataState stateData}) {
    return stateData.checkFeasibleValue?.key == "3"
        ? _col(
            child: TextFieldWidget(
              hintText: AppString.followUpDate,
              label: AppString.followUpDate,
              enabled: true,
              controller: stateData.followUpDateController,
              suffixIcon: IconButtonWidget(
                iconData: Icons.calendar_today,
                onPressed: () {
                  BlocProvider.of<FormFeasibilityBloc>(context).add(SelectFollowUpDateEvent(context: context));
                },
              ),
              onTap: () {
                BlocProvider.of<FormFeasibilityBloc>(context).add(SelectFollowUpDateEvent(context: context));
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
              BlocProvider.of<FormFeasibilityBloc>(context).add(SubmitFormFeasibilityEvent(context: context));
            })
        : DottedLoaderWidget();
  }

  Widget _col({required Widget child}) {
    return Column(
      children: [
        _verticalSpace(),
        child,
      ],
    );
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
