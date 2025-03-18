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
  bool isAreaFilter = false;
  int pageNo = 1;
  GetAllAreaModel areaValue = GetAllAreaModel();
  List<GetAllAreaModel> listOfAllArea = [];
  List<InstallationDoneRows> listOfInstallationRow = [];
  List<InstallationDoneRows> listOfFilterInstallationRow = [];
  InstallationDoneModel installationDoneModel = InstallationDoneModel();
  ScrollController scrollController = ScrollController();
  TextEditingController bpNumberController = TextEditingController();

  _pageLoad(LMCInstallationPageLoadEvent event, emit) async {
    emit(LMCInstallationInitialState());
    isLoader = false;
    isAreaFilter = false;
    areaValue = GetAllAreaModel();
    pageNo = 1;
    listOfAllArea = [];
    listOfInstallationRow = [];
    bpNumberController.text = "";
    scrollController = ScrollController();
    installationDoneModel = InstallationDoneModel();
    schema = await SharedPref.getString(key: PrefsValue.schema,);
    userName = await SharedPref.getString(key: PrefsValue.userName,);
    await Future.wait(<Future>[
      fetchAllArea(context: event.context),
      fetchInstallation(
        context: event.context,
        pageNumber: 1,
        bpNumber: bpNumberController.text.trim(),
        areaId: "",
      ),
    ]);
    _eventCompleted(emit);
  }

  _selectAreaValue(SelectAreaValueEvent event, emit) async {
    areaValue = event.allAreaValue;
    isAreaFilter = true;
    _eventCompleted(emit);
    await fetchInstallation(context: event.context, pageNumber: 1, bpNumber: bpNumberController.text.trim().toString(), areaId: event.allAreaValue.gid.toString());
    isAreaFilter = false;
    _eventCompleted(emit);
  }

  _searchBpNumber(SearchBpNumberEvent event, emit) async {
    bpNumberController.text = event.searchBpNumber;
    if (event.searchBpNumber.length > 9) {
      listOfFilterInstallationRow = listOfFilterInstallationRow.where((element) => element.bpNumber.toString().contains(event.searchBpNumber) || element.mobileNumber.toString().contains(event.searchBpNumber)).toList();
      _eventCompleted(emit);
    } else {
      listOfFilterInstallationRow = await listOfInstallationRow;
    }
    _eventCompleted(emit);
  }

  fetchAllArea({required BuildContext context}) async {
    var res = await LMCFeasibilityHelper.getAllAreaApi(context: context);
    if (res != null) {
      listOfAllArea = res;
      listOfAllArea.sort((a, b) => a.areaName!.compareTo(b.areaName!));
      return res;
    }
  }

  fetchInstallation({required BuildContext context, required int pageNumber, required String bpNumber, required String areaId}) async {
    var res = await LMCInstallationHelper.getLMCInstallationApi(context: context, bpNumber: bpNumber, page: pageNumber.toString(), areaId: areaId);
    if (res != null) {
      installationDoneModel = res;
      if (installationDoneModel.success != 400) {
        listOfInstallationRow = installationDoneModel.data!;
        listOfFilterInstallationRow = listOfInstallationRow;
      }
    }
  }

  _eventCompleted(emit) {
    emit(LMCInstallationDataState(
      userName: userName,
      schema: schema,
      isLoader: isLoader,
      isAreaFilter: isAreaFilter,
      allAreaValue: areaValue,
      listOfAllArea: listOfAllArea,
      pageNo: pageNo,
      installationDoneModel: installationDoneModel,
      listOfFilterInstallationRow: listOfFilterInstallationRow,
      scrollController: scrollController,
      bpNumberController: bpNumberController,
    ));
  }
}
