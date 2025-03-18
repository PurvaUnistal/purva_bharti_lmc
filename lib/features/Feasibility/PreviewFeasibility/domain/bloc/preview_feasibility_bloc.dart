import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/FeasibilityModel.dart';
import 'package:lmc/features/Feasibility/PreviewFeasibility/domain/bloc/preview_feasibility_event.dart';
import 'package:lmc/features/Feasibility/PreviewFeasibility/domain/bloc/preview_feasibility_state.dart';

class PreviewFeasibilityBloc extends Bloc<PreviewFeasibilityEvent, PreviewFeasibilityState> {
  PreviewFeasibilityBloc() : super(PreviewFeasibilityInitialState()) {
    on<PreviewFeasibilityPageLoadEvent>(_pageLoad);
  }

  bool isLoader = false;
  List<FeasibilityData> listOfFeasibilityRow = [];
  FeasibilityModel feasibilityModel = FeasibilityModel();
  FeasibilityData feasibilityRowsModel = FeasibilityData();
  String crNumber = '';
  String bpNumber = '';
  String schema = '';
  String userName = '';
  String chargeArea = '';
  String areaName = '';
  String firstName = '';
  String lastName = '';
  String mobileNumber = '';
  String guardianName = '';
  String proCateName = '';
  String propClass = '';
  String buildingNumber = '';
  String houseNumber = '';
  String locality = '';
  String colony = '';
  String town = '';
  String street = '';
  String district = '';
  String pinCode = '';

  _pageLoad(PreviewFeasibilityPageLoadEvent event, emit) async {
    emit(PreviewFeasibilityPageLoadState());
    isLoader = false;
    feasibilityRowsModel = FeasibilityData();
    final results = await Future.wait(<Future>[
      SharedPref.getString(key: PrefsValue.userName),
      SharedPref.getString(key: PrefsValue.schema),
      SharedPref.getString(key: PrefsValue.crNumber),
      SharedPref.getString(key: PrefsValue.bpNumber),
      SharedPref.getString(key: PrefsValue.chargeArea),
      SharedPref.getString(key: PrefsValue.areaName),
      SharedPref.getString(key: PrefsValue.firstName),
      SharedPref.getString(key: PrefsValue.lastName),
      SharedPref.getString(key: PrefsValue.mobileNumber),
      SharedPref.getString(key: PrefsValue.guardianName),
      SharedPref.getString(key: PrefsValue.proCateName),
      SharedPref.getString(key: PrefsValue.propClass),
      SharedPref.getString(key: PrefsValue.buildingNumber),
      SharedPref.getString(key: PrefsValue.houseNumber),
      SharedPref.getString(key: PrefsValue.locality),
      SharedPref.getString(key: PrefsValue.address2), // for colony
      SharedPref.getString(key: PrefsValue.town),
      SharedPref.getString(key: PrefsValue.state), // for street
      SharedPref.getString(key: PrefsValue.district),
      SharedPref.getString(key: PrefsValue.pinCode),
    ]);

    userName = results[0] ?? "";
    schema = results[1] ?? "";
    crNumber = results[2] ?? "";
    bpNumber = results[3] ?? "";
    chargeArea = results[4] ?? "";
    areaName = results[5] ?? "";
    firstName = results[6] ?? "";
    lastName = results[7] ?? "";
    mobileNumber = results[8] ?? "";
    guardianName = results[9] ?? "";
    proCateName = results[10] ?? "";
    propClass = results[11] ?? "";
    buildingNumber = results[12] ?? "";
    houseNumber = results[13] ?? "";
    locality = results[14] ?? "";
    colony = results[15] ?? "";
    town = results[16] ?? "";
    street = results[17] ?? "";
    district = results[18] ?? "";
    pinCode = results[19] ?? "";
    _eventCompleted(emit);
  }

  _eventCompleted(Emitter<PreviewFeasibilityState> emit) {
    emit(PreviewFeasibilityDataState(
      schema: schema,
      userName: userName,
      isLoader: isLoader,
      
      crNumber: crNumber,
      bpNumber: bpNumber,
      chargeArea: chargeArea,
      areaName: areaName,
      firstName: firstName,
      lastName: lastName,
      mobileNumber: mobileNumber,
      guardianName: guardianName,
      proCateName: proCateName,
      propClass: propClass,
      buildingNumber: buildingNumber,
      houseNumber: houseNumber,
      locality: locality,
      town: town,
      street: street,
      district: district,
      pinCode: pinCode,
      feasibilityRowsModel: feasibilityRowsModel,
      listOfFeasibilityRow: listOfFeasibilityRow,
      feasibilityModel: feasibilityModel,
      colony: colony,
    ));
  }
}
