import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/MaterialItem.dart';

abstract class FormFeasibilityState extends Equatable {}

class FormFeasibilityInitialState extends FormFeasibilityState {
  @override
  List<Object> get props => [];
}

class FormFeasibilityPageLoadState extends FormFeasibilityInitialState {
  @override
  List<Object> get props => [];
}

class FormFeasibilityDataState extends FormFeasibilityInitialState {
  final bool isLoader;
  final bool isBtnLoader;
  final bool isSelected;
  final bool isExtraPipe;
  final GetConstantModel checkFeasibleValue;
  final GetConstantModel lmcReasonValue;
  final List<GetConstantModel> listOfCheckFeasible;
  final List<GetConstantModel> listOfLMCReason;
  final List<GetConstantModel> listOfAllRFC;
  final List<MaterialItem> materialList;
  final TextEditingController extraPipeController;
  final TextEditingController extraPriceController;
  final TextEditingController bpNumberController;
  final TextEditingController trNumberController;
  final TextEditingController proposedDateController;
  final TextEditingController feasibilityDateController;
  final TextEditingController assignedDateController;
  final TextEditingController reasonController;
  final TextEditingController remarksController;
  final TextEditingController followUpDateController;

  FormFeasibilityDataState({
    required this.isLoader,
    required this.isBtnLoader,
    required this.isSelected,
    required this.isExtraPipe,
    required this.checkFeasibleValue,
    required this.lmcReasonValue,
    required this.listOfCheckFeasible,
    required this.listOfLMCReason,
    required this.materialList,
    required this.listOfAllRFC,
    required this.bpNumberController,
    required this.trNumberController,
    required this.proposedDateController,
    required this.feasibilityDateController,
    required this.assignedDateController,
    required this.reasonController,
    required this.remarksController,
    required this.followUpDateController,
    required this.extraPipeController,
    required this.extraPriceController,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        isLoader,
        isBtnLoader,
        isSelected,
        isExtraPipe,
        checkFeasibleValue,
        lmcReasonValue,
        listOfCheckFeasible,
        listOfLMCReason,
        materialList,
        listOfAllRFC,
        bpNumberController,
        trNumberController,
        proposedDateController,
        feasibilityDateController,
        assignedDateController,
        reasonController,
        remarksController,
        followUpDateController,
        extraPipeController,
        extraPriceController,
      ];
}
