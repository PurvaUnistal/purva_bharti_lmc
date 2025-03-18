import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/FeasibilityModel.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';

abstract class LMCFeasibilityState extends Equatable {}

class LMCFeasibilityInitialState extends LMCFeasibilityState {
  @override
  List<Object> get props => [];
}

class LMCFeasibilityPageLoadState extends LMCFeasibilityInitialState {
  @override
  List<Object> get props => [];
}

class LMCFeasibilityDataState extends LMCFeasibilityInitialState {
  final bool isLoader;
  final bool isAreaFilter;
  final GetAllAreaModel allAreaValue;
  final int pageNo;
  final String schema;
  final String userName;
  final List<GetAllAreaModel> listOfAllArea;
  final List<FeasibilityData> listOfFilterFeasibilityRow;
  final FeasibilityModel feasibilityModel;
  final TextEditingController bpNumberController;
  final ScrollController scrollController;

  LMCFeasibilityDataState({
    required this.schema,
    required this.userName,
    required this.isLoader,
    required this.isAreaFilter,
    required this.pageNo,
    required this.allAreaValue,
    required this.listOfAllArea,
    required this.listOfFilterFeasibilityRow,
    required this.feasibilityModel,
    required this.bpNumberController,
    required this.scrollController,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        schema,
        userName,
        isAreaFilter,
        allAreaValue,
        pageNo,
        listOfAllArea,
        listOfFilterFeasibilityRow,
        feasibilityModel,
        bpNumberController,
        scrollController,
      ];
}
