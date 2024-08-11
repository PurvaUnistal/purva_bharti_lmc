import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/helper/feasibility_helper.dart';
import 'package:lmc/features/Installation/LMCInstallation/domain/bloc/lmc_installation_event.dart';
import 'package:lmc/features/Installation/LMCInstallation/domain/bloc/lmc_installation_state.dart';
import 'package:lmc/features/Installation/LMCInstallation/domain/model/InstallationDoneModel.dart';
import 'package:lmc/features/Installation/LMCInstallation/helper/lmc_installation_helper.dart';

class LMCInstallationBloc extends Bloc<LMCInstallationEvent, LMCInstallationState> {
  LMCInstallationBloc() : super(LMCInstallationInitialState()) {
    on<LMCInstallationPageLoadEvent>(_pageLoad);
    on<SelectAreaValueEvent>(_selectAreaValue);
    on<SearchBpNumberEvent>(_searchBpNumber);
  }

  String schema = "";
  String userName = "";
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

  _pageLoad(LMCInstallationPageLoadEvent event, emit) async {
    emit(LMCInstallationInitialState());
    isLoader = false;
    isLoadingMore = true;
    areaValue = null;
    pageNo = 1;
    listOfAllArea = [];
    listOfInstallationRow = [];
    scrollController = ScrollController();
    installationDoneModel = InstallationDoneModel();
    schema = await SharedPref.getString(
      key: PrefsValue.schema,
    );
    userName = await SharedPref.getString(
      key: PrefsValue.userName,
    );
    await fetchAllArea(context: event.context);
    await fetchFeasibility(context: event.context, pageNumber: 1, bpNumber: bpNumberController.text.trim().toString(), areaId: "");
    _eventCompleted(emit);
  }

  _selectAreaValue(SelectAreaValueEvent event, emit) async {
    areaValue = event.allAreaValue;
    await fetchFeasibility(context: event.context, pageNumber: 1, bpNumber: bpNumberController.text.trim().toString(), areaId: event.allAreaValue.gid.toString());
    _eventCompleted(emit);
  }

  _searchBpNumber(SearchBpNumberEvent event, emit) async {
    bpNumberController.text = event.searchBpNumber;
    if (event.searchBpNumber.length > 1) {
      listOfInstallationRow = listOfInstallationRow.where((element) => element.bpNumber.toString().contains(event.searchBpNumber)).toList();
      print("listOfFeasibilityRow${listOfInstallationRow}");
      print("bpNumberController${bpNumberController.text}");
      _eventCompleted(emit);
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
    var res = await LMCInstallationHelper.getLMCInstallationApi(context: context, bpNumber: bpNumber, page: pageNumber.toString(), areaId: areaId);
    if (res != null) {
      installationDoneModel = res;
      if (installationDoneModel?.success != 400) {
        listOfInstallationRow = installationDoneModel!.data!;
      }
    }
  }

  loadDataTable({required BuildContext context, emit}) async {
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        isLoadingMore = true;
        _eventCompleted(emit);
        pageNo++;
        if (pageNo == 1) {
        } else {
          //  await fetchFeasibility(context: context, pageNumber: pageNo, bpNumber: bpNumberController.text);
        }
        _eventCompleted(emit);
      }
    });
  }

  _eventCompleted(emit) {
    emit(LMCInstallationDataState(
      userName: userName,
      schema: schema,
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
