import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/res/app_config.dart';
import 'package:lmc/Utils/common_widgets/res/enums.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/helper/feasibility_helper.dart';
import 'package:lmc/features/Installation/LMCInstallation/domain/bloc/lmc_installation_event.dart';
import 'package:lmc/features/Installation/LMCInstallation/domain/bloc/lmc_installation_state.dart';
import 'package:lmc/features/Installation/LMCInstallation/domain/model/InstallationDoneModel.dart';
import 'package:lmc/features/Installation/LMCInstallation/helper/lmc_installation_helper.dart';

class LMCInstallationBloc extends Bloc<LMCInstallationEvent, LMCInstallationState> {
  LMCInstallationBloc() : super(LMCInstallationInitialState()) {
    on<LMCInstallationPageLoadEvent>(_pageLoad);
    on<LoadMoreInstallationEvent>(_onLoadMore);
    on<SelectAreaValueEvent>(_selectAreaValue);
    on<SearchBpNumberEvent>(_searchBpNumber);
  }

  bool isLoader = false;
  bool isAreaFilter = false;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  int pageNo = 1;
  GetAllAreaModel areaValue = GetAllAreaModel();
  List<GetAllAreaModel> listOfAllArea = [];
  List<InstallationDoneRows> listOfInstallationRow = [];
  List<InstallationDoneRows> listOfFilterInstallationRow = [];
  InstallationDoneModel installationDoneModel = InstallationDoneModel();
  ScrollController scrollController = ScrollController();
  TextEditingController bpNumberController = TextEditingController();

  var client = AppConfig.instanceInit()!.client == Client.agcl;

  _pageLoad(LMCInstallationPageLoadEvent event, emit) async {
    emit(LMCInstallationInitialState());
    isLoader = false;
    isAreaFilter = false;
    isLoadingMore = false;
    hasMoreData = true;
    areaValue = GetAllAreaModel();
    pageNo = 1;
    listOfAllArea = [];
    listOfInstallationRow = [];
    bpNumberController.text = "";
    scrollController = ScrollController();
    installationDoneModel = InstallationDoneModel();
    client = AppConfig.instanceInit()!.client == Client.agcl;
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

  /// Handles infinite-scroll pagination: fetches the next page and appends
  /// it to the existing rows instead of replacing them, so the table grows
  /// as the user scrolls (lazy loading) rather than loading everything up front.
  Future<void> _onLoadMore(
      LoadMoreInstallationEvent event,
      Emitter<LMCInstallationState> emit,
      ) async {
    // Guard against duplicate triggers while a page is already in flight,
    // or once the API has told us there's nothing left to fetch.
    if (isLoadingMore || !hasMoreData) return;

    isLoadingMore = true;
    _eventCompleted(emit);

    final nextPage = pageNo + 1;

    var res = await LMCInstallationHelper.getLMCInstallationApi(
      context: event.context,
      bpNumber: bpNumberController.text.trim(),
      page: nextPage.toString(),
      areaId: areaValue.gid?.toString() ?? "",
    );

    if (res != null && res.success != 400 && res.data != null && res.data!.isNotEmpty) {
      pageNo = nextPage;
      listOfInstallationRow = [...listOfInstallationRow, ...res.data!];
      listOfFilterInstallationRow = [...listOfFilterInstallationRow, ...res.data!];
      hasMoreData = true;
    } else {
      // Empty page (or 400) means we've reached the end of the list.
      hasMoreData = false;
    }

    isLoadingMore = false;
    _eventCompleted(emit);
  }

  _selectAreaValue(SelectAreaValueEvent event, emit) async {
    areaValue = event.allAreaValue;
    isAreaFilter = true;
    pageNo = 1;
    hasMoreData = true;
    _eventCompleted(emit);
    await fetchInstallation(
      context: event.context,
      pageNumber: 1,
      bpNumber: bpNumberController.text.trim().toString(),
      areaId: event.allAreaValue.gid.toString(),
    );
    isAreaFilter = false;
    _eventCompleted(emit);
  }

  _searchBpNumber(SearchBpNumberEvent event, emit) async {
    bpNumberController.text = event.searchBpNumber;
    if (event.searchBpNumber.length > 9) {
      listOfFilterInstallationRow = listOfInstallationRow
          .where((element) =>
      element.bpNumber.toString().contains(event.searchBpNumber) ||
          element.mobileNumber.toString().contains(event.searchBpNumber))
          .toList();
      _eventCompleted(emit);
    } else {
      listOfFilterInstallationRow = listOfInstallationRow;
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

  fetchInstallation({
    required BuildContext context,
    required int pageNumber,
    required String bpNumber,
    required String areaId,
  }) async {
    var res = await LMCInstallationHelper.getLMCInstallationApi(
      context: context,
      bpNumber: bpNumber,
      page: pageNumber.toString(),
      areaId: areaId,
    );
    if (res != null) {
      installationDoneModel = res;
      if (installationDoneModel.success != 400) {
        listOfInstallationRow = installationDoneModel.data!;
        listOfFilterInstallationRow = listOfInstallationRow;
        hasMoreData = listOfInstallationRow.isNotEmpty;
      } else {
        hasMoreData = false;
      }
    }
  }

  fetchLmcAllocationList({
    required BuildContext context,
    required int pageNumber,
    required String bpNumber,
    required String areaId,
  }) async {
    var res = await LMCInstallationHelper.getLmcAllocationList(
      context: context,
      bpNumber: bpNumber,
      page: pageNumber.toString(),
      areaId: areaId,
    );
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
      isLoader: isLoader,
      isAreaFilter: isAreaFilter,
      isLoadingMore: isLoadingMore,
      hasMoreData: hasMoreData,
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
