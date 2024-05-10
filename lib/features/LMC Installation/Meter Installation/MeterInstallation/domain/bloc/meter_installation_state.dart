import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/MeterInstallation/domain/model/InstallationDoneModel.dart';

abstract class MeterInstallationState extends Equatable {}

class MeterInstallationInitialState extends MeterInstallationState {
  @override
  List<Object> get props => [];
}

class MeterInstallationPageLoadState extends MeterInstallationState {
  @override
  List<Object> get props => [];
}

class MeterInstallationDataState extends MeterInstallationState {
  final bool isLoader;
  final bool isLoadingMore;
  final dynamic allAreaValue;
  final int pageNo;
  final List<GetAllAreaModel> listOfAllArea;
  List<InstallationDoneRows> listOfInstallationRow;
  InstallationDoneModel? installationDoneModel;
  final ScrollController scrollController;
  final TextEditingController bpNumberController;

  MeterInstallationDataState({
    required this.isLoader,
    required this.isLoadingMore,
    required this.allAreaValue,
    required this.pageNo,
    required this.listOfAllArea,
    required this.listOfInstallationRow,
    required this.installationDoneModel,
    required this.scrollController,
    required this.bpNumberController,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    isLoader,
    isLoadingMore,
    allAreaValue,
    pageNo,
    listOfAllArea,
    listOfInstallationRow,
    installationDoneModel,
    scrollController,
    bpNumberController,
  ];
}
