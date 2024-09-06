import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Installation/PreviewInstallation/domain/bloc/preview_installation_event.dart';
import 'package:lmc/features/Installation/PreviewInstallation/domain/bloc/preview_installation_state.dart';

class PreviewInstallationBloc extends Bloc<PreviewInstallationEvent, PreviewInstallationState> {
  PreviewInstallationBloc() : super(PreviewInstallationInitialState()) {
    on<PreviewInstallationPageLoadEvent>(_pageLoad);
  }

  bool isLoader = false;
  String schema = '';
  String userName = '';
  String custRegNo = '';
  String trNumber = '';
  String bpNumber = '';
  String feasibilityVisitDate = '';
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
  String town = '';
  String street = '';
  String district = '';
  String pinCode = '';
  String rfcProcessStatus = '';
  String lmcInstallId = '';

  _pageLoad(PreviewInstallationPageLoadEvent event, emit) async {
    emit(PreviewInstallationInitialState());
    isLoader = false;
    custRegNo = await SharedPref.getString(
      key: PrefsValue.custRegNo,
    );
    feasibilityVisitDate = await SharedPref.getString(
      key: PrefsValue.feasibilityVisitDate,
    );
    bpNumber = await SharedPref.getString(key: PrefsValue.bpNumber);
    trNumber = await SharedPref.getString(key: PrefsValue.crNumber);
    userName = await SharedPref.getString(key: PrefsValue.userName);
    schema = await SharedPref.getString(key: PrefsValue.schema);
    chargeArea = await SharedPref.getString(key: PrefsValue.chargeArea);
    areaName = await SharedPref.getString(key: PrefsValue.areaName);
    firstName = await SharedPref.getString(key: PrefsValue.firstName);
    lastName = await SharedPref.getString(key: PrefsValue.lastName);
    lastName = await SharedPref.getString(key: PrefsValue.lastName);
    mobileNumber = await SharedPref.getString(key: PrefsValue.mobileNumber);
    proCateName = await SharedPref.getString(key: PrefsValue.proCateName);
    propClass = await SharedPref.getString(key: PrefsValue.propClass);
    buildingNumber = await SharedPref.getString(key: PrefsValue.buildingNumber);
    houseNumber = await SharedPref.getString(key: PrefsValue.houseNumber);
    locality = await SharedPref.getString(key: PrefsValue.locality);
    town = await SharedPref.getString(key: PrefsValue.town);
    street = await SharedPref.getString(key: PrefsValue.state);
    district = await SharedPref.getString(key: PrefsValue.district);
    pinCode = await SharedPref.getString(key: PrefsValue.pinCode);
    lmcInstallId = await SharedPref.getString(key: PrefsValue.lmcInstallId);
    rfcProcessStatus = await SharedPref.getString(key: PrefsValue.rfcProcessStatus);
    _eventCompleted(emit);
  }

  _eventCompleted(Emitter<PreviewInstallationState> emit) {
    emit(PreviewInstallationDataState(
      schema: schema,
      userName: userName,
      isLoader: isLoader,
      custRegNo: custRegNo,
      trNumber: trNumber,
      bpNumber: bpNumber,
      feasibilityVisitDate: feasibilityVisitDate,
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
      lmcInstallId: lmcInstallId,
      rfcProcessStatus: rfcProcessStatus,
    ));
  }
}
