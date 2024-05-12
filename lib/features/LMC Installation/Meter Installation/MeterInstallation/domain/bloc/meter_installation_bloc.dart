import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/helper/feasibility_helper.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/MeterInstallation/domain/bloc/meter_installation_event.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/MeterInstallation/domain/bloc/meter_installation_state.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/MeterInstallation/domain/model/InstallationDoneModel.dart';
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
    pageNo = 1;
    listOfAllArea = [];
    listOfInstallationRow = [];
    scrollController = ScrollController();
    installationDoneModel = InstallationDoneModel();
    await fetchAllArea(context: event.context);
    await fetchFeasibility(context: event.context, pageNumber: 1, bpNumber: bpNumberController.text.trim().toString(), areaId: "");
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
      listOfInstallationRow = listOfInstallationRow.where((element) => element.bpNumber.toString().contains(event.searchBpNumber)).toList();
      print("listOfFeasibilityRow${listOfInstallationRow}");
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
    isLoadingMore = true;
    var res = await MeterInstallationHelper.getLMCInstallationApi(context: context, bpNumber: bpNumber, page: pageNumber.toString(), areaId: areaId);
    if (res != null) {
      installationDoneModel = res;
      if (installationDoneModel?.success != 400) {
        listOfInstallationRow = installationDoneModel!.data!;
      }
    }
    _eventCompleted();
  }

  loadDataTable({required BuildContext context}) async {
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        isLoadingMore = true;
        _eventCompleted();
        pageNo++;
        if (pageNo == 1) {
        } else {
          //  await fetchFeasibility(context: context, pageNumber: pageNo, bpNumber: bpNumberController.text);
        }
        _eventCompleted();
      }
    });
  }

  _eventCompleted() {
    emit(MeterInstallationDataState(
      isLoader: isLoader,
      isLoadingMore: isLoadingMore,
      allAreaValue: areaValue,
      listOfAllArea: listOfAllArea,
      pageNo: pageNo,
      installationDoneModel: installationDoneModel,
      listOfInstallationRow: listOfInstallationRow,
      scrollController: scrollController,
      bpNumberController: bpNumberController,
    ));
  }
}
