import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/FeasibilityModel.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';

abstract class MeterInstallationState extends Equatable{}

class MeterInstallationInitialState extends MeterInstallationState {
  @override
  List<Object> get props => [];
}

class MeterInstallationPageLoadState extends MeterInstallationState {
  @override
  List<Object> get props => [];
}

class MeterInstallationDataState extends MeterInstallationState{
  final bool isLoader;
  final bool isLoadingMore;
  final dynamic allAreaValue;
  final List<GetAllAreaModel> listOfAllArea;
  List<FeasibilityRowsList> listOfFeasibilityRow;
  FeasibilityModel? feasibilityModel;
  final ScrollController scrollController;

  MeterInstallationDataState({
    required this.isLoader,
    required this.isLoadingMore,
    required this.allAreaValue,
    required this.listOfAllArea,
    required this.listOfFeasibilityRow,
    required this.feasibilityModel,
    required this.scrollController,

  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    isLoader,
    isLoadingMore,
    allAreaValue,
    listOfAllArea,
    listOfFeasibilityRow,
    feasibilityModel,
    scrollController,
  ];
}