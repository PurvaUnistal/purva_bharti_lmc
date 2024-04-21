import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';

abstract class FormFeasibilityState extends Equatable {}

class FormFeasibilityInitialState extends FormFeasibilityState {
  @override
  List<Object> get props => [];
}

class FormFeasibilityPageLoadState extends FormFeasibilityState {
  @override
  List<Object> get props => [];
}

class FormFeasibilityDataState extends FormFeasibilityState {
  final bool isLoader;
  final bool isBtnLoader;
  final GetConstantModel? checkFeasibleValue;
  final GetConstantModel? lmcReasonValue;
  final List<GetConstantModel> listOfCheckFeasible;
  final List<GetConstantModel> listOfLMCReason;
  final TextEditingController bpNumberController;
  final TextEditingController proposedDateController;
  final TextEditingController feasibilityDateController;

  FormFeasibilityDataState({
    required this.isLoader,
    required this.isBtnLoader,
    required this.checkFeasibleValue,
    required this.lmcReasonValue,
    required this.listOfCheckFeasible,
    required this.listOfLMCReason,
    required this.bpNumberController,
    required this.proposedDateController,
    required this.feasibilityDateController,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        isLoader,
        isBtnLoader,
        checkFeasibleValue,
        lmcReasonValue,
        listOfCheckFeasible,
        listOfLMCReason,
        bpNumberController,
        proposedDateController,
        feasibilityDateController,
      ];
}
