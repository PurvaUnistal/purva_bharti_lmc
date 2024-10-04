import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:new_lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:new_lmc/features/Feasibility/LMC%20Feasibility/domain/model/FeasibilityModel.dart';
import 'package:new_lmc/features/Feasibility/PreviewFeasibility/domain/bloc/preview_feasibility_event.dart';
import 'package:new_lmc/features/Feasibility/PreviewFeasibility/domain/bloc/preview_feasibility_state.dart';

class PreviewFeasibilityBloc extends Bloc<PreviewFeasibilityEvent, PreviewFeasibilityState> {
  PreviewFeasibilityBloc() : super(PreviewFeasibilityInitialState()) {
    on<PreviewFeasibilityPageLoadEvent>(_pageLoad);
  }

  bool isLoader = false;
  List<FeasibilityData> listOfFeasibilityRow = [];
  FeasibilityModel? feasibilityModel;
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
    emit(PreviewFeasibilityInitialState());
    isLoader = false;
    feasibilityRowsModel = FeasibilityData();
    userName = await SharedPref.getString(
      key: PrefsValue.userName,
    );
    schema = await SharedPref.getString(
      key: PrefsValue.schema,
    );
    crNumber = await SharedPref.getString(key: PrefsValue.crNumber);
    bpNumber = await SharedPref.getString(key: PrefsValue.bpNumber);
    chargeArea = await SharedPref.getString(key: PrefsValue.chargeArea);
    areaName = await SharedPref.getString(key: PrefsValue.areaName);
    firstName = await SharedPref.getString(key: PrefsValue.firstName);
    lastName = await SharedPref.getString(key: PrefsValue.lastName);
    mobileNumber = await SharedPref.getString(key: PrefsValue.mobileNumber);
    guardianName = await SharedPref.getString(key: PrefsValue.guardianName);
    proCateName = await SharedPref.getString(key: PrefsValue.proCateName);
    propClass = await SharedPref.getString(key: PrefsValue.propClass);
    buildingNumber = await SharedPref.getString(key: PrefsValue.buildingNumber);
    houseNumber = await SharedPref.getString(key: PrefsValue.houseNumber);
    locality = await SharedPref.getString(key: PrefsValue.locality);
    colony = await SharedPref.getString(key: PrefsValue.address2);
    town = await SharedPref.getString(key: PrefsValue.town);
    street = await SharedPref.getString(key: PrefsValue.state);
    district = await SharedPref.getString(key: PrefsValue.district);
    pinCode = await SharedPref.getString(key: PrefsValue.pinCode);
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
