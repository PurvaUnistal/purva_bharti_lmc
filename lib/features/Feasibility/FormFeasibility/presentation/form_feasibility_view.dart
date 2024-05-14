import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/app_color.dart';
import 'package:lmc/Utils/common_widgets/app_string.dart';
import 'package:lmc/Utils/common_widgets/button_widget.dart';
import 'package:lmc/Utils/common_widgets/dropdown_widget.dart';
import 'package:lmc/Utils/common_widgets/message_box_two_button_pop.dart';
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
        appBar: AppBarWidget(
          title: RoutesName.lmcFeasibility,
          boolLeading: true,
        ),
        body: BlocBuilder<FormFeasibilityBloc, FormFeasibilityState>(
          builder: (context, state) {
            if (state is FormFeasibilityDataState) {
              return _itemBuilder(dataState: state);
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
        builder: (BuildContext mContext) => MessageBoxTwoButtonPopWidget(
            message: "Do you want to Feasibility Installation?",
            okButtonText: "Exit",
            onPressed: () =>  Navigator.of(context).pop(true)
        ))
    ) ?? false;
  }

  _itemBuilder({required FormFeasibilityDataState dataState}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _feasibilityDateController(stateData: dataState),
            _verticalSpace(),
            _checkFeasibilityDropdown(stateData: dataState),
            _lmcReasonDropdown(stateData: dataState),
            _reasonController(stateData: dataState),
            _followUpDateController(stateData: dataState),
            _verticalSpace(),
            _verticalSpace(),
            _button(dataState: dataState),
          ],
        ),
      ),
    );
  }

  Widget _feasibilityDateController({required FormFeasibilityDataState stateData}) {
    return TextFieldWidget(
      hintText: AppString.lmcFeaDate,
      label: AppString.lmcFeaDate,
      enabled: true,
      controller: stateData.feasibilityDateController,
      suffixIcon: IconButton(
        icon: Icon(
          Icons.calendar_today,
          color: AppColor.primer,
        ),
        onPressed: () {
          BlocProvider.of<FormFeasibilityBloc>(context).add(SelectFeasibilityDateEvent(context: context));
        },
      ),
      onTap: () {
        BlocProvider.of<FormFeasibilityBloc>(context).add(SelectFeasibilityDateEvent(context: context));
      },
    );
  }

  Widget _checkFeasibilityDropdown({required FormFeasibilityDataState stateData}) {
    return DropdownWidget<GetConstantModel>(
      star: AppString.star,
      label: AppString.checkFeasibility,
      hint: AppString.checkFeasibility,
      dropdownValue: stateData.checkFeasibleValue == null ? null : stateData.checkFeasibleValue,
      items: stateData.listOfCheckFeasible,
      onChanged: (val) {
        BlocProvider.of<FormFeasibilityBloc>(context).add(SelectCheckFeasibilityValueEvent(checkFeasibility: val));
      },
    );
  }
  Widget _lmcReasonDropdown({required FormFeasibilityDataState stateData}) {
    return stateData.checkFeasibleValue?.key == "2" || stateData.checkFeasibleValue?.key == "3" ? _col(
      child: DropdownWidget<GetConstantModel>(
        star: AppString.star,
        label: AppString.lmcReason,
        hint: AppString.lmcReason,
        dropdownValue: stateData.lmcReasonValue == null ? null : stateData.lmcReasonValue,
        items: stateData.listOfLMCReason,
        onChanged: (val) {
          BlocProvider.of<FormFeasibilityBloc>(context).add(SelectLMCReasonValueEvent(lmcReasonValue: val));
        },
      ),
    )
  :  Container();
  }

  Widget _reasonController({required FormFeasibilityDataState stateData}) {
    return stateData.checkFeasibleValue?.key == "2" || stateData.checkFeasibleValue?.key == "3" ?_col(
      child: TextFieldWidget(
        hintText: AppString.reason,
        label: AppString.reason,
        enabled: true,
        maxLine: 3,
        inputType: TextInputType.text,
        controller: stateData.reasonController,
      ),
    )
    :Container();
  }

  Widget _followUpDateController({required FormFeasibilityDataState stateData}) {
    return stateData.checkFeasibleValue?.key == "3" ?_col(
      child: TextFieldWidget(
        hintText: AppString.followUpDate,
        label: AppString.followUpDate,
        enabled: true,
        controller: stateData.followUpDateController,
        suffixIcon: IconButton(
          icon: Icon(
            Icons.calendar_today,
            color: AppColor.primer,
          ),
          onPressed: () {
            BlocProvider.of<FormFeasibilityBloc>(context).add(SelectFollowUpDateEvent(context: context));
          },
        ),
        onTap: () {
          BlocProvider.of<FormFeasibilityBloc>(context).add(SelectFollowUpDateEvent(context: context));
        },
      ),
    )
        :Container();
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

  Widget _col({required Widget child}){
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
