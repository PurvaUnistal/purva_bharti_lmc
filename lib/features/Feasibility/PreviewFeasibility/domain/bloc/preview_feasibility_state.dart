import 'package:equatable/equatable.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/FeasibilityModel.dart';

abstract class PreviewFeasibilityState extends Equatable{}

class PreviewFeasibilityInitialState extends PreviewFeasibilityState {
  @override
  List<Object> get props => [];
}

class PreviewFeasibilityPageLoadState extends PreviewFeasibilityState {
  @override
  List<Object> get props => [];
}

class PreviewFeasibilityDataState extends PreviewFeasibilityState{
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
  FeasibilityData? feasibilityRowsModel;
  List<FeasibilityData> listOfFeasibilityRow;
  FeasibilityModel? feasibilityModel;

  PreviewFeasibilityDataState({
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
    required this.feasibilityRowsModel,
    required this.listOfFeasibilityRow,
    required this.feasibilityModel,

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
    feasibilityRowsModel,
    listOfFeasibilityRow,
    feasibilityModel,
  ];
}