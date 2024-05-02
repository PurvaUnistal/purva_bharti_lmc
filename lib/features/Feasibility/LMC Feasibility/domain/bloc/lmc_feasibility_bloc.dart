import 'package:flutter/cupertino.dart';
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
  List<FeasibilityRowsList> listOfFilterFeasibilityRow = [];
  FeasibilityModel? feasibilityModel;
  FeasibilityRowsList? feasibilityRowsModel;
  ScrollController scrollController = ScrollController();
  TextEditingController bpNumberController = TextEditingController();

  _pageLoad(LMCFeasibilityPageLoadEvent event, emit) async {
    emit(LMCFeasibilityInitialState());
    isLoader = false;
    isLoadingMore = true;
    areaValue = null;
    pageNo = 1;
    listOfAllArea = [];
    listOfFeasibilityRow = [];
    scrollController = ScrollController();
    feasibilityModel = FeasibilityModel();
    feasibilityRowsModel = FeasibilityRowsList();
    _eventCompleted();
    await fetchAllArea(context: event.context);
    await loadDataTable(context: event.context, emit:emit);
    await fetchFeasibility(context: event.context, pageNumber: 1, bpNumber: bpNumberController.text.trim().toString());
    isLoadingMore = false;
    _eventCompleted();
  }

  _selectAreaValue(SelectAreaValueEvent event, emit) {
    areaValue = event.allAreaValue;
    _eventCompleted();
  }

  _searchBpNumber(SearchBpNumberEvent event, emit) async {
    bpNumberController.text = event.searchBpNumber;
    if (event.searchBpNumber.length > 1) {
      listOfFilterFeasibilityRow = listOfFeasibilityRow
          .where(
              (element) => element.bpNumber.toString() == bpNumberController.text)
          .toList();
      await fetchFeasibility(
      context: event.context, bpNumber: event.searchBpNumber, pageNumber: pageNo);
      _eventCompleted();
    }
  }

  fetchAllArea({required BuildContext context}) async {
    var res = await LMCFeasibilityHelper.getAllAreaApi(context: context);
    if (res != null) {
      listOfAllArea = res;
      return res;
    }
  }

  fetchFeasibility({required BuildContext context, required int pageNumber, required String bpNumber}) async {
    isLoadingMore = true;
    var res = await LMCFeasibilityHelper.getFeasibilityApi(context: context, bpNumber: bpNumber, page: pageNumber.toString(), areaId: "");
    if (res != null) {
      isLoadingMore = false;
      feasibilityModel = res;
      if (feasibilityModel!.data!.rows != null) {
        listOfFeasibilityRow = feasibilityModel!.data!.rows!;
        listOfFilterFeasibilityRow = listOfFeasibilityRow;
      }
    }else{
      isLoadingMore = false;
    }
  }

  loadDataTable({required BuildContext context, emit}) {
    emit(LMCFeasibilityInitialState());
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        isLoadingMore = true;
        _eventCompleted();
        pageNo++;
        await fetchFeasibility(context: context, pageNumber: pageNo, bpNumber: bpNumberController.text);
        _eventCompleted();
      }
    });
  }

  _eventCompleted() {
    emit(LMCFeasibilityDataState(
        isLoader: isLoader,
        isLoadingMore: isLoadingMore,
        allAreaValue: areaValue,
        pageNo: pageNo,
        listOfAllArea: listOfAllArea,
        feasibilityRowsModel: feasibilityRowsModel,
        listOfFeasibilityRow: listOfFeasibilityRow,
        feasibilityModel: feasibilityModel,
        scrollController: scrollController));
  }
}
