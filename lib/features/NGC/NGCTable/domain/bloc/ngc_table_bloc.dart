import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/NGC/NGCTable/domain/bloc/ngc_table_event.dart';
import 'package:lmc/features/NGC/NGCTable/domain/bloc/ngc_table_state.dart';
import 'package:lmc/features/NGC/NGCTable/domain/model/LmcInstallationByNgcModel.dart';
import 'package:lmc/features/NGC/NGCTable/helper/ngc_table_helper.dart';

import '../../../../../Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import '../../../../../Utils/common_widgets/SharedPerfs/preference_utils.dart';

class NgcTableBloc extends Bloc<NgcTableEvent, NgcTableState> {
  NgcTableBloc() : super(NgcTableInitialState()) {
    on<NgcTablePageLoadEvent>(_pageLoad);
    on<SelectAreaValueEvent>(_selectAreaValue);
    on<SearchBpNumberEvent>(_searchBpNumber);
  }
  int pageNo = 1;
  bool isLoader = false;
  bool isAreaFilter = false;
  GetAllAreaModel areaValue = GetAllAreaModel();
  List<GetAllAreaModel> listOfAllArea = [];
  List<InstallationByNgcData> listOfInstallationByNgc = [];
  List<InstallationByNgcData> listOfFilterInstallationByNgc = [];
  LMCInstallationByNgcModel lmcInstallationByNgcModel = LMCInstallationByNgcModel();
  TextEditingController bpNumberController = TextEditingController();

  _pageLoad(NgcTablePageLoadEvent event, emit) async {
    emit(NgcTablePageLoadState());
    isLoader = false;
    isAreaFilter = false;
    pageNo = 1;
    areaValue = GetAllAreaModel();
    listOfAllArea = [];
    listOfInstallationByNgc = [];
    bpNumberController.text = "";
    lmcInstallationByNgcModel = LMCInstallationByNgcModel();


    await Future.wait(<Future>[
      fetchAllArea(context: event.context),
      fetchInstallationByNgc(
        context: event.context,
        bpNumber: bpNumberController.text.trim().toString(),
        areaId: areaValue.gid == null ? "" : areaValue.gid!,
      ),
    ]);_eventCompleted(emit);
  }

  _selectAreaValue(SelectAreaValueEvent event, emit) async {
    areaValue = event.allAreaValue;
    isAreaFilter = true;
    _eventCompleted(emit);
    await fetchInstallationByNgc(context: event.context, bpNumber: bpNumberController.text.trim().toString(), areaId: event.allAreaValue.gid.toString());
    isAreaFilter = false;
    _eventCompleted(emit);
  }

  _searchBpNumber(SearchBpNumberEvent event, emit) async {
    bpNumberController.text = event.searchBpNumber;
    final query = event.searchBpNumber.trim();

    if (query.isNotEmpty) {
      listOfFilterInstallationByNgc = listOfInstallationByNgc
          .where((element) =>
      element.bpNumber.toString().contains(query) ||
          element.mobileNumber.toString().contains(query))
          .toList();
    } else {
      listOfFilterInstallationByNgc = List.from(listOfInstallationByNgc);
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

  fetchInstallationByNgc({required BuildContext context, required String bpNumber, required String areaId}) async {
    var res = await NgcTableHelper.getLmcInstallationByNgcApi(context: context, bpNumber: bpNumber, areaId: areaId);
    if (res != null) {
      lmcInstallationByNgcModel = res;
      if (lmcInstallationByNgcModel.success != 400) {
        listOfInstallationByNgc = lmcInstallationByNgcModel.data!;
        listOfFilterInstallationByNgc = listOfInstallationByNgc;
      }
    }
  }

  _eventCompleted(Emitter<NgcTableState> emit) {
    emit(FetchNgcTableDataState(
      isLoader: isLoader,
      isAreaFilter: isAreaFilter,
      pageNo: pageNo,
      allAreaValue: areaValue,
      listOfAllArea: listOfAllArea,
      listOfFilterInstallationByNgc: listOfFilterInstallationByNgc,
      lmcInstallationByNgcModel: lmcInstallationByNgcModel,
      bpNumberController: bpNumberController,
    ));
  }
}
