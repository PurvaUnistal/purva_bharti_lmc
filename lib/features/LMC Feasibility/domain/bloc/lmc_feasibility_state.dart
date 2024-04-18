import 'package:equatable/equatable.dart';
import 'package:lmc/features/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';

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
  final dynamic allAreaValue;
  final List<GetAllAreaModel> listOfAllArea;
  /*final List<RowsData> listOfRowData;
  final RowsData rowsData;
  final List<RowsData> filterRowDataList;
  final LmcInstallationByNgcModel lmcInstallationByNgcModel;*/

  LMCFeasibilityDataState({
    required this.isLoader,
    required this.allAreaValue,
    required this.listOfAllArea,
  //  required this.listOfRowData,

});

  @override
  // TODO: implement props
  List<Object?> get props => [
    isLoader,
    allAreaValue,
    listOfAllArea,
  ];
}