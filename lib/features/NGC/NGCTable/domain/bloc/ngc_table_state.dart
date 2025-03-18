import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/NGC/NGCTable/domain/model/LmcInstallationByNgcModel.dart';

abstract class NgcTableState extends Equatable {}

class NgcTableInitialState extends NgcTableState {
  @override
  List<Object> get props => [];
}

class NgcTablePageLoadState extends NgcTableInitialState {
  @override
  List<Object> get props => [];
}

class FetchNgcTableDataState extends NgcTableInitialState {
  final bool isLoader;
  final bool isAreaFilter;
  final int pageNo;
  final String schema;
  final String userName;
  final GetAllAreaModel allAreaValue;
  final List<GetAllAreaModel> listOfAllArea;
  final List<InstallationByNgcData> listOfFilterInstallationByNgc;
  final LMCInstallationByNgcModel lmcInstallationByNgcModel;
  final TextEditingController bpNumberController;

  FetchNgcTableDataState({
    required this.isLoader,
    required this.isAreaFilter,
    required this.schema,
    required this.userName,
    required this.pageNo,
    required this.allAreaValue,
    required this.listOfAllArea,
    required this.listOfFilterInstallationByNgc,
    required this.lmcInstallationByNgcModel,
    required this.bpNumberController,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        isLoader,
        isAreaFilter,
        schema,
        userName,
        pageNo,
        allAreaValue,
        listOfAllArea,
        listOfFilterInstallationByNgc,
        lmcInstallationByNgcModel,
        bpNumberController,
      ];
}
