import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/helper/feasibility_helper.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/MeterInstallation/domain/model/InstallationDoneModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/MeterInstallation/domain/bloc/meter_installation_event.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/MeterInstallation/domain/bloc/meter_installation_state.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/MeterInstallation/helper/meter_installation_helper.dart';

class MeterInstallationBloc extends Bloc<MeterInstallationEvent, MeterInstallationState> {
  MeterInstallationBloc() : super(MeterInstallationInitialState()) {
    on<MeterInstallationPageLoadEvent>(_pageLoad);
    on<SelectAreaValueEvent>(_selectAreaValue);
    on<SearchBpNumberEvent>(_searchBpNumber);
  }

  bool isLoader = false;
  bool isLoadingMore = false;
  int pageNo = 1;
  GetAllAreaModel? areaValue;
  List<GetAllAreaModel> listOfAllArea = [];
  List<InstallationDoneRows> listOfInstallationRow = [];
  List<InstallationDoneRows> listOfFilterInstallationRow = [];
  InstallationDoneModel? installationDoneModel;
  ScrollController scrollController = ScrollController();
  TextEditingController bpNumberController = TextEditingController();

  _pageLoad(MeterInstallationPageLoadEvent event, emit) async {
    emit(MeterInstallationInitialState());
    isLoader = false;
    isLoadingMore = true;
    areaValue = null;
    listOfAllArea = [];
    listOfInstallationRow = [];
    scrollController = ScrollController();
    installationDoneModel = InstallationDoneModel();
    await fetchAllArea(context: event.context);
    _eventCompleted();
    await loadDataTable(context: event.context, emit: emit);
    await fetchFeasibility(context: event.context,pageNumber: 1, bpNumber: bpNumberController.text.trim().toString());
    _eventCompleted();
  }

  _selectAreaValue(SelectAreaValueEvent event, emit) {
    areaValue = event.allAreaValue;
    _eventCompleted();
  }

  _searchBpNumber(SearchBpNumberEvent event, emit) async {
    bpNumberController.text = event.searchBpNumber;
    if (event.searchBpNumber.length > 9) {
      listOfFilterInstallationRow = listOfInstallationRow
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

  fetchFeasibility({required BuildContext context,required int pageNumber,required String bpNumber}) async {
    isLoadingMore = true;
    var res = await MeterInstallationHelper.getLMCInstallationApi(context: context, bpNumber: bpNumber, page: pageNumber.toString(), areaId: "");
    if (res != null) {
      isLoadingMore = false;
      installationDoneModel = res;
      if (installationDoneModel!.data!.rows != null) {
        listOfInstallationRow = installationDoneModel!.data!.rows!;
        listOfFilterInstallationRow = listOfInstallationRow;
      }
    }
  }

  loadDataTable({required BuildContext context, emit}) {
    scrollController.addListener(() async {
      isLoadingMore = true;
      _eventCompleted();
      pageNo++;
      await fetchFeasibility(context: context, pageNumber: pageNo, bpNumber:  bpNumberController.text);
      _eventCompleted();
    });
  }

  _eventCompleted() {
    emit(MeterInstallationDataState(
        isLoader: isLoader,
        isLoadingMore: isLoadingMore,
        allAreaValue: areaValue,
        listOfAllArea: listOfAllArea,
        installationDoneModel: installationDoneModel,
        listOfInstallationRow: listOfInstallationRow,
        scrollController: scrollController));
  }
}
