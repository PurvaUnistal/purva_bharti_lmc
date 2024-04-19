import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/app_color.dart';
import 'package:lmc/Utils/common_widgets/app_string.dart';
import 'package:lmc/Utils/common_widgets/styles_widget.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/bloc/lmc_feasibility_bloc.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/bloc/lmc_feasibility_event.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/bloc/lmc_feasibility_state.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/FeasibilityModel.dart';

class PreviewPopWidget extends StatefulWidget {
  final List<FeasibilityRowsList> listOfFeasibilityRow;
  const PreviewPopWidget({super.key, required this.listOfFeasibilityRow});

  @override
  State<PreviewPopWidget> createState() => _PreviewPopWidgetState();
}

class _PreviewPopWidgetState extends State<PreviewPopWidget> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LMCFeasibilityBloc>(context).add(LMCFeasibilityPageLoadEvent(context: context));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  BlocBuilder<LMCFeasibilityBloc, LMCFeasibilityState>(
        builder: (context, state) {
          if (state is LMCFeasibilityDataState) {
            return _itemBuilder(dataState: state, context: context);
          } else {
            return SpinLoader();
          }
        },
      ),
    );
  }

  _itemBuilder({required LMCFeasibilityDataState dataState, required BuildContext context}){
    return Column(
      children: [
        _header(context: context),
        Divider(color: AppColor.primer1),
        _rowItem(textName: AppString.custReg,textValue: dataState.listOfFeasibilityRow[0].customerRegistrationNo!),
        _rowItem(textName: AppString.lmcProposed,textValue: dataState.listOfFeasibilityRow[0].proposedDate),
        _rowItem(textName: AppString.lmcFeaDate,textValue: dataState.listOfFeasibilityRow[0].feasibilityVisitDate),
      ],
    );
  }

  Widget _header({required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        "LMC Feasibility",style: Styles.stars,
      ),
    );
  }

  Widget _rowItem({required String textName, required String textValue}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text("${textName} :",style: Styles.labels,)),
              Flexible(
                  child: Text(
                    textValue,
                  )),
            ],
          ),
        ),
        Divider(
          color: AppColor.primer1,
        )
      ],
    );
  }
}
