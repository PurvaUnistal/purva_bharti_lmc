import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/bloc/lmc_feasibility_event.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/bloc/lmc_feasibility_state.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/FeasibilityModel.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/helper/feasibility_helper.dart';

class LMCFeasibilityBloc extends Bloc<LMCFeasibilityEvent, LMCFeasibilityState> {
  LMCFeasibilityBloc() : super(LMCFeasibilityInitialState()) {
    on<LMCFeasibilityPageLoadEvent>(_pageLoad);
    on<SelectAreaValueEvent>(_selectAreaValue);
    on<SearchBpNumberEvent>(_searchBpNumber);
  }

  bool isLoader = false;
  bool isLoadingMore = false;
  int pageNo = 1;
  GetAllAreaModel? areaValue;
  List<GetAllAreaModel> listOfAllArea = [];
  List<FeasibilityRowsList> listOfFeasibilityRow = [];
  FeasibilityModel? feasibilityModel;
  FeasibilityRowsList? feasibilityRowsModel;
  ScrollController scrollController = ScrollController();

  _pageLoad(LMCFeasibilityPageLoadEvent event, emit) async {
    emit(LMCFeasibilityInitialState());
    isLoader = false;
    isLoadingMore = true;
    areaValue = null;
    listOfAllArea = [];
    listOfFeasibilityRow = [];
    scrollController = ScrollController();
    feasibilityModel = FeasibilityModel();
    feasibilityRowsModel = FeasibilityRowsList();
    _eventCompleted();
    await fetchAllArea(context: event.context);
    await loadDataTable(context: event.context);
    await fetchFeasibility(context: event.context, pageNumber: 1);
    isLoadingMore = false;
    _eventCompleted();
  }

  _selectAreaValue(SelectAreaValueEvent event, emit) {
    areaValue = event.allAreaValue;
    _eventCompleted();
  }

  _searchBpNumber(SearchBpNumberEvent event, emit) {}

  fetchAllArea({required BuildContext context}) async {
    var res = await LMCFeasibilityHelper.getAllAreaApi(context: context);
    if (res != null) {
      listOfAllArea = res;
      return res;
    }
  }

  fetchFeasibility({required BuildContext context, required int pageNumber}) async {
    isLoadingMore = true;
    var res = await LMCFeasibilityHelper.getFeasibilityApi(context: context, bpNumber: "", page: pageNumber.toString(), areaId: "");
    if (res != null) {
      isLoadingMore = false;
      feasibilityModel = res;
      if (feasibilityModel!.data!.rows != null) {
        listOfFeasibilityRow = feasibilityModel!.data!.rows!;
      }
    }
  }

  loadDataTable({required BuildContext context}) {
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        isLoadingMore = true;
        _eventCompleted();
        pageNo++;
        await fetchFeasibility(context: context, pageNumber: pageNo);
        _eventCompleted();
      }
    });
  }

  _eventCompleted() {
    emit(LMCFeasibilityDataState(
        isLoader: isLoader,
        isLoadingMore: isLoadingMore,
        allAreaValue: areaValue,
        listOfAllArea: listOfAllArea,
        feasibilityRowsModel: feasibilityRowsModel,
        listOfFeasibilityRow: listOfFeasibilityRow,
        feasibilityModel: feasibilityModel,
        scrollController: scrollController));
  }
}
