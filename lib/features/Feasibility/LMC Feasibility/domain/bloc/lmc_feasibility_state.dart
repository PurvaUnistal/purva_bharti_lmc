import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/FeasibilityModel.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';

abstract class LMCFeasibilityState extends Equatable{}

class LMCFeasibilityInitialState extends LMCFeasibilityState {
  @override
  List<Object> get props => [];
}

class LMCFeasibilityPageLoadState extends LMCFeasibilityState {
  @override
  List<Object> get props => [];
}

class LMCFeasibilityDataState extends LMCFeasibilityState{
  final bool isLoader;
  final bool isLoadingMore;
  final dynamic allAreaValue;
  final int pageNo;
  final List<GetAllAreaModel> listOfAllArea;
  List<FeasibilityData> listOfFeasibilityRow;
  FeasibilityModel? feasibilityModel;
  TextEditingController bpNumberController;
  final ScrollController scrollController;

  LMCFeasibilityDataState({
    required this.isLoader,
    required this.isLoadingMore,
    required this.pageNo,
    required this.allAreaValue,
    required this.listOfAllArea,
    required this.listOfFeasibilityRow,
    required this.feasibilityModel,
    required this.bpNumberController,
    required this.scrollController,

});

  @override
  // TODO: implement props
  List<Object?> get props => [
    isLoader,
    isLoadingMore,
    allAreaValue,
    pageNo,
    listOfAllArea,
    listOfFeasibilityRow,
    feasibilityModel,
    bpNumberController,
    scrollController,
  ];
}