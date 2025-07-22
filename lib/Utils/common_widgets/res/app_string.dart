import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';

import 'app_config.dart';

class AppString {
  static String version = "Version : ${AppConfig.instanceInit()?.buildNumber} - LMC-22/07/2025";
  static String companyName = "© Unistal Systems Pvt. Ltd.";
  static String release = "Release Date";
  static String dateFormat = "dd-MM-yyyy";
  static String emailLabel = "Enter User Email";
  static String passwordLabel = "Enter User Password";
  static String emailValidation = "Please enter email id";
  static String passwordValidation = "Please enter password";
  static String submit = "Submit";
  static String login = "Login";
  static String logout = "Logout";
  static String checkFea = "Check Feasibility";
  static String checkRFC = "Check RFC";
  static String meterInstal = "Meter Installation";
  static String meterInstallation = "Meter Installation";
  static String no = "No";
  static String logoutMsg = "Are you sure you want to logout? Once you logout, you will be return to login screen";
  static String star = "* ";

  static String lmcMobilityH = "LMC Mobility App";
  static String lmcFeaH = "LMC Feasibility App";
  static String consumerDetailH = "Consumer Details";
  static String lmcFeaFormH = "LMC Feasibility Consumer Form";
  static String lmcInstallH = "LMC Installation App";
  static String ngConH = "NG Conversion APP";
  static String feasibilityForm = "Feasibility Form";
  static String installationForm = "Installation Form";
  static String ngConversionForm = "NG Conversion Form";

  static String search = "Search";
  static String selectArea = "Select Area";
  static String crNumber = "CR Number";
  static String assignedDate = "Assigned Date";
  static String lmcFeaDate = "Date of Feasibility";
  static String chargeArea = "Charge Area";
  static String area = "Area";
  static String firstName = "First Name";
  static String lastName = "Last Name";
  static String mobileNumber = "Registered Mobile Number";
  static String altMobileNo = "Alternate Mobile Number";
  static String email = "Email";
  static String guardianName = "Guardian Name";
  static String propertyCategory = "Property Category";
  static String propertyClass = "Property Class";
  static String buildingNumber = "Building Number";
  static String houseNumber = "House Number";
  static String colony = "Colony/Society/Apartment";
  static String street = "Street Name";
  static String town = "Town";
  static String district = "District";
  static String pinCode = "Pin Code";
  static String searchBPNumber = "Search Mobile/BP Number...";
  static String bpNumber = "BP Number";
  static String lmcProDate = "Proposed Installation Date";
  static String rfcDate = "RFC Date";
  static String installationDate = "Date of Installation";
  static String lmcFeasibilityDate = "LMC Feasibility Date";
  static String checkFeasibility = "Is Feasible?";
  static String lmcReason = "LMC Reason";
  static String meterConnection = "Meter Connection";
  static String regulatorType = "Regulator Type";
  static String actualWorkStart = "Actual Work Start";
  static String reasonDelay = "Reason for Delay";
  static String meterReadingDate = "Meter Reading Date";
  static String meterNumber = "Meter Number";
  static String meterNoErrorMsg = "Meter not Issued or Meter Number Incorrect\nor Meter already Installed";
  static String regulatorNoErrorMsg = "regulator Incorrect or Not allocated";
  static String srNoErrorMsg = "SR Incorrect or Not allocated";
  static String mrNoErrorMsg = "MR Incorrect or Not allocated";
  static String regulator = "Regulators";
  static String meterRegulator = "Meter Regulator";
  static String meterInitNumber = "Meter Initial Reading";
  static String latOfSR = "Latitude of SR";
  static String longOfSR = "Longitude of SR";
  static String latOfMR = "Latitude of MR";
  static String longOfMR = "Longitude of MR";
  static String latOfHouse = "Latitude of House";
  static String longOfHouse = "Longitude of House";
  static String srNumber = "SR";
  static String rfcDeclarationDate = "RFC Declaration Date";
  static String proNgcConDate = "NGC Conversion Date";
  static String extraPrice = "Extra Price";
  static String extraPipe = "Extra Pipe";
  static String photo = "Photo";
  static String ngcReportFile = "Ngc Report File";
  static String pneumatic = "Pneumatic Test Report";
  static String rfc = "RFC Photo";
  static String housePhoto = "House Photo";
  static String mrPhoto = "MR Photo";
  static String srPhoto = "SR Photo";
  static String installation = "Installation";
  static String meterPhoto = "Meter Photo";
  static String material = "Material";
  static String pipe = "Pipe";
  static String meter = "Meter Photo";
  static String reason = "Reason";
  static String remarks = "Remarks";
  static String contractor = "Contractor";
  static String meterReading = "Meter Reading";
  static String meterReplace = "Do you want to replace meter?";
  static String regulatorReplace = "Do you want to replace Regulator?";
  static String installRegulator = "Do you want to Install Regulator";
  static String burnersNo = "Burners No";
  static String ngChargeDate = "NG Charge Date";
  static String followUpDate = "Follow Up Date";
  static String dateInstallation = "Date of Installation";
  static String dateInstallationRFC = "Date of Installation(RFC Date)";
  static String ngConversionDate = "NG Conversion Date";
  static String ngProposedDate = "Proposed NG Conversion Date";
  static String reasonForDelay = "Reason for Delay";
  static String meterType = "Change Meter Reason";
  static String regularType = "Change Regular Reason";
  static String meterInitialReading = "Meter Initial Reading";
  static String delayStatus = "Delay Status";
  static String delayReason = "Delay Reason";
  static String noOfFamilyMembers = "No. Of Family Members";


 static OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(color: AppColor.primer, style: BorderStyle.solid, width: 0.80),
  );
  OutlineInputBorder borderGrey = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(color: AppColor.grey, style: BorderStyle.solid, width: 0.80),
  );
  static  OutlineInputBorder borderRed = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(color: AppColor.red, style: BorderStyle.solid, width: 0.80),
  );
}
