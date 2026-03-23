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
  final bool isGiExtraPipe;
  final bool isCopperExtraPipe;
  final bool isTFAvail;
  final bool isManualPipe;
  final GetConstantModel checkFeasibleValue;
  final GetConstantModel lmcReasonValue;
  final List<GetConstantModel> listOfCheckFeasible;
  final List<GetConstantModel> listOfLMCReason;
  final List<MaterialItem> materialList;
  final List<MaterialItem> materialListCopper;
  final TextEditingController manualPipLengthCtrl;
  final TextEditingController extraGiPipeCtrl;
  final TextEditingController extraGiPriceCtrl;
  final TextEditingController extraCopperPipeCtrl;
  final TextEditingController extraCopperPriceCtrl;
  final TextEditingController extraTotalPriceCtrl;
  final TextEditingController extraTotalPipeCtrl;
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
    required this.isGiExtraPipe,
    required this.isCopperExtraPipe,
    required this.isTFAvail,
    required this.isManualPipe,
    required this.checkFeasibleValue,
    required this.lmcReasonValue,
    required this.listOfCheckFeasible,
    required this.listOfLMCReason,
    required this.materialList,
    required this.materialListCopper,
    required this.bpNumberController,
    required this.trNumberController,
    required this.proposedDateController,
    required this.feasibilityDateController,
    required this.assignedDateController,
    required this.reasonController,
    required this.remarksController,
    required this.followUpDateController,
    required this.manualPipLengthCtrl,
    required this.extraGiPipeCtrl,
    required this.extraGiPriceCtrl,
    required this.extraCopperPipeCtrl,
    required this.extraCopperPriceCtrl,
    required this.extraTotalPriceCtrl,
    required this.extraTotalPipeCtrl,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
    isLoader,
    isBtnLoader,
    isSelected,
    isGiExtraPipe,
    isCopperExtraPipe,
    isTFAvail,
    isManualPipe,
    checkFeasibleValue,
    lmcReasonValue,
    listOfCheckFeasible,
    listOfLMCReason,
    materialList,
    materialListCopper,

    bpNumberController,
    trNumberController,
    proposedDateController,
    feasibilityDateController,
    assignedDateController,
    reasonController,
    remarksController,
    followUpDateController,
    manualPipLengthCtrl,
    extraGiPipeCtrl,
    extraGiPriceCtrl,
   extraCopperPipeCtrl,
    extraCopperPriceCtrl,
    extraTotalPriceCtrl,
    extraTotalPipeCtrl,
  ];
}
