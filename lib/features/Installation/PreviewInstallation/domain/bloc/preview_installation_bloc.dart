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
    final results = await Future.wait(<Future>[
      SharedPref.getString(key: PrefsValue.crNumber),
      SharedPref.getString(key: PrefsValue.feasibilityVisitDate),
      SharedPref.getString(key: PrefsValue.bpNumber),
      SharedPref.getString(key: PrefsValue.chargeArea),
      SharedPref.getString(key: PrefsValue.areaName),
      SharedPref.getString(key: PrefsValue.firstName),
      SharedPref.getString(key: PrefsValue.lastName),
      SharedPref.getString(key: PrefsValue.mobileNumber),
      SharedPref.getString(key: PrefsValue.proCateName),
      SharedPref.getString(key: PrefsValue.propClass),
      SharedPref.getString(key: PrefsValue.buildingNumber),
      SharedPref.getString(key: PrefsValue.houseNumber),
      SharedPref.getString(key: PrefsValue.locality),
      SharedPref.getString(key: PrefsValue.town),
      SharedPref.getString(key: PrefsValue.state),
      SharedPref.getString(key: PrefsValue.district),
      SharedPref.getString(key: PrefsValue.pinCode),
      SharedPref.getString(key: PrefsValue.lmcInstallId),
      SharedPref.getString(key: PrefsValue.rfcProcessStatus),
    ]);

    custRegNo = results[0] ?? "";
    trNumber = results[0] ?? "";
    feasibilityVisitDate = results[1] ?? "";
    bpNumber = results[2] ?? "";
    chargeArea = results[3] ?? "";
    areaName = results[4] ?? "";
    firstName = results[5] ?? "";
    lastName = results[6] ?? "";
    mobileNumber = results[7] ?? "";
    proCateName = results[8] ?? "";
    propClass = results[9] ?? "";
    buildingNumber = results[10] ?? "";
    houseNumber = results[11] ?? "";
    locality = results[12] ?? "";
    town = results[13] ?? "";
    street = results[14] ?? "";
    district = results[15] ?? "";
    pinCode = results[16] ?? "";
    lmcInstallId = results[17] ?? "";
    rfcProcessStatus = results[18] ?? "";
    _eventCompleted(emit);
  }

  _eventCompleted(Emitter<PreviewInstallationState> emit) {
    emit(PreviewInstallationDataState(
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
