class LMCInstallationByNgcModel {
  int? success;
  bool? error;
  dynamic data;

  LMCInstallationByNgcModel({this.success, this.error, this.data});

  LMCInstallationByNgcModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? "";
    error = json['error'] ?? "";
    if (json['data'] != null) {
      data = <InstallationByNgcData>[] ;
      json['data'].forEach((v) {
        data!.add(new InstallationByNgcData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InstallationByNgcData {
  String? lmcpath;
  String? regulatorTypeId;
  String? regulatorType;
  String? regulatorSerial;
  String? regulators;
  dynamic mrRegulatorId;
  String? dmafamily;
  String? trNumber;
  dynamic rfcDate;
  dynamic instDirPath;
  String? lmcInstallationDate;
  String? lmcProposedNgcDate;
  String? id;
  String? createdOn;
  dynamic lmcId;
  dynamic dmaId;
  String? tpaId;
  dynamic inspectMeter;
  dynamic inspectRegulator;
  dynamic inspectOtherFitting;
  dynamic customerSatisfication;
  dynamic conversionAgreement;
  String? status;
  dynamic conversionDate;
  dynamic customerSatisficationFile;
  String? workCompletedDate;
  dynamic comment;
  dynamic lmcQty;
  String? extraPipe;
  String? extraPrice;
  dynamic invoiceAmount;
  dynamic invoiceNo;
  dynamic invoiceDate;
  String? transactionId;
  String? transactionTime;
  dynamic transactionStatus;
  dynamic ngcStatus;
  dynamic userId;
  dynamic msgToCustomer;
  dynamic modeOfDepositPayment;
  dynamic paymentMode;
  dynamic modeOfDeposit;
  String? paymentCreditStatusNgc;
  String? saleId;
  String? collectionId;
  dynamic refundableStatus;
  String? ageingId;
  String? areaId;
  String? mobileNumber;
  String? firstName;
  dynamic middleName;
  String? lastName;
  dynamic guardianName;
  dynamic emailId;
  String? propertyCategoryId;
  String? propertyClassId;
  dynamic houseNumber;
  dynamic locality;
  dynamic town;
  String? district;
  String? state;
  dynamic pinCode;
  String? societyAllowedMdpe;
  String? residentStatus;
  String? noOfKitchen;
  String? noOfBathroom;
  String? existingCookingFuel;
  dynamic noOfFamilyMembers;
  dynamic ownerConsent;
  dynamic kycDocument1;
  dynamic kycDocument1Number;
  dynamic kycDocument2;
  dynamic kycDocument2Number;
  dynamic kycDocument3;
  dynamic kycDocument3Number;
  dynamic formStatus;
  String? dmaUserId;
  String? remarks;
  dynamic longitude;
  dynamic latitude;
  dynamic cgs;
  String? chargeAreaId;
  String? dateOfRegistration;
  dynamic nameOfBank;
  dynamic bankAccountNumber;
  dynamic bankIfscCode;
  dynamic bankAddress;
  dynamic dmaFormStatus;
  dynamic customerConsentStatus;
  dynamic reasonForHold;
  dynamic initialDepositeDate;
  String? modeOfDeposite;
  dynamic installmentNumber;
  dynamic payementBankName;
  String? paymentCreditStatus;
  String? dmaUserName;
  String? initialDepositeStatus;
  String? preferedBillingMode;
  String? acceptConversionPolicy;
  String? acceptExtraFittingCost;
  dynamic customerRegistrationNo;
  dynamic chequeNumber;
  String? marketingApprovStatus;
  String? accountApprovStatus;
  String? initialAmount;
  dynamic customerConsent;
  dynamic canceledCheque;
  String? crn;
  dynamic customerPhoto;
  dynamic housePhoto;
  dynamic kycDocument1Image;
  dynamic kycDocument2Image;
  dynamic kycDocument3Image;
  dynamic buildingNumber;
  dynamic address1;
  String? address2;
  dynamic backside1;
  dynamic backside2;
  dynamic backside3;
  dynamic chequeBankAccount;
  dynamic chequePhoto;
  String? isGasDepositApplicable;
  String? marketingApproval;
  String? markStatusTime;
  dynamic marketingRejectReason;
  dynamic accountingApproval;
  String? accountingTime;
  dynamic accontingRejectReason;
  String? depositeType;
  dynamic depositSlipDate;
  dynamic depositSlip;
  String? transactionResponseTime;
  String? bpNumber;
  String? interested;
  String? assignLmcId;
  dynamic refundedAmount;
  dynamic refundOrderid;
  dynamic isGasdepositCollected;
  String? guardianType;
  String? selfRegistration;
  String? customerStatus;
  dynamic chequeBounceReason;
  dynamic micr;
  dynamic mobileResponseTime;
  String? isEdited;
  String? inAccount;
  String? bounceAmount;
  String? adjustableAmount;
  String? defermentAmount;
  String? districtId;
  String? disconnectionStatus;
  dynamic refundableStatu;
  dynamic alternateMobile;
  dynamic dmaDirPath;
  dynamic source;
  dynamic futureRegNgcEligibleStatus;
  dynamic futureRegisDate;
  dynamic futureRegisUserId;
  String? depositName;
  String? depositAmount;
  String? schemeMonth;
  String? schemeType;
  String? dateFrom;
  String? dateTo;
  String? schemeCode;
  String? gasDepositAmount;
  String? equipmentDepositAmount;
  String? interestAmount;
  String? createdAt;
  String? updatedAt;
  dynamic rejectComments;
  String? customerCount;
  String? registrationGst;
  dynamic interestTax;
  String? rebateId;
  String? totalAmount;
  String? firstDepositAmount;
  String? nextCycleAmount;
  String? equipmentIncludeInBill;
  String? registrationRefunded;
  String? equipmentRefunded;
  String? gasRefunded;
  String? totalAmountWith;
  String? firstDepositAmountWith;
  String? depositAmountExcludingTaxWith;
  String? registrationGstWith;
  String? depositAmountWith;
  String? benifitApplicable;
  String? approvalStatus;
  String? approvalDate;
  String? rentAmount;
  String? depositFree;
  String? depositAmountBeforeNgc;
  String? gasDepositAmountStatus;
  String? gasDepositInFirstBill;
  String? actualWorkStart;
  dynamic delayReason;
  String? meterType;
  dynamic meterMake;
  String? meterNumber;
  dynamic pipe;
  dynamic fittings;
  dynamic meterReading;
  String? meterReadingDate;
  String? meterPhoto;
  String? tfNumber;
  dynamic latitudeTf;
  dynamic longitudeTf;
  String? latitudeHg;
  String? longitudeHg;
  dynamic workCompletedImage;
  dynamic custAckImage;
  dynamic custAckDate;
  String? feasibilityId;
  dynamic cementingOfHoles;
  dynamic clampingPvc;
  dynamic claminngCopper;
  dynamic meterTesting;
  dynamic paintaingofGIpipe;
  String? typeOfNr;
  String? ngc;
  String? extraPipeId;
  String? isometricImage;
  dynamic isometricDate;
  dynamic pneumaticDate;
  String? pneumaticImage;
  dynamic rfcForm;
  String? tpaStatus;
  dynamic tpaRejectReason;
  dynamic tpaUserId;
  String? insExtraPipe;
  String? insExtraPrice;
  dynamic pipePaymentType;
  dynamic oldMeterNumber;
  dynamic meterReplacementDate;
  dynamic previousInstalledStatus;
  String? installationProcessStatus;
  String? rfcProcessStatus;
  String? proposedNgcDate;
  dynamic srPhoto;
  dynamic latitudeSr;
  dynamic longitudeSr;
  dynamic srRegulators;
  dynamic mrRegulatorSerial;
  dynamic mrPhoto;
  dynamic latitudeMr;
  dynamic longitudeMr;
  String? regulatorCheck;
  String? houseImage;
  String? name;
  String? gid;
  dynamic objectid;
  String? areaName;
  dynamic shapeLeng;
  String? areacode;
  dynamic cityId;
  dynamic subareacod;
  dynamic shapeLe1;
  dynamic shapeArea;
  String? readyForConnection;
  dynamic nameOfContractor;
  dynamic jmrNo;
  dynamic ngOfBurners;
  dynamic mismatchMeterNo;
  dynamic meterNoImage;
  dynamic contactPerson;
  dynamic alternateMobileNo;
  dynamic email;
  dynamic meterImage;
  dynamic contractorSign;
  dynamic represantativeSign;
  dynamic ngChargeDate;
  dynamic ngcId;
  dynamic ngConversionDate;
  dynamic delayStatus;
  dynamic ngReportFile;
  dynamic ngStatus;
  dynamic meterId;
  dynamic regulatorId;
  dynamic ngcTpaStatus;
  dynamic ngcTpaRemarks;
  dynamic ngcTpaDate;
  dynamic ngcTpaId;
  dynamic ngcMeterNumber;
  dynamic ngcRegulatorTypeId;
  dynamic ngcRegulators;
  dynamic meterChangeReason;
  dynamic changeMeterType;
  dynamic replaceMeter;
  dynamic meterImageChange;
  String? serialNumber;
  String? materialCost;
  dynamic installationCost;
  String? materialId;
  String? purchaseDate;
  dynamic qty;
  String? materialType;
  String? orderRefNumber;
  dynamic description;
  String? make;
  String? modelNo;
  dynamic manufacturer;
  String? lmcContractorId;
  String? indirectCost;
  dynamic returnReason;
  dynamic returnDate;
  String? returnStatus;
  String? indirectTax;
  String? assignedDate;
  String? autoMaterialId;
  String? workingStatus;
  String? installmentNos;
  String? materialTypeId;
  dynamic ngcContractorId;
  dynamic ngcAssignedDate;
  String? inspectionDate;
  String? meterSerial;
  String? meterreading;
  dynamic lmcConversionDate;
  String? lmcWorkCompletedDate;
  String? lmcInstallationId;
  String? lmcExtraPipe;
  String? lmcExtraPrice;
  String? isInstall;
  String? dma;
  String? propName;
  String? propClass;

  InstallationByNgcData(
      {this.lmcpath,
        this.regulatorTypeId,
        this.regulators,
        this.regulatorType,
        this.regulatorSerial,
        this.mrRegulatorId,
        this.dmafamily,
        this.trNumber,
        this.rfcDate,
        this.instDirPath,
        this.lmcInstallationDate,
        this.lmcProposedNgcDate,
        this.id,
        this.createdOn,
        this.lmcId,
        this.dmaId,
        this.tpaId,
        this.inspectMeter,
        this.inspectRegulator,
        this.inspectOtherFitting,
        this.customerSatisfication,
        this.conversionAgreement,
        this.status,
        this.conversionDate,
        this.customerSatisficationFile,
        this.workCompletedDate,
        this.comment,
        this.lmcQty,
        this.extraPipe,
        this.extraPrice,
        this.invoiceAmount,
        this.invoiceNo,
        this.invoiceDate,
        this.transactionId,
        this.transactionTime,
        this.transactionStatus,
        this.ngcStatus,
        this.userId,
        this.msgToCustomer,
        this.modeOfDepositPayment,
        this.paymentMode,
        this.modeOfDeposit,
        this.paymentCreditStatusNgc,
        this.saleId,
        this.collectionId,
        this.refundableStatus,
        this.ageingId,
        this.areaId,
        this.mobileNumber,
        this.firstName,
        this.middleName,
        this.lastName,
        this.guardianName,
        this.emailId,
        this.propertyCategoryId,
        this.propertyClassId,
        this.houseNumber,
        this.locality,
        this.town,
        this.district,
        this.state,
        this.pinCode,
        this.societyAllowedMdpe,
        this.residentStatus,
        this.noOfKitchen,
        this.noOfBathroom,
        this.existingCookingFuel,
        this.noOfFamilyMembers,
        this.ownerConsent,
        this.kycDocument1,
        this.kycDocument1Number,
        this.kycDocument2,
        this.kycDocument2Number,
        this.kycDocument3,
        this.kycDocument3Number,
        this.formStatus,
        this.dmaUserId,
        this.remarks,
        this.longitude,
        this.latitude,
        this.cgs,
        this.chargeAreaId,
        this.dateOfRegistration,
        this.nameOfBank,
        this.bankAccountNumber,
        this.bankIfscCode,
        this.bankAddress,
        this.dmaFormStatus,
        this.customerConsentStatus,
        this.reasonForHold,
        this.initialDepositeDate,
        this.modeOfDeposite,
        this.installmentNumber,
        this.payementBankName,
        this.paymentCreditStatus,
        this.dmaUserName,
        this.initialDepositeStatus,
        this.preferedBillingMode,
        this.acceptConversionPolicy,
        this.acceptExtraFittingCost,
        this.customerRegistrationNo,
        this.chequeNumber,
        this.marketingApprovStatus,
        this.accountApprovStatus,
        this.initialAmount,
        this.customerConsent,
        this.canceledCheque,
        this.crn,
        this.customerPhoto,
        this.housePhoto,
        this.kycDocument1Image,
        this.kycDocument2Image,
        this.kycDocument3Image,
        this.buildingNumber,
        this.address1,
        this.address2,
        this.backside1,
        this.backside2,
        this.backside3,
        this.chequeBankAccount,
        this.chequePhoto,
        this.isGasDepositApplicable,
        this.marketingApproval,
        this.markStatusTime,
        this.marketingRejectReason,
        this.accountingApproval,
        this.accountingTime,
        this.accontingRejectReason,
        this.depositeType,
        this.depositSlipDate,
        this.depositSlip,
        this.transactionResponseTime,
        this.bpNumber,
        this.interested,
        this.assignLmcId,
        this.refundedAmount,
        this.refundOrderid,
        this.isGasdepositCollected,
        this.guardianType,
        this.selfRegistration,
        this.customerStatus,
        this.chequeBounceReason,
        this.micr,
        this.mobileResponseTime,
        this.isEdited,
        this.inAccount,
        this.bounceAmount,
        this.adjustableAmount,
        this.defermentAmount,
        this.districtId,
        this.disconnectionStatus,
        this.refundableStatu,
        this.alternateMobile,
        this.dmaDirPath,
        this.source,
        this.futureRegNgcEligibleStatus,
        this.futureRegisDate,
        this.futureRegisUserId,
        this.depositName,
        this.depositAmount,
        this.schemeMonth,
        this.schemeType,
        this.dateFrom,
        this.dateTo,
        this.schemeCode,
        this.gasDepositAmount,
        this.equipmentDepositAmount,
        this.interestAmount,
        this.createdAt,
        this.updatedAt,
        this.rejectComments,
        this.customerCount,
        this.registrationGst,
        this.interestTax,
        this.rebateId,
        this.totalAmount,
        this.firstDepositAmount,
        this.nextCycleAmount,
        this.equipmentIncludeInBill,
        this.registrationRefunded,
        this.equipmentRefunded,
        this.gasRefunded,
        this.totalAmountWith,
        this.firstDepositAmountWith,
        this.depositAmountExcludingTaxWith,
        this.registrationGstWith,
        this.depositAmountWith,
        this.benifitApplicable,
        this.approvalStatus,
        this.approvalDate,
        this.rentAmount,
        this.depositFree,
        this.depositAmountBeforeNgc,
        this.gasDepositAmountStatus,
        this.gasDepositInFirstBill,
        this.actualWorkStart,
        this.delayReason,
        this.meterType,
        this.meterMake,
        this.meterNumber,
        this.pipe,
        this.fittings,
        this.meterReading,
        this.meterReadingDate,
        this.meterPhoto,
        this.tfNumber,
        this.latitudeTf,
        this.longitudeTf,
        this.latitudeHg,
        this.longitudeHg,
        this.workCompletedImage,
        this.custAckImage,
        this.custAckDate,
        this.feasibilityId,
        this.cementingOfHoles,
        this.clampingPvc,
        this.claminngCopper,
        this.meterTesting,
        this.paintaingofGIpipe,
        this.typeOfNr,
        this.ngc,
        this.extraPipeId,
        this.isometricImage,
        this.isometricDate,
        this.pneumaticDate,
        this.pneumaticImage,
        this.rfcForm,
        this.tpaStatus,
        this.tpaRejectReason,
        this.tpaUserId,
        this.insExtraPipe,
        this.insExtraPrice,
        this.pipePaymentType,
        this.oldMeterNumber,
        this.meterReplacementDate,
        this.previousInstalledStatus,
        this.installationProcessStatus,
        this.rfcProcessStatus,
        this.proposedNgcDate,
        this.srPhoto,
        this.latitudeSr,
        this.longitudeSr,
        this.srRegulators,
        this.mrRegulatorSerial,
        this.mrPhoto,
        this.latitudeMr,
        this.longitudeMr,
        this.regulatorCheck,
        this.houseImage,
        this.name,
        this.gid,
        this.objectid,
        this.areaName,
        this.shapeLeng,
        this.areacode,
        this.cityId,
        this.subareacod,
        this.shapeLe1,
        this.shapeArea,
        this.readyForConnection,
        this.nameOfContractor,
        this.jmrNo,
        this.ngOfBurners,
        this.mismatchMeterNo,
        this.meterNoImage,
        this.contactPerson,
        this.alternateMobileNo,
        this.email,
        this.meterImage,
        this.contractorSign,
        this.represantativeSign,
        this.ngChargeDate,
        this.ngcId,
        this.ngConversionDate,
        this.delayStatus,
        this.ngReportFile,
        this.ngStatus,
        this.meterId,
        this.regulatorId,
        this.ngcTpaStatus,
        this.ngcTpaRemarks,
        this.ngcTpaDate,
        this.ngcTpaId,
        this.ngcMeterNumber,
        this.ngcRegulatorTypeId,
        this.ngcRegulators,
        this.meterChangeReason,
        this.changeMeterType,
        this.replaceMeter,
        this.meterImageChange,
        this.serialNumber,
        this.materialCost,
        this.installationCost,
        this.materialId,
        this.purchaseDate,
        this.qty,
        this.materialType,
        this.orderRefNumber,
        this.description,
        this.make,
        this.modelNo,
        this.manufacturer,
        this.lmcContractorId,
        this.indirectCost,
        this.returnReason,
        this.returnDate,
        this.returnStatus,
        this.indirectTax,
        this.assignedDate,
        this.autoMaterialId,
        this.workingStatus,
        this.installmentNos,
        this.materialTypeId,
        this.ngcContractorId,
        this.ngcAssignedDate,
        this.inspectionDate,
        this.meterSerial,
        this.meterreading,
        this.lmcConversionDate,
        this.lmcWorkCompletedDate,
        this.lmcInstallationId,
        this.lmcExtraPipe,
        this.lmcExtraPrice,
        this.isInstall,
        this.dma,
        this.propName,
        this.propClass});

  InstallationByNgcData.fromJson(Map<String, dynamic> json) {
    lmcpath = json['lmcpath'] ?? "";
    regulatorTypeId = json['regulator_type_id'] ?? "";
    regulators = json['regulators'] ?? "";
   regulatorType = json['regulator_type'] ?? "";
    regulatorSerial = json['regulator_serial'] ?? "";
    mrRegulatorId = json['mr_regulator_id'] ?? "";
    dmafamily = json['dmafamily'] ?? "";
    trNumber = json['tr_number'] ?? "";
    rfcDate = json['rfc_date'] ?? "";
    instDirPath = json['inst_dir_path'] ?? "";
    lmcInstallationDate = json['lmc_installation_date'] ?? "";
    lmcProposedNgcDate = json['lmc_proposed_ngc_date'] ?? "";
    id = json['id'] ?? "";
    createdOn = json['created_on'] ?? "";
    lmcId = json['lmc_id'] ?? "";
    dmaId = json['dma_id'] ?? "";
    tpaId = json['tpa_id'] ?? "";
    inspectMeter = json['inspect_meter'] ?? "";
    inspectRegulator = json['inspect_regulator'] ?? "";
    inspectOtherFitting = json['inspect_other_fitting'] ?? "";
    customerSatisfication = json['customer_satisfication'] ?? "";
    conversionAgreement = json['conversion_agreement'] ?? "";
    status = json['status'] ?? "";
    conversionDate = json['conversion_date'] ?? "";
    customerSatisficationFile = json['customer_satisfication_file'] ?? "";
    workCompletedDate = json['work_completed_date'] ?? "";
    comment = json['comment'] ?? "";
    lmcQty = json['lmc_qty'] ?? "";
    extraPipe = json['extra_pipe'] ?? "";
    extraPrice = json['extra_price'] ?? "";
    invoiceAmount = json['invoice_amount'] ?? "";
    invoiceNo = json['invoice_no'] ?? "";
    invoiceDate = json['invoice_date'] ?? "";
    transactionId = json['transaction_id'] ?? "";
    transactionTime = json['transaction_time'] ?? "";
    transactionStatus = json['transaction_status'] ?? "";
    ngcStatus = json['ngc_status'] ?? "";
    userId = json['user_id'] ?? "";
    msgToCustomer = json['msg_to_customer'] ?? "";
    modeOfDepositPayment = json['mode_of_deposit_payment'] ?? "";
    paymentMode = json['payment_mode'] ?? "";
    modeOfDeposit = json['mode_of_deposit'] ?? "";
    paymentCreditStatusNgc = json['payment_credit_status_ngc'] ?? "";
    saleId = json['sale_id'] ?? "";
    collectionId = json['collection_id'] ?? "";
    refundableStatus = json['refundable_status'] ?? "";
    ageingId = json['ageing_id'] ?? "";
    areaId = json['area_id'] ?? "";
    mobileNumber = json['mobile_number'] ?? "";
    firstName = json['first_name'] ?? "";
    middleName = json['middle_name'] ?? "";
    lastName = json['last_name'] ?? "";
    guardianName = json['guardian_name'] ?? "";
    emailId = json['email_id'] ?? "";
    propertyCategoryId = json['property_category_id'] ?? "";
    propertyClassId = json['property_class_id'] ?? "";
    houseNumber = json['house_number'] ?? "";
    locality = json['locality'] ?? "";
    town = json['town'] ?? "";
    district = json['district'] ?? "";
    state = json['state'] ?? "";
    pinCode = json['pin_code'] ?? "";
    societyAllowedMdpe = json['society_allowed_mdpe'] ?? "";
    residentStatus = json['resident_status'] ?? "";
    noOfKitchen = json['no_of_kitchen'] ?? "";
    noOfBathroom = json['no_of_bathroom'] ?? "";
    existingCookingFuel = json['existing_cooking_fuel'] ?? "";
    noOfFamilyMembers = json['no_of_family_members'] ?? "";
    ownerConsent = json['owner_consent'] ?? "";
    kycDocument1 = json['kyc_document_1'] ?? "";
    kycDocument1Number = json['kyc_document_1_number'] ?? "";
    kycDocument2 = json['kyc_document_2'] ?? "";
    kycDocument2Number = json['kyc_document_2_number'] ?? "";
    kycDocument3 = json['kyc_document_3'] ?? "";
    kycDocument3Number = json['kyc_document_3_number'] ?? "";
    formStatus = json['form_status'] ?? "";
    dmaUserId = json['dma_user_id'] ?? "";
    remarks = json['remarks'] ?? "";
    longitude = json['longitude'] ?? "";
    latitude = json['latitude'] ?? "";
    cgs = json['cgs'] ?? "";
    chargeAreaId = json['charge_area_id'] ?? "";
    dateOfRegistration = json['date_of_registration'] ?? "";
    nameOfBank = json['name_of_bank'] ?? "";
    bankAccountNumber = json['bank_account_number'] ?? "";
    bankIfscCode = json['bank_ifsc_code'] ?? "";
    bankAddress = json['bank_address'] ?? "";
    dmaFormStatus = json['dma_form_status'] ?? "";
    customerConsentStatus = json['customer_consent_status'] ?? "";
    reasonForHold = json['reason_for_hold'] ?? "";
    initialDepositeDate = json['initial_deposite_date'] ?? "";
    modeOfDeposite = json['mode_of_deposite'] ?? "";
    installmentNumber = json['installment_number'] ?? "";
    payementBankName = json['payement_bank_name'] ?? "";
    paymentCreditStatus = json['payment_credit_status'] ?? "";
    dmaUserName = json['dma_user_name'] ?? "";
    initialDepositeStatus = json['initial_deposite_status'] ?? "";
    preferedBillingMode = json['prefered_billing_mode'] ?? "";
    acceptConversionPolicy = json['accept_conversion_policy'] ?? "";
    acceptExtraFittingCost = json['accept_extra_fitting_cost'] ?? "";
    customerRegistrationNo = json['customer_registration_no'] ?? "";
    chequeNumber = json['cheque_number'] ?? "";
    marketingApprovStatus = json['marketing_approv_status'] ?? "";
    accountApprovStatus = json['account_approv_status'] ?? "";
    initialAmount = json['initial_amount'] ?? "";
    customerConsent = json['customer_consent'] ?? "";
    canceledCheque = json['canceled_cheque'] ?? "";
    crn = json['crn'] ?? "";
    customerPhoto = json['customer_photo'] ?? "";
    housePhoto = json['house_photo'] ?? "";
    kycDocument1Image = json['kyc_document_1_image'] ?? "";
    kycDocument2Image = json['kyc_document_2_image'] ?? "";
    kycDocument3Image = json['kyc_document_3_image'] ?? "";
    buildingNumber = json['building_number'] ?? "";
    address1 = json['address1'] ?? "";
    address2 = json['address2'] ?? "";
    backside1 = json['backside1'] ?? "";
    backside2 = json['backside2'] ?? "";
    backside3 = json['backside3'] ?? "";
    chequeBankAccount = json['cheque_bank_account'] ?? "";
    chequePhoto = json['cheque_photo'] ?? "";
    isGasDepositApplicable = json['is_gasDepositApplicable'] ?? "";
    marketingApproval = json['marketing_approval'] ?? "";
    markStatusTime = json['mark_status_time'] ?? "";
    marketingRejectReason = json['marketing_reject_reason'] ?? "";
    accountingApproval = json['accounting_approval'] ?? "";
    accountingTime = json['accounting_time'] ?? "";
    accontingRejectReason = json['acconting_reject_reason'] ?? "";
    depositeType = json['deposite_type'] ?? "";
    depositSlipDate = json['deposit_slip_date'] ?? "";
    depositSlip = json['deposit_slip'] ?? "";
    transactionResponseTime = json['transaction_response_time'] ?? "";
    bpNumber = json['bp_number'] ?? "";
    interested = json['interested'] ?? "";
    assignLmcId = json['assign_lmc_id'] ?? "";
    refundedAmount = json['refunded_amount'] ?? "";
    refundOrderid = json['refund_orderid'] ?? "";
    isGasdepositCollected = json['is_gasdeposit_collected'] ?? "";
    guardianType = json['guardian_type'] ?? "";
    selfRegistration = json['self_registration'] ?? "";
    customerStatus = json['customer_status'] ?? "";
    chequeBounceReason = json['cheque_bounce_reason'] ?? "";
    micr = json['micr'] ?? "";
    mobileResponseTime = json['mobile_response_time'] ?? "";
    isEdited = json['is_edited'] ?? "";
    inAccount = json['in_account'] ?? "";
    bounceAmount = json['bounce_amount'] ?? "";
    adjustableAmount = json['adjustable_amount'] ?? "";
    defermentAmount = json['deferment_amount'] ?? "";
    districtId = json['district_id'] ?? "";
    disconnectionStatus = json['disconnection_status'] ?? "";
    refundableStatu = json['refundable_statu'] ?? "";
    alternateMobile = json['alternateMobile'] ?? "";
    dmaDirPath = json['dma_dir_path'] ?? "";
    source = json['source'] ?? "";
    futureRegNgcEligibleStatus = json['future_reg_ngc_eligible_status'] ?? "";
    futureRegisDate = json['future_regis_date'] ?? "";
    futureRegisUserId = json['future_regis_user_id'] ?? "";
    depositName = json['deposit_name'] ?? "";
    depositAmount = json['deposit_amount'] ?? "";
    schemeMonth = json['scheme_month'] ?? "";
    schemeType = json['scheme_type'] ?? "";
    dateFrom = json['date_from'] ?? "";
    dateTo = json['date_to'] ?? "";
    schemeCode = json['scheme_code'] ?? "";
    gasDepositAmount = json['gas_deposit_amount'] ?? "";
    equipmentDepositAmount = json['equipment_deposit_amount'] ?? "";
    interestAmount = json['interest_amount'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    rejectComments = json['reject_comments'] ?? "";
    customerCount = json['customer_count'] ?? "";
    registrationGst = json['registration_gst'] ?? "";
    interestTax = json['interest_tax'] ?? "";
    rebateId = json['rebate_id'] ?? "";
    totalAmount = json['totalAmount'] ?? "";
    firstDepositAmount = json['firstDepositAmount'] ?? "";
    nextCycleAmount = json['nextCycleAmount'] ?? "";
    equipmentIncludeInBill = json['equipment_include_in_bill'] ?? "";
    registrationRefunded = json['registration_refunded'] ?? "";
    equipmentRefunded = json['equipment_refunded'] ?? "";
    gasRefunded = json['gas_refunded'] ?? "";
    totalAmountWith = json['totalAmountWith'] ?? "";
    firstDepositAmountWith = json['firstDepositAmountWith'] ?? "";
    depositAmountExcludingTaxWith = json['deposit_amount_excluding_tax_with'] ?? "";
    registrationGstWith = json['registration_gst_with'] ?? "";
    depositAmountWith = json['deposit_amount_with'] ?? "";
    benifitApplicable = json['benifit_applicable'] ?? "";
    approvalStatus = json['approval_status'] ?? "";
    approvalDate = json['approval_date'] ?? "";
    rentAmount = json['rent_amount'] ?? "";
    depositFree = json['deposit_free'] ?? "";
    depositAmountBeforeNgc = json['deposit_amount_before_ngc'] ?? "";
    gasDepositAmountStatus = json['gas_deposit_amount_status'] ?? "";
    gasDepositInFirstBill = json['gas_deposit_in_first_bill'] ?? "";
    actualWorkStart = json['actual_work_start'] ?? "";
    delayReason = json['delay_reason'] ?? "";
    meterType = json['meter_type'] ?? "";
    meterMake = json['meter_make'] ?? "";
    meterNumber = json['meter_number'] ?? "";
    pipe = json['pipe'] ?? "";
    fittings = json['fittings'] ?? "";
    meterReading = json['meter_reading'] ?? "";
    meterReadingDate = json['meter_reading_date'] ?? "";
    meterPhoto = json['meter_photo'] ?? "";
    tfNumber = json['tf_number'] ?? "";
    latitudeTf = json['latitude_tf'] ?? "";
    longitudeTf = json['longitude_tf'] ?? "";
    latitudeHg = json['latitude_hg'] ?? "";
    longitudeHg = json['longitude_hg'] ?? "";
    workCompletedImage = json['work_completed_image'] ?? "";
    custAckImage = json['cust_ack_image'] ?? "";
    custAckDate = json['cust_ack_date'] ?? "";
    feasibilityId = json['feasibility_id'] ?? "";
    cementingOfHoles = json['cementing_of_holes'] ?? "";
    clampingPvc = json['clamping_pvc'] ?? "";
    claminngCopper = json['claminng_copper'] ?? "";
    meterTesting = json['meter_testing'] ?? "";
    paintaingofGIpipe = json['paintaingofGIpipe'] ?? "";
    typeOfNr = json['type_of_nr'] ?? "";
    ngc = json['ngc'] ?? "";
    extraPipeId = json['extra_pipe_id'] ?? "";
    isometricImage = json['isometric_image'] ?? "";
    isometricDate = json['isometric_date'] ?? "";
    pneumaticDate = json['pneumatic_date'] ?? "";
    pneumaticImage = json['pneumatic_image'] ?? "";
    rfcForm = json['rfc_form'] ?? "";
    tpaStatus = json['tpa_status'] ?? "";
    tpaRejectReason = json['tpa_reject_reason'] ?? "";
    tpaUserId = json['tpa_user_id'] ?? "";
    insExtraPipe = json['ins_extra_pipe'] ?? "";
    insExtraPrice = json['ins_extra_price'] ?? "";
    pipePaymentType = json['pipe_payment_type'] ?? "";
    oldMeterNumber = json['old_meter_number'] ?? "";
    meterReplacementDate = json['meter_replacement_date'] ?? "";
    previousInstalledStatus = json['previous_installed_status'] ?? "";
    installationProcessStatus = json['installation_process_status'] ?? "";
    rfcProcessStatus = json['rfc_process_status'] ?? "";
    proposedNgcDate = json['proposed_ngc_date'] ?? "";
    srPhoto = json['sr_photo'] ?? "";
    latitudeSr = json['latitude_sr'] ?? "";
    longitudeSr = json['longitude_sr'] ?? "";
    srRegulators = json['sr_regulators'] ?? "";
    mrRegulatorSerial = json['mr_regulator_serial'] ?? "";
    mrPhoto = json['mr_photo'] ?? "";
    latitudeMr = json['latitude_mr'] ?? "";
    longitudeMr = json['longitude_mr'] ?? "";
    regulatorCheck = json['regulator_check'] ?? "";
    houseImage = json['house_image'] ?? "";
    name = json['name'] ?? "";
    gid = json['gid'] ?? "";
    objectid = json['objectid'] ?? "";
    areaName = json['area_name'] ?? "";
    shapeLeng = json['shape_leng'] ?? "";
    areacode = json['areacode'] ?? "";
    cityId = json['city_id'] ?? "";
    subareacod = json['subareacod'] ?? "";
    shapeLe1 = json['shape_le_1'] ?? "";
    shapeArea = json['shape_area'] ?? "";
    readyForConnection = json['ready_for_connection'] ?? "";
    nameOfContractor = json['name_of_contractor'] ?? "";
    jmrNo = json['jmr_no'] ?? "";
    ngOfBurners = json['ng_of_burners'] ?? "";
    mismatchMeterNo = json['mismatch_meter_no'] ?? "";
    meterNoImage = json['meter_no_image'] ?? "";
    contactPerson = json['contact_person'] ?? "";
    alternateMobileNo = json['alternate_mobile_no'] ?? "";
    email = json['email'] ?? "";
    meterImage = json['meter_image'] ?? "";
    contractorSign = json['contractor_sign'] ?? "";
    represantativeSign = json['represantative_sign'] ?? "";
    ngChargeDate = json['ng_charge_date'] ?? "";
    ngcId = json['ngc_id'] ?? "";
    ngConversionDate = json['ng_conversion_date'] ?? "";
    delayStatus = json['delay_status'] ?? "";
    ngReportFile = json['ng_report_file'] ?? "";
    ngStatus = json['ng_status'] ?? "";
    meterId = json['meter_id'] ?? "";
    regulatorId = json['regulator_id'] ?? "";
    ngcTpaStatus = json['ngc_tpa_status'] ?? "";
    ngcTpaRemarks = json['ngc_tpa_remarks'] ?? "";
    ngcTpaDate = json['ngc_tpa_date'] ?? "";
    ngcTpaId = json['ngc_tpa_id'] ?? "";
    ngcMeterNumber = json['ngc_meter_number'] ?? "";
    ngcRegulatorTypeId = json['ngc_regulator_type_id'] ?? "";
    ngcRegulators = json['ngc_regulators'] ?? "";
    meterChangeReason = json['meter_change_reason'] ?? "";
    changeMeterType = json['change_meter_type'] ?? "";
    replaceMeter = json['replace_meter'] ?? "";
    meterImageChange = json['meter_image_change'] ?? "";
    serialNumber = json['serial_number'] ?? "";
    materialCost = json['material_cost'] ?? "";
    installationCost = json['installation_cost'] ?? "";
    materialId = json['material_id'] ?? "";
    purchaseDate = json['purchase_date'] ?? "";
    qty = json['qty'] ?? "";
    materialType = json['material_type'] ?? "";
    orderRefNumber = json['order_ref_number'] ?? "";
    description = json['description'] ?? "";
    make = json['make'] ?? "";
    modelNo = json['model_no'] ?? "";
    manufacturer = json['manufacturer'] ?? "";
    lmcContractorId = json['lmc_contractor_id'] ?? "";
    indirectCost = json['indirect_cost'] ?? "";
    returnReason = json['return_reason'] ?? "";
    returnDate = json['return_date'] ?? "";
    returnStatus = json['return_status'] ?? "";
    indirectTax = json['indirect_tax'] ?? "";
    assignedDate = json['assigned_date'] ?? "";
    autoMaterialId = json['auto_material_id'] ?? "";
    workingStatus = json['working_status'] ?? "";
    installmentNos = json['installment_nos'] ?? "";
    materialTypeId = json['material_type_id'] ?? "";
    ngcContractorId = json['ngc_contractor_id'] ?? "";
    ngcAssignedDate = json['ngc_assigned_date'] ?? "";
    inspectionDate = json['inspection_date'] ?? "";
    meterSerial = json['meter_serial'] ?? "";
    meterreading = json['meterreading'] ?? "";
    lmcConversionDate = json['lmc_conversion_date'] ?? "";
    lmcWorkCompletedDate = json['lmc_work_completed_date'] ?? "";
    lmcInstallationId = json['lmc_installation_id'] ?? "";
    lmcExtraPipe = json['lmc_extra_pipe'] ?? "";
    lmcExtraPrice = json['lmc_extra_price'] ?? "";
    isInstall = json['is_install'] ?? "";
    dma = json['Dma'] ?? "";
    propName = json['prop_name'] ?? "";
    propClass = json['prop_class'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lmcpath'] = this.lmcpath;
    data['regulator_type_id'] = this.regulatorTypeId;
    data['regulators'] = this.regulators;
    data['regulator_type'] = this.regulatorType;
    data['regulator_serial'] = this.regulatorSerial;
    data['mr_regulator_id'] = this.mrRegulatorId;
    data['dmafamily'] = this.dmafamily;
    data['tr_number'] = this.trNumber;
    data['rfc_date'] = this.rfcDate;
    data['inst_dir_path'] = this.instDirPath;
    data['lmc_installation_date'] = this.lmcInstallationDate;
    data['lmc_proposed_ngc_date'] = this.lmcProposedNgcDate;
    data['id'] = this.id;
    data['created_on'] = this.createdOn;
    data['lmc_id'] = this.lmcId;
    data['dma_id'] = this.dmaId;
    data['tpa_id'] = this.tpaId;
    data['inspect_meter'] = this.inspectMeter;
    data['inspect_regulator'] = this.inspectRegulator;
    data['inspect_other_fitting'] = this.inspectOtherFitting;
    data['customer_satisfication'] = this.customerSatisfication;
    data['conversion_agreement'] = this.conversionAgreement;
    data['status'] = this.status;
    data['conversion_date'] = this.conversionDate;
    data['customer_satisfication_file'] = this.customerSatisficationFile;
    data['work_completed_date'] = this.workCompletedDate;
    data['comment'] = this.comment;
    data['lmc_qty'] = this.lmcQty;
    data['extra_pipe'] = this.extraPipe;
    data['extra_price'] = this.extraPrice;
    data['invoice_amount'] = this.invoiceAmount;
    data['invoice_no'] = this.invoiceNo;
    data['invoice_date'] = this.invoiceDate;
    data['transaction_id'] = this.transactionId;
    data['transaction_time'] = this.transactionTime;
    data['transaction_status'] = this.transactionStatus;
    data['ngc_status'] = this.ngcStatus;
    data['user_id'] = this.userId;
    data['msg_to_customer'] = this.msgToCustomer;
    data['mode_of_deposit_payment'] = this.modeOfDepositPayment;
    data['payment_mode'] = this.paymentMode;
    data['mode_of_deposit'] = this.modeOfDeposit;
    data['payment_credit_status_ngc'] = this.paymentCreditStatusNgc;
    data['sale_id'] = this.saleId;
    data['collection_id'] = this.collectionId;
    data['refundable_status'] = this.refundableStatus;
    data['ageing_id'] = this.ageingId;
    data['area_id'] = this.areaId;
    data['mobile_number'] = this.mobileNumber;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['guardian_name'] = this.guardianName;
    data['email_id'] = this.emailId;
    data['property_category_id'] = this.propertyCategoryId;
    data['property_class_id'] = this.propertyClassId;
    data['house_number'] = this.houseNumber;
    data['locality'] = this.locality;
    data['town'] = this.town;
    data['district'] = this.district;
    data['state'] = this.state;
    data['pin_code'] = this.pinCode;
    data['society_allowed_mdpe'] = this.societyAllowedMdpe;
    data['resident_status'] = this.residentStatus;
    data['no_of_kitchen'] = this.noOfKitchen;
    data['no_of_bathroom'] = this.noOfBathroom;
    data['existing_cooking_fuel'] = this.existingCookingFuel;
    data['no_of_family_members'] = this.noOfFamilyMembers;
    data['owner_consent'] = this.ownerConsent;
    data['kyc_document_1'] = this.kycDocument1;
    data['kyc_document_1_number'] = this.kycDocument1Number;
    data['kyc_document_2'] = this.kycDocument2;
    data['kyc_document_2_number'] = this.kycDocument2Number;
    data['kyc_document_3'] = this.kycDocument3;
    data['kyc_document_3_number'] = this.kycDocument3Number;
    data['form_status'] = this.formStatus;
    data['dma_user_id'] = this.dmaUserId;
    data['remarks'] = this.remarks;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['cgs'] = this.cgs;
    data['charge_area_id'] = this.chargeAreaId;
    data['date_of_registration'] = this.dateOfRegistration;
    data['name_of_bank'] = this.nameOfBank;
    data['bank_account_number'] = this.bankAccountNumber;
    data['bank_ifsc_code'] = this.bankIfscCode;
    data['bank_address'] = this.bankAddress;
    data['dma_form_status'] = this.dmaFormStatus;
    data['customer_consent_status'] = this.customerConsentStatus;
    data['reason_for_hold'] = this.reasonForHold;
    data['initial_deposite_date'] = this.initialDepositeDate;
    data['mode_of_deposite'] = this.modeOfDeposite;
    data['installment_number'] = this.installmentNumber;
    data['payement_bank_name'] = this.payementBankName;
    data['payment_credit_status'] = this.paymentCreditStatus;
    data['dma_user_name'] = this.dmaUserName;
    data['initial_deposite_status'] = this.initialDepositeStatus;
    data['prefered_billing_mode'] = this.preferedBillingMode;
    data['accept_conversion_policy'] = this.acceptConversionPolicy;
    data['accept_extra_fitting_cost'] = this.acceptExtraFittingCost;
    data['customer_registration_no'] = this.customerRegistrationNo;
    data['cheque_number'] = this.chequeNumber;
    data['marketing_approv_status'] = this.marketingApprovStatus;
    data['account_approv_status'] = this.accountApprovStatus;
    data['initial_amount'] = this.initialAmount;
    data['customer_consent'] = this.customerConsent;
    data['canceled_cheque'] = this.canceledCheque;
    data['crn'] = this.crn;
    data['customer_photo'] = this.customerPhoto;
    data['house_photo'] = this.housePhoto;
    data['kyc_document_1_image'] = this.kycDocument1Image;
    data['kyc_document_2_image'] = this.kycDocument2Image;
    data['kyc_document_3_image'] = this.kycDocument3Image;
    data['building_number'] = this.buildingNumber;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['backside1'] = this.backside1;
    data['backside2'] = this.backside2;
    data['backside3'] = this.backside3;
    data['cheque_bank_account'] = this.chequeBankAccount;
    data['cheque_photo'] = this.chequePhoto;
    data['is_gasDepositApplicable'] = this.isGasDepositApplicable;
    data['marketing_approval'] = this.marketingApproval;
    data['mark_status_time'] = this.markStatusTime;
    data['marketing_reject_reason'] = this.marketingRejectReason;
    data['accounting_approval'] = this.accountingApproval;
    data['accounting_time'] = this.accountingTime;
    data['acconting_reject_reason'] = this.accontingRejectReason;
    data['deposite_type'] = this.depositeType;
    data['deposit_slip_date'] = this.depositSlipDate;
    data['deposit_slip'] = this.depositSlip;
    data['transaction_response_time'] = this.transactionResponseTime;
    data['bp_number'] = this.bpNumber;
    data['interested'] = this.interested;
    data['assign_lmc_id'] = this.assignLmcId;
    data['refunded_amount'] = this.refundedAmount;
    data['refund_orderid'] = this.refundOrderid;
    data['is_gasdeposit_collected'] = this.isGasdepositCollected;
    data['guardian_type'] = this.guardianType;
    data['self_registration'] = this.selfRegistration;
    data['customer_status'] = this.customerStatus;
    data['cheque_bounce_reason'] = this.chequeBounceReason;
    data['micr'] = this.micr;
    data['mobile_response_time'] = this.mobileResponseTime;
    data['is_edited'] = this.isEdited;
    data['in_account'] = this.inAccount;
    data['bounce_amount'] = this.bounceAmount;
    data['adjustable_amount'] = this.adjustableAmount;
    data['deferment_amount'] = this.defermentAmount;
    data['district_id'] = this.districtId;
    data['disconnection_status'] = this.disconnectionStatus;
    data['refundable_statu'] = this.refundableStatu;
    data['alternateMobile'] = this.alternateMobile;
    data['dma_dir_path'] = this.dmaDirPath;
    data['source'] = this.source;
    data['future_reg_ngc_eligible_status'] = this.futureRegNgcEligibleStatus;
    data['future_regis_date'] = this.futureRegisDate;
    data['future_regis_user_id'] = this.futureRegisUserId;
    data['deposit_name'] = this.depositName;
    data['deposit_amount'] = this.depositAmount;
    data['scheme_month'] = this.schemeMonth;
    data['scheme_type'] = this.schemeType;
    data['date_from'] = this.dateFrom;
    data['date_to'] = this.dateTo;
    data['scheme_code'] = this.schemeCode;
    data['gas_deposit_amount'] = this.gasDepositAmount;
    data['equipment_deposit_amount'] = this.equipmentDepositAmount;
    data['interest_amount'] = this.interestAmount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['reject_comments'] = this.rejectComments;
    data['customer_count'] = this.customerCount;
    data['registration_gst'] = this.registrationGst;
    data['interest_tax'] = this.interestTax;
    data['rebate_id'] = this.rebateId;
    data['totalAmount'] = this.totalAmount;
    data['firstDepositAmount'] = this.firstDepositAmount;
    data['nextCycleAmount'] = this.nextCycleAmount;
    data['equipment_include_in_bill'] = this.equipmentIncludeInBill;
    data['registration_refunded'] = this.registrationRefunded;
    data['equipment_refunded'] = this.equipmentRefunded;
    data['gas_refunded'] = this.gasRefunded;
    data['totalAmountWith'] = this.totalAmountWith;
    data['firstDepositAmountWith'] = this.firstDepositAmountWith;
    data['deposit_amount_excluding_tax_with'] =
        this.depositAmountExcludingTaxWith;
    data['registration_gst_with'] = this.registrationGstWith;
    data['deposit_amount_with'] = this.depositAmountWith;
    data['benifit_applicable'] = this.benifitApplicable;
    data['approval_status'] = this.approvalStatus;
    data['approval_date'] = this.approvalDate;
    data['rent_amount'] = this.rentAmount;
    data['deposit_free'] = this.depositFree;
    data['deposit_amount_before_ngc'] = this.depositAmountBeforeNgc;
    data['gas_deposit_amount_status'] = this.gasDepositAmountStatus;
    data['gas_deposit_in_first_bill'] = this.gasDepositInFirstBill;
    data['actual_work_start'] = this.actualWorkStart;
    data['delay_reason'] = this.delayReason;
    data['meter_type'] = this.meterType;
    data['meter_make'] = this.meterMake;
    data['meter_number'] = this.meterNumber;
    data['pipe'] = this.pipe;
    data['fittings'] = this.fittings;
    data['meter_reading'] = this.meterReading;
    data['meter_reading_date'] = this.meterReadingDate;
    data['meter_photo'] = this.meterPhoto;
    data['tf_number'] = this.tfNumber;
    data['latitude_tf'] = this.latitudeTf;
    data['longitude_tf'] = this.longitudeTf;
    data['latitude_hg'] = this.latitudeHg;
    data['longitude_hg'] = this.longitudeHg;
    data['work_completed_image'] = this.workCompletedImage;
    data['cust_ack_image'] = this.custAckImage;
    data['cust_ack_date'] = this.custAckDate;
    data['feasibility_id'] = this.feasibilityId;
    data['cementing_of_holes'] = this.cementingOfHoles;
    data['clamping_pvc'] = this.clampingPvc;
    data['claminng_copper'] = this.claminngCopper;
    data['meter_testing'] = this.meterTesting;
    data['paintaingofGIpipe'] = this.paintaingofGIpipe;
    data['type_of_nr'] = this.typeOfNr;
    data['ngc'] = this.ngc;
    data['extra_pipe_id'] = this.extraPipeId;
    data['isometric_image'] = this.isometricImage;
    data['isometric_date'] = this.isometricDate;
    data['pneumatic_date'] = this.pneumaticDate;
    data['pneumatic_image'] = this.pneumaticImage;
    data['rfc_form'] = this.rfcForm;
    data['tpa_status'] = this.tpaStatus;
    data['tpa_reject_reason'] = this.tpaRejectReason;
    data['tpa_user_id'] = this.tpaUserId;
    data['ins_extra_pipe'] = this.insExtraPipe;
    data['ins_extra_price'] = this.insExtraPrice;
    data['pipe_payment_type'] = this.pipePaymentType;
    data['old_meter_number'] = this.oldMeterNumber;
    data['meter_replacement_date'] = this.meterReplacementDate;
    data['previous_installed_status'] = this.previousInstalledStatus;
    data['installation_process_status'] = this.installationProcessStatus;
    data['rfc_process_status'] = this.rfcProcessStatus;
    data['proposed_ngc_date'] = this.proposedNgcDate;
    data['sr_photo'] = this.srPhoto;
    data['latitude_sr'] = this.latitudeSr;
    data['longitude_sr'] = this.longitudeSr;
    data['sr_regulators'] = this.srRegulators;
    data['mr_regulator_serial'] = this.mrRegulatorSerial;
    data['mr_photo'] = this.mrPhoto;
    data['latitude_mr'] = this.latitudeMr;
    data['longitude_mr'] = this.longitudeMr;
    data['regulator_check'] = this.regulatorCheck;
    data['house_image'] = this.houseImage;
    data['name'] = this.name;
    data['gid'] = this.gid;
    data['objectid'] = this.objectid;
    data['area_name'] = this.areaName;
    data['shape_leng'] = this.shapeLeng;
    data['areacode'] = this.areacode;
    data['city_id'] = this.cityId;
    data['subareacod'] = this.subareacod;
    data['shape_le_1'] = this.shapeLe1;
    data['shape_area'] = this.shapeArea;
    data['ready_for_connection'] = this.readyForConnection;
    data['name_of_contractor'] = this.nameOfContractor;
    data['jmr_no'] = this.jmrNo;
    data['ng_of_burners'] = this.ngOfBurners;
    data['mismatch_meter_no'] = this.mismatchMeterNo;
    data['meter_no_image'] = this.meterNoImage;
    data['contact_person'] = this.contactPerson;
    data['alternate_mobile_no'] = this.alternateMobileNo;
    data['email'] = this.email;
    data['meter_image'] = this.meterImage;
    data['contractor_sign'] = this.contractorSign;
    data['represantative_sign'] = this.represantativeSign;
    data['ng_charge_date'] = this.ngChargeDate;
    data['ngc_id'] = this.ngcId;
    data['ng_conversion_date'] = this.ngConversionDate;
    data['delay_status'] = this.delayStatus;
    data['ng_report_file'] = this.ngReportFile;
    data['ng_status'] = this.ngStatus;
    data['meter_id'] = this.meterId;
    data['regulator_id'] = this.regulatorId;
    data['ngc_tpa_status'] = this.ngcTpaStatus;
    data['ngc_tpa_remarks'] = this.ngcTpaRemarks;
    data['ngc_tpa_date'] = this.ngcTpaDate;
    data['ngc_tpa_id'] = this.ngcTpaId;
    data['ngc_meter_number'] = this.ngcMeterNumber;
    data['ngc_regulator_type_id'] = this.ngcRegulatorTypeId;
    data['ngc_regulators'] = this.ngcRegulators;
    data['meter_change_reason'] = this.meterChangeReason;
    data['change_meter_type'] = this.changeMeterType;
    data['replace_meter'] = this.replaceMeter;
    data['meter_image_change'] = this.meterImageChange;
    data['serial_number'] = this.serialNumber;
    data['material_cost'] = this.materialCost;
    data['installation_cost'] = this.installationCost;
    data['material_id'] = this.materialId;
    data['purchase_date'] = this.purchaseDate;
    data['qty'] = this.qty;
    data['material_type'] = this.materialType;
    data['order_ref_number'] = this.orderRefNumber;
    data['description'] = this.description;
    data['make'] = this.make;
    data['model_no'] = this.modelNo;
    data['manufacturer'] = this.manufacturer;
    data['lmc_contractor_id'] = this.lmcContractorId;
    data['indirect_cost'] = this.indirectCost;
    data['return_reason'] = this.returnReason;
    data['return_date'] = this.returnDate;
    data['return_status'] = this.returnStatus;
    data['indirect_tax'] = this.indirectTax;
    data['assigned_date'] = this.assignedDate;
    data['auto_material_id'] = this.autoMaterialId;
    data['working_status'] = this.workingStatus;
    data['installment_nos'] = this.installmentNos;
    data['material_type_id'] = this.materialTypeId;
    data['ngc_contractor_id'] = this.ngcContractorId;
    data['ngc_assigned_date'] = this.ngcAssignedDate;
    data['inspection_date'] = this.inspectionDate;
    data['meter_serial'] = this.meterSerial;
    data['meterreading'] = this.meterreading;
    data['lmc_conversion_date'] = this.lmcConversionDate;
    data['lmc_work_completed_date'] = this.lmcWorkCompletedDate;
    data['lmc_installation_id'] = this.lmcInstallationId;
    data['lmc_extra_pipe'] = this.lmcExtraPipe;
    data['lmc_extra_price'] = this.lmcExtraPrice;
    data['is_install'] = this.isInstall;
    data['Dma'] = this.dma;
    data['prop_name'] = this.propName;
    data['prop_class'] = this.propClass;
    return data;
  }
}
