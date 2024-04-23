import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/FeasibilityModel.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/RFCSection/domain/model/RFCInstallationModel.dart';

abstract class RFCSectionState extends Equatable{}

class RFCSectionInitialState extends RFCSectionState {
  @override
  List<Object> get props => [];
}

class RFCSectionPageLoadState extends RFCSectionState {
  @override
  List<Object> get props => [];
}

class RFCSectionDataState extends RFCSectionState{
  final bool isLoader;
  final bool isLoadingMore;
  final dynamic allAreaValue;
  final List<GetAllAreaModel> listOfAllArea;
  List<RFCInstallationRows> listOfRFCSectionRow;
  RFCInstallationModel? rfcInstallationModel;
  final ScrollController scrollController;

  RFCSectionDataState({
    required this.isLoader,
    required this.isLoadingMore,
    required this.allAreaValue,
    required this.listOfAllArea,
    required this.listOfRFCSectionRow,
    required this.rfcInstallationModel,
    required this.scrollController,

  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    isLoader,
    isLoadingMore,
    allAreaValue,
    listOfAllArea,
    listOfRFCSectionRow,
    rfcInstallationModel,
    scrollController,
  ];
}