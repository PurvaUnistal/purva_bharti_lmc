import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/NGC/NGCTable/domain/model/LmcInstallationByNgcModel.dart';

abstract class NgcTableState extends Equatable {}

class NgcTableInitialState extends NgcTableState {
  @override
  List<Object> get props => [];
}

class NgcTablePageLoadState extends NgcTableState {
  @override
  List<Object> get props => [];
}

//ignore: must_be_immutable
class FetchNgcTableDataState extends NgcTableState {
  final bool isLoader;
  final int pageNo;
  final dynamic allAreaValue;
  final List<GetAllAreaModel> listOfAllArea;
  final List<InstallationByNgcData> listOfInstallationByNgc;
  final LMCInstallationByNgcModel? lmcInstallationByNgcModel;
  final  TextEditingController bpNumberController;

  FetchNgcTableDataState({
    required this.isLoader,
    required this.pageNo,
    required this.allAreaValue,
    required this.listOfAllArea,
    required this.listOfInstallationByNgc,
    required this.lmcInstallationByNgcModel,
    required this.bpNumberController,

  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    isLoader,
    pageNo,
    allAreaValue,
    listOfAllArea,
    listOfInstallationByNgc,
    lmcInstallationByNgcModel,
    bpNumberController,
  ];
}
