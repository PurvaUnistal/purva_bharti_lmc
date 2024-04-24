import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/helper/feasibility_helper.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/RFCSection/domain/bloc/rfc_section_event.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/RFCSection/domain/bloc/rfc_section_state.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/RFCSection/domain/model/RFCInstallationModel.dart';
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
  List<RFCInstallationRows> listOfRFCSectionRow = [];
  List<RFCInstallationRows> listOfFilterRFCSectionRow = [];
  RFCInstallationModel? rfcInstallationModel;
  ScrollController scrollController = ScrollController();
  TextEditingController bpNumberController = TextEditingController();

  _pageLoad(RFCSectionPageLoadEvent event, emit) async {
    emit(RFCSectionInitialState());
    isLoader = false;
    isLoadingMore = true;
    areaValue= null;
    listOfAllArea = [];
    listOfRFCSectionRow = [];
    scrollController = ScrollController();
    rfcInstallationModel = RFCInstallationModel();
    await fetchAllArea(context: event.context);
    await loadDataTable(context: event.context, emit: emit);
    await fetchFeasibility(context: event.context, pageNumber: 1, bpNumber: bpNumberController.text.trim().toString());
    _eventCompleted();
  }



  _selectAreaValue(SelectAreaValueEvent event, emit) {
    areaValue = event.allAreaValue;
    _eventCompleted();
  }

  _searchBpNumber(SearchBpNumberEvent event, emit) async {
    bpNumberController.text = event.searchBpNumber;
    if (event.searchBpNumber.length > 9) {
      listOfFilterRFCSectionRow = listOfRFCSectionRow
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
    if(res != null){
      listOfAllArea = res;
      return res;
    }
  }

  fetchFeasibility({required BuildContext context, required int pageNumber, required String bpNumber}) async {
    isLoadingMore = true;
    var res = await RFCSectionHelper.getRFCInstallationApi(context: context, bpNumber: bpNumber,page: pageNumber.toString(), areaId:"" );
    if(res != null){
      isLoadingMore = false;
      rfcInstallationModel = res;
      if(rfcInstallationModel!.data!.rows != null){
        listOfRFCSectionRow = rfcInstallationModel!.data!.rows!;
      }
    }
  }

  loadDataTable({required BuildContext context, emit}){
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        isLoadingMore = true;
        _eventCompleted();
        pageNo++;
        await fetchFeasibility(context: context, pageNumber: pageNo, bpNumber:  bpNumberController.text);
        _eventCompleted();
      }
    });
  }

  _eventCompleted() {
    emit(RFCSectionDataState(
        isLoader: isLoader,
        isLoadingMore: isLoadingMore,
        allAreaValue: areaValue,
        listOfAllArea: listOfAllArea,
        listOfRFCSectionRow: listOfRFCSectionRow,
        rfcInstallationModel: rfcInstallationModel,
        scrollController: scrollController
    ));
  }
}