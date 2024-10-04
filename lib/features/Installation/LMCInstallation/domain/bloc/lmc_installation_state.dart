import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:new_lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:new_lmc/features/Installation/LMCInstallation/domain/model/InstallationDoneModel.dart';

abstract class LMCInstallationState extends Equatable {}

class LMCInstallationInitialState extends LMCInstallationState {
  @override
  List<Object> get props => [];
}

class LMCInstallationPageLoadState extends LMCInstallationState {
  @override
  List<Object> get props => [];
}

//ignore: must_be_immutable
class LMCInstallationDataState extends LMCInstallationState {
  String schema;
  String userName;
  final bool isLoader;
  final bool isAreaFilter;
  final dynamic allAreaValue;
  final int pageNo;
  final List<GetAllAreaModel> listOfAllArea;
  List<InstallationDoneRows> listOfFilterInstallationRow;
  InstallationDoneModel? installationDoneModel;
  final ScrollController scrollController;
  final TextEditingController bpNumberController;

  LMCInstallationDataState({
    required this.schema,
    required this.userName,
    required this.isLoader,
    required this.isAreaFilter,
    required this.allAreaValue,
    required this.pageNo,
    required this.listOfAllArea,
    required this.listOfFilterInstallationRow,
    required this.installationDoneModel,
    required this.scrollController,
    required this.bpNumberController,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        schema,
        userName,
        isLoader,
        isAreaFilter,
        allAreaValue,
        pageNo,
        listOfAllArea,
        listOfFilterInstallationRow,
        installationDoneModel,
        scrollController,
        bpNumberController,
      ];
}
