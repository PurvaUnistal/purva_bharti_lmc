import 'package:equatable/equatable.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/FeasibilityModel.dart';

abstract class PreviewFeasibilityState extends Equatable {}

class PreviewFeasibilityInitialState extends PreviewFeasibilityState {
  @override
  List<Object> get props => [];
}

class PreviewFeasibilityPageLoadState extends PreviewFeasibilityInitialState {
  @override
  List<Object> get props => [];
}

class PreviewFeasibilityDataState extends PreviewFeasibilityInitialState {
  final bool isLoader;
  final String crNumber;
  final String bpNumber;
  final String chargeArea;
  final String areaName;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String guardianName;
  final String proCateName;
  final String propClass;
  final String buildingNumber;
  final String houseNumber;
  final String colony;
  final String locality;
  final String street;
  final String town;
  final String district;
  final String pinCode;
  final FeasibilityData feasibilityRowsModel;
  final List<FeasibilityData> listOfFeasibilityRow;
  final FeasibilityModel feasibilityModel;

  PreviewFeasibilityDataState({
    required this.isLoader,
    required this.crNumber,
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
  List<Object> get props => [

        isLoader,
        crNumber,
        bpNumber,
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
