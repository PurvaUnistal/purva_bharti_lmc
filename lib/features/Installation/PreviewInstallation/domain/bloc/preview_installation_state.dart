import 'package:equatable/equatable.dart';

abstract class PreviewInstallationState extends Equatable {}

class PreviewInstallationInitialState extends PreviewInstallationState {
  @override
  List<Object> get props => [];
}

class PreviewInstallationPageLoadState extends PreviewInstallationState {
  @override
  List<Object> get props => [];
}

//ignore: must_be_immutable
class PreviewInstallationDataState extends PreviewInstallationState {
  final bool isLoader;
  String custRegNo;
  String feasibilityVisitDate;
  String chargeArea;
  String areaName;
  String firstName;
  String lastName;
  String mobileNumber;
  String guardianName;
  String proCateName;
  String propClass;
  String buildingNumber;
  String houseNumber;
  String locality;
  String street;
  String town;
  String district;
  String pinCode;

  PreviewInstallationDataState({
    required this.isLoader,
    required this.custRegNo,
    required this.feasibilityVisitDate,
    required this.chargeArea,
    required this.areaName,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.guardianName,
    required this.proCateName,
    required this.propClass,
    required this.buildingNumber,
    required this.houseNumber,
    required this.locality,
    required this.street,
    required this.town,
    required this.district,
    required this.pinCode,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        isLoader,
        custRegNo,
        feasibilityVisitDate,
        chargeArea,
        areaName,
        street,
        firstName,
        lastName,
    mobileNumber,
        guardianName,
        proCateName,
        propClass,
        buildingNumber,
        houseNumber,
        locality,
        town,
        district,
        pinCode,
      ];
}
