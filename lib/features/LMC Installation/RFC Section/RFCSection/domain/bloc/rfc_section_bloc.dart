import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/FeasibilityModel.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/helper/feasibility_helper.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/RFCSection/domain/bloc/rfc_section_event.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/RFCSection/domain/bloc/rfc_section_state.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/RFCSection/helper/rfc_section_helper.dart';

class RFCSectionBloc extends Bloc<RFCSectionEvent, RFCSectionState>{
  RFCSectionBloc() : super(RFCSectionInitialState()){
    on<RFCSectionPageLoadEvent>(_pageLoad);
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
  ScrollController scrollController = ScrollController();

  _pageLoad(RFCSectionPageLoadEvent event, emit) async {
    emit(RFCSectionInitialState());
    isLoader = false;
    isLoadingMore = false;
    areaValue= null;
    listOfAllArea = [];
    listOfFeasibilityRow = [];
    scrollController = ScrollController();
    feasibilityModel = FeasibilityModel();
    await fetchAllArea(context: event.context);
    await loadDataTable(context: event.context, emit: emit);
    await fetchFeasibility(context: event.context,);
    _eventCompleted(emit);
  }



  _selectAreaValue(SelectAreaValueEvent event, emit) {
    areaValue = event.allAreaValue;
    _eventCompleted(emit);
  }

  _searchBpNumber(SearchBpNumberEvent event, emit) {
  }

  fetchAllArea({required BuildContext context}) async {
    var res = await LMCFeasibilityHelper.getAllAreaApi(context: context);
    if(res != null){
      listOfAllArea = res;
      return res;
    }
  }

  fetchFeasibility({required BuildContext context}) async {
    isLoadingMore = true;
    var res = await RFCSectionHelper.getLMCInstallationApi(context: context, bpNumber: "",page: pageNo.toString(), areaId:"" );
    if(res != null){
      isLoadingMore = false;
      feasibilityModel = res;
      if(feasibilityModel!.data!.rows != null){
        listOfFeasibilityRow = feasibilityModel!.data!.rows!;
      }
    }
  }

  loadDataTable({required BuildContext context, emit}){
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        pageNo++;
        await fetchFeasibility(context:context);
        // _eventCompleted(emit);
      }
    });
  }

  _eventCompleted(Emitter<RFCSectionState> emit) {
    emit(RFCSectionDataState(
        isLoader: isLoader,
        isLoadingMore: isLoadingMore,
        allAreaValue: areaValue,
        listOfAllArea: listOfAllArea,
        listOfFeasibilityRow: listOfFeasibilityRow,
        feasibilityModel: feasibilityModel,
        scrollController: scrollController
    ));
  }
}