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
import 'package:lmc/Utils/common_widgets/text_form_widget.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/bloc/form_feasibility_bloc.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/bloc/form_feasibility_event.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/bloc/form_feasibility_state.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/CheckFeasibleModel.dart';

class FormFeasibilityView extends StatefulWidget {
  const FormFeasibilityView({super.key,});

  @override
  State<FormFeasibilityView> createState() => _FormFeasibilityViewState();
}

class _FormFeasibilityViewState extends State<FormFeasibilityView> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FormFeasibilityBloc>(context).add(FormFeasibilityPageLoadEvent(context: context));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: RoutesName.lmcFeasibility,
        boolLeading: true,
      ),
      body:  BlocBuilder<FormFeasibilityBloc, FormFeasibilityState>(
        builder: (context, state) {
          if (state is FormFeasibilityDataState) {
            return _itemBuilder(dataState: state);
          } else {
            return Center(child: SpinLoader());
          }
        },
      ),
    );
  }

  _itemBuilder({required FormFeasibilityDataState dataState}){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _feasibilityDateController(stateData: dataState),
            _verticalSpace(),
            _checkFeasibilityDropdown(stateData: dataState),
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
      label:AppString.lmcFeaDate,
      enabled: true,
      controller: stateData.feasibilityDateController,
      suffixIcon: Icon(Icons.calendar_today, color: AppColor.primer,),
      onChanged: (val){
        BlocProvider.of<FormFeasibilityBloc>(context).add(SelectFeasibilityDateEvent(context: context));
      },
    );
  }

  Widget _checkFeasibilityDropdown({required FormFeasibilityDataState stateData}) {
    return DropdownWidget<CheckFeasibleModel>(
      star: AppString.star,
      label:AppString.checkFeasibility,
      hint:AppString.checkFeasibility,
     dropdownValue: stateData.checkFeasibleValue == null ? null : stateData.checkFeasibleValue,
      items: stateData.listOfCheckFeasible,
      onChanged: (val) {
        BlocProvider.of<FormFeasibilityBloc>(context).add(SelectCheckFeasibilityValueEvent(checkFeasibility: val));
      },
    );
  }

  Widget _button({required FormFeasibilityDataState dataState}) {
    return dataState.isBtnLoader == false
        ? ButtonWidget(
        text: AppString.checkFea,
        onPressed: () {
          BlocProvider.of<FormFeasibilityBloc>(context).add(SubmitFormFeasibilityEvent(context: context));
        })
        : DottedLoaderWidget();
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
