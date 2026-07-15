import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/Installation/LMCInstallation/domain/model/InstallationDoneModel.dart';

abstract class LMCInstallationState extends Equatable {}

class LMCInstallationInitialState extends LMCInstallationState {
  @override
  List<Object> get props => [];
}

class LMCInstallationPageLoadState extends LMCInstallationInitialState {
  @override
  List<Object> get props => [];
}

class LMCInstallationDataState extends LMCInstallationInitialState {
  final bool isLoader;
  final bool isAreaFilter;
  final bool isLoadingMore;
  final bool hasMoreData;
  final GetAllAreaModel allAreaValue;
  final int pageNo;
  final List<GetAllAreaModel> listOfAllArea;
  final List<InstallationDoneRows> listOfFilterInstallationRow;
  final InstallationDoneModel installationDoneModel;
  final ScrollController scrollController;
  final TextEditingController bpNumberController;

  LMCInstallationDataState({
    required this.isLoader,
    required this.isAreaFilter,
    required this.allAreaValue,
    this.isLoadingMore = false,
    this.hasMoreData = true,
    required this.pageNo,
    required this.listOfAllArea,
    required this.listOfFilterInstallationRow,
    required this.installationDoneModel,
    required this.scrollController,
    required this.bpNumberController,
  });

  LMCInstallationDataState copyWith({
    bool? isLoader,
    bool? isAreaFilter,
    bool? isLoadingMore,
    bool? hasMoreData,
    GetAllAreaModel? allAreaValue,
    int? pageNo,
    List<GetAllAreaModel>? listOfAllArea,
    List<InstallationDoneRows>? listOfFilterInstallationRow,
    InstallationDoneModel? installationDoneModel,
    ScrollController? scrollController,
    TextEditingController? bpNumberController,
  }) {
    return LMCInstallationDataState(
      isLoader: isLoader ?? this.isLoader,
      isAreaFilter: isAreaFilter ?? this.isAreaFilter,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      allAreaValue: allAreaValue ?? this.allAreaValue,
      pageNo: pageNo ?? this.pageNo,
      listOfAllArea: listOfAllArea ?? this.listOfAllArea,
      listOfFilterInstallationRow: listOfFilterInstallationRow ?? this.listOfFilterInstallationRow,
      installationDoneModel: installationDoneModel ?? this.installationDoneModel,
      scrollController: scrollController ?? this.scrollController,
      bpNumberController: bpNumberController ?? this.bpNumberController,
    );
  }

  @override
  List<Object> get props => [
    isLoader,
    isAreaFilter,
    allAreaValue,
    pageNo,
    isLoadingMore,
    hasMoreData,
    listOfAllArea,
    listOfFilterInstallationRow,
    installationDoneModel,
    scrollController,
    bpNumberController,
  ];
}
