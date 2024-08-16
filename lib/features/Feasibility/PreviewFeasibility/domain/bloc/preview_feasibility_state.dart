import 'package:equatable/equatable.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/FeasibilityModel.dart';

abstract class PreviewFeasibilityState extends Equatable {}

class PreviewFeasibilityInitialState extends PreviewFeasibilityState {
  @override
  List<Object> get props => [];
}

class PreviewFeasibilityPageLoadState extends PreviewFeasibilityState {
  @override
  List<Object> get props => [];
}

//ignore: must_be_immutable
class PreviewFeasibilityDataState extends PreviewFeasibilityState {
  final bool isLoader;
  String schema;
  String userName;
  String trNumber;
  String bpNumber;
  String custRegNo;
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
  String colony;
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
    required this.schema,
    required this.userName,
    required this.custRegNo,
    required this.trNumber,
    required this.bpNumber,
    required this.chargeArea,
    required this.areaName,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.colony,
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
        schema,
        userName,
        isLoader,
  trNumber,
   bpNumber,
        custRegNo,
        chargeArea,
        areaName,
        street,
        firstName,
        lastName,
        mobileNumber,
        colony,
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
