import 'package:equatable/equatable.dart';

abstract class PreviewRFCState extends Equatable{}

class PreviewRFCInitialState extends PreviewRFCState {
  @override
  List<Object> get props => [];
}

class PreviewRFCPageLoadState extends PreviewRFCState {
  @override
  List<Object> get props => [];
}

//ignore: must_be_immutable
class PreviewRFCDataState extends PreviewRFCState{
  final bool isLoader;
  String custRegNo;
  String areaName;
  String firstName;
  String lastName;
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

  PreviewRFCDataState({
    required this.isLoader,
     required this.custRegNo,
     required this.areaName,
     required this.firstName,
     required this.lastName,
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
    areaName,
    street,
    firstName,
    lastName,
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