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
  List<FeasibilityData> listOfFeasibilityRow = [];
  List<FeasibilityData> listOfFilterFeasibilityRow = [];
  FeasibilityModel? feasibilityModel;
  ScrollController scrollController = ScrollController();
  TextEditingController bpNumberController = TextEditingController();

  _pageLoad(LMCFeasibilityPageLoadEvent event, emit) async {
    emit(LMCFeasibilityInitialState());
    isLoader = false;
    isLoadingMore = false;
    areaValue = null;
    pageNo = 1;
    listOfAllArea = [];
    listOfFeasibilityRow = [];
    scrollController = ScrollController();
    feasibilityModel = FeasibilityModel();
    await fetchAllArea(context: event.context);
    await fetchFeasibility(context: event.context, pageNumber: 1, bpNumber: bpNumberController.text.trim().toString(), areaId: areaValue == null ? "" : areaValue!.gid!);
    _eventCompleted();
  }

  _selectAreaValue(SelectAreaValueEvent event, emit) async {
    areaValue = event.allAreaValue;
    await fetchFeasibility(context: event.context, pageNumber: 1, bpNumber: bpNumberController.text.trim().toString(), areaId: event.allAreaValue.gid.toString());
    _eventCompleted();
  }

  _searchBpNumber(SearchBpNumberEvent event, emit) async {
    bpNumberController.text = event.searchBpNumber;
    if (event.searchBpNumber.length > 1) {
      listOfFeasibilityRow = listOfFeasibilityRow.where((element) => element.bpNumber.toString().contains(event.searchBpNumber)).toList();
      print("listOfFeasibilityRow${listOfFeasibilityRow}");
      print("bpNumberController${bpNumberController.text}");
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

  fetchFeasibility({required BuildContext context, required int pageNumber, required String bpNumber, required String areaId}) async {
    var res = await LMCFeasibilityHelper.getFeasibilityApi(context: context, bpNumber: bpNumber, page: pageNumber.toString(), areaId: areaId);
    if (res != null) {
      feasibilityModel = res;
      if (feasibilityModel?.success != 400) {
        listOfFeasibilityRow = feasibilityModel!.data!;
        listOfFilterFeasibilityRow = listOfFeasibilityRow;
      }
    }
    _eventCompleted();
  }

  loadDataTable({required BuildContext context, emit}) {
    emit(LMCFeasibilityInitialState());
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        isLoadingMore = true;
        _eventCompleted();
        pageNo++;
        // await fetchFeasibility(context: context, pageNumber: pageNo, bpNumber: bpNumberController.text, areaId: '');
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
        listOfFeasibilityRow: listOfFeasibilityRow,
        feasibilityModel: feasibilityModel,
        bpNumberController: bpNumberController,
        scrollController: scrollController));
  }
}
