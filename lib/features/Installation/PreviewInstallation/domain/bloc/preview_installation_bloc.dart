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
    final results = await Future.wait(<Future>[
      SharedPref.getString(key: PrefsValue.crNumber),
      SharedPref.getString(key: PrefsValue.feasibilityVisitDate),
      SharedPref.getString(key: PrefsValue.bpNumber),
      SharedPref.getString(key: PrefsValue.userName),
      SharedPref.getString(key: PrefsValue.schema),
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
    userName = results[3] ?? "";
    schema = results[4] ?? "";
    chargeArea = results[5] ?? "";
    areaName = results[6] ?? "";
    firstName = results[7] ?? "";
    lastName = results[8] ?? "";
    mobileNumber = results[9] ?? "";
    proCateName = results[10] ?? "";
    propClass = results[11] ?? "";
    buildingNumber = results[12] ?? "";
    houseNumber = results[13] ?? "";
    locality = results[14] ?? "";
    town = results[15] ?? "";
    street = results[16] ?? "";
    district = results[17] ?? "";
    pinCode = results[18] ?? "";
    lmcInstallId = results[19] ?? "";
    rfcProcessStatus = results[20] ?? "";
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
