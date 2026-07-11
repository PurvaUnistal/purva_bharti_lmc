import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/bloc/lmc_feasibility_event.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/bloc/lmc_feasibility_state.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/FeasibilityModel.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/helper/feasibility_helper.dart';
import 'package:lmc/features/NGC/NGCTable/helper/ngc_table_helper.dart';

class LMCFeasibilityBloc extends Bloc<LMCFeasibilityEvent, LMCFeasibilityState> {
  LMCFeasibilityBloc() : super(LMCFeasibilityInitialState()) {
    on<LMCFeasibilityPageLoadEvent>(_pageLoad);
    on<SelectAreaValueEvent>(_selectAreaValue);
    on<SearchBpNumberEvent>(_searchBpNumber);
  }

  bool isLoader = false;
  bool isAreaFilter = false;
  int pageNo = 1;
  GetAllAreaModel areaValue = GetAllAreaModel();
  List<GetAllAreaModel> listOfAllArea = [];
  List<FeasibilityData> listOfFeasibilityRow = [];
  List<FeasibilityData> listOfFilterFeasibilityRow = [];
  FeasibilityModel feasibilityModel = FeasibilityModel();
  ScrollController scrollController = ScrollController();
  TextEditingController bpNumberController = TextEditingController();

  _pageLoad(LMCFeasibilityPageLoadEvent event, emit) async {
    emit(LMCFeasibilityPageLoadState());
    isLoader = false;
    isAreaFilter = false;
    areaValue = GetAllAreaModel();
    pageNo = 1;
    listOfAllArea = [];
    listOfFeasibilityRow = [];
    bpNumberController.text = "";
    scrollController = ScrollController();
    feasibilityModel = FeasibilityModel();
    await Future.wait(<Future>[
      fetchAllArea(context: event.context),
      fetchFeasibility(
        context: event.context,
        pageNumber: 1,
        bpNumber: bpNumberController.text.trim(),
        areaId: areaValue.gid ?? "",
      ),
    ]);_eventCompleted(emit);
  }

  _selectAreaValue(SelectAreaValueEvent event, emit) async {
    areaValue = event.allAreaValue;
    isAreaFilter = true;
    _eventCompleted(emit);
    await fetchFeasibility(context: event.context, pageNumber: 1, bpNumber: bpNumberController.text.trim().toString(), areaId: event.allAreaValue.gid.toString());
    isAreaFilter = false;
    _eventCompleted(emit);
  }

  _searchBpNumber(SearchBpNumberEvent event, emit) async {
    bpNumberController.text = event.searchBpNumber;
    final query = event.searchBpNumber.trim();
    if(query.isNotEmpty){
      listOfFilterFeasibilityRow = listOfFeasibilityRow
          .where((element) =>
      element.bpNumber.toString().contains(query) ||
          element.mobileNumber.toString().contains(query))
          .toList();
    } else {
      listOfFilterFeasibilityRow = await listOfFeasibilityRow;
    }
    _eventCompleted(emit);
  }

  fetchAllArea({required BuildContext context}) async {
    var res = await NgcTableHelper.getAllAreaApi(context: context);
    if (res != null) {
      listOfAllArea = res;
      listOfAllArea.sort((a, b) => a.areaName!.compareTo(b.areaName!));
      return res;
    }
  }

  fetchFeasibility({required BuildContext context, required int pageNumber, required String bpNumber, required String areaId}) async {
    var res = await LMCFeasibilityHelper.getFeasibilityApi(context: context, bpNumber: bpNumber, page: pageNumber.toString(), areaId: areaId);
    if (res != null) {
      feasibilityModel = res;
      if (feasibilityModel.success != 400) {
        listOfFeasibilityRow = feasibilityModel.data!;
        listOfFilterFeasibilityRow = listOfFeasibilityRow;
      }
    }
  }

  loadDataTable({required BuildContext context, emit}) {
    emit(LMCFeasibilityInitialState());
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        pageNo++;
        _eventCompleted(emit);
      }
    });
  }

  _eventCompleted(Emitter<LMCFeasibilityState> emit) {
    emit(LMCFeasibilityDataState(
        isLoader: isLoader,
        isAreaFilter: isAreaFilter,
        allAreaValue: areaValue,
        pageNo: pageNo,
        listOfAllArea: listOfAllArea,
        listOfFilterFeasibilityRow: listOfFilterFeasibilityRow,
        feasibilityModel: feasibilityModel,
        bpNumberController: bpNumberController,
        scrollController: scrollController));
  }
}
