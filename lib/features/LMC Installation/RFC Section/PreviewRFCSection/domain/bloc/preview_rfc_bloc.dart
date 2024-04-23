import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/PreviewRFCSection/domain/bloc/preview_rfc_event.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/PreviewRFCSection/domain/bloc/preview_rfc_state.dart';

class PreviewRFCBloc extends Bloc<PreviewRFCEvent, PreviewRFCState>{
  PreviewRFCBloc() : super(PreviewRFCInitialState()){
    on<PreviewRFCPageLoadEvent>(_pageLoad);
  }

  bool isLoader = false;

  String custRegNo = '';
  String areaName = '';
  String firstName = '';
  String lastName = '';
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

  _pageLoad(PreviewRFCPageLoadEvent event, emit) async {
    emit(PreviewRFCInitialState());
    isLoader = false;
    custRegNo = await SharedPref.getString(key: PrefsValue.custRegNo,);
    areaName = await SharedPref.getString(key: PrefsValue.areaName);
    firstName =  await SharedPref.getString(key: PrefsValue.firstName);
    lastName =  await SharedPref.getString(key: PrefsValue.lastName);
    guardianName = await SharedPref.getString(key: PrefsValue.guardianName);
    proCateName = await SharedPref.getString(key: PrefsValue.proCateName);
    propClass = await SharedPref.getString(key: PrefsValue.propClass);
    buildingNumber = await SharedPref.getString(key: PrefsValue.buildingNumber);
    houseNumber = await SharedPref.getString(key: PrefsValue.houseNumber);
    locality = await SharedPref.getString(key: PrefsValue.locality);
    town = await SharedPref.getString(key: PrefsValue.town);
    street = await SharedPref.getString(key: PrefsValue.state);
    district = await SharedPref.getString(key: PrefsValue.district);
    pinCode = await SharedPref.getString(key: PrefsValue.pinCode);
    _eventCompleted(emit);
  }


  _eventCompleted(Emitter<PreviewRFCState> emit) {
    emit(PreviewRFCDataState(
      isLoader: isLoader,
      custRegNo: custRegNo,
      areaName: areaName,
      firstName: firstName,
      lastName: lastName,
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
    )
    );
  }
}