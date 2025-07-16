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
  String trNumber;
  String bpNumber;
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
  String lmcInstallId;
  String rfcProcessStatus;

  PreviewInstallationDataState({
    required this.isLoader,
    required this.trNumber,
    required this.bpNumber,
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
    required this.lmcInstallId,
    required this.rfcProcessStatus,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    isLoader,
    custRegNo,
    trNumber,
    bpNumber,
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
    lmcInstallId,
    rfcProcessStatus,
  ];
}
