class InstallationDoneModel {
  int? success;
  bool? error;
  InstallationDoneData? data;

  InstallationDoneModel({this.success, this.error, this.data});

  InstallationDoneModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? "";
    error = json['error'] ?? "";
    data = json['data'] != null ? new InstallationDoneData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class InstallationDoneData {
  Pager? pager;
  List<InstallationDoneRows>? rows;

  InstallationDoneData({this.pager, this.rows});

  InstallationDoneData.fromJson(Map<String, dynamic> json) {
    pager = json['pager'] != null ? new Pager.fromJson(json['pager']) : null;
    if (json['rows'] != null) {
      rows = <InstallationDoneRows>[];
      json['rows'].forEach((v) {
        rows!.add(new InstallationDoneRows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pager != null) {
      data['pager'] = this.pager!.toJson();
    }
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pager {
  dynamic uri;
  bool? hasMore;
  int? total;
  int? perPage;
  int? pageCount;
  String? pageSelector;
  int? currentPage;
  String? next;
  dynamic previous;
  int? segment;

  Pager({this.uri, this.hasMore, this.total, this.perPage, this.pageCount, this.pageSelector, this.currentPage, this.next, this.previous, this.segment});

  Pager.fromJson(Map<String, dynamic> json) {
    uri = json['uri'] ?? "";
    hasMore = json['hasMore'] ?? "";
    total = json['total'] ?? "";
    perPage = json['perPage'] ?? "";
    pageCount = json['pageCount'] ?? "";
    pageSelector = json['pageSelector'] ?? "";
    currentPage = json['currentPage'] ?? "";
    next = json['next'] ?? "";
    previous = json['previous'] ?? "";
    segment = json['segment'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uri'] = this.uri;
    data['hasMore'] = this.hasMore;
    data['total'] = this.total;
    data['perPage'] = this.perPage;
    data['pageCount'] = this.pageCount;
    data['pageSelector'] = this.pageSelector;
    data['currentPage'] = this.currentPage;
    data['next'] = this.next;
    data['previous'] = this.previous;
    data['segment'] = this.segment;
    return data;
  }
}

class InstallationDoneRows {
  dynamic id;
  String? hplcprojectId;
  String? createdOn;
  String? status;
  String? lmcId;
  String? dmaId;
  String? isReassigned;
  String? areaId;
  String? mobileNumber;
  String? firstName;
  String? middleName;
  String? lastName;
  String? guardianName;
  String? emailId;
  String? propertyCategoryId;
  String? propertyClassId;
  String? houseNumber;
  String? locality;
  String? town;
  String? district;
  String? state;
  String? pinCode;
  String? societyAllowedMdpe;
  String? residentStatus;
  String? noOfKitchen;
  String? noOfBathroom;
  String? existingCookingFuel;
  String? noOfFamilyMembers;
  String? ownerConsent;
  String? kycDocument1;
  String? kycDocument1Number;
  String? kycDocument2;
  String? kycDocument2Number;
  String? kycDocument3;
  String? kycDocument3Number;
  String? formStatus;
  String? dmaUserId;
  String? remarks;
  String? longitude;
  String? latitude;
  String? cgs;
  String? chargeAreaId;
  String? dateOfRegistration;
  String? nameOfBank;
  String? bankAccountNumber;
  String? bankIfscCode;
  String? bankAddress;
  String? dmaFormStatus;
  String? customerConsentStatus;
  String? reasonForHold;
  String? initialDepositeDate;
  String? modeOfDeposite;
  String? installmentNumber;
  String? payementBankName;
  String? paymentCreditStatus;
  String? dmaUserName;
  String? initialDepositeStatus;
  String? preferedBillingMode;
  String? acceptConversionPolicy;
  String? acceptExtraFittingCost;
  String? customerRegistrationNo;
  String? chequeNumber;
  String? marketingApprovStatus;
  String? accountApprovStatus;
  String? initialAmount;
  String? customerConsent;
  String? canceledCheque;
  String? crn;
  String? customerPhoto;
  String? housePhoto;
  String? kycDocument1Image;
  String? kycDocument2Image;
  String? kycDocument3Image;
  String? buildingNumber;
  String? address1;
  String? address2;
  String? backside1;
  String? backside2;
  String? backside3;
  String? chequeBankAccount;
  String? chequePhoto;
  String? isGasDepositApplicable;
  String? marketingApproval;
  String? markStatusTime;
  String? marketingRejectReason;
  String? accountingApproval;
  String? accountingTime;
  String? accontingRejectReason;
  String? depositeType;
  String? depositSlipDate;
  String? depositSlip;
  String? transactionId;
  String? transactionTime;
  String? transactionResponseTime;
  String? bpNumber;
  String? interested;
  String? assignLmcId;
  String? refundedAmount;
  String? refundOrderid;
  String? isGasdepositCollected;
  String? guardianType;
  String? selfRegistration;
  String? customerStatus;
  String? chequeBounceReason;
  String? micr;
  String? mobileResponseTime;
  String? isEdited;
  String? inAccount;
  String? bounceAmount;
  String? adjustableAmount;
  String? defermentAmount;
  String? districtId;
  String? disconnectionStatus;
  String? refundableStatu;
  String? saleId;
  String? collectionId;
  String? ageingId;
  String? trNumber;
  String? alternateMobile;
  String? dmaDirPath;
  String? refundableStatus;
  String? name;
  String? address;
  String? phoneNumber;
  String? email;
  String? password;
  String? userAreaMappingTable;
  String? areaMappingId;
  String? adminId;
  String? userId;
  String? userIndentId;
  String? companyName;
  String? assigendGa;
  String? assignedChargearea;
  String? textpassword;
  String? craetedDate;
  String? activatedDate;
  String? deactivatedDate;
  String? cityTown;
  String? lead;
  String? isHo;
  String? level;
  String? pwdChanged;
  String? moduleId;
  String? userTypeId;
  String? userImage;
  String? signImage;
  String? gid;
  String? objectid1;
  String? objectid;
  String? add;
  String? shapeLeng;
  String? projectCode;
  String? shapeLe1;
  String? shapeArea;
  String? dbname;
  String? labelForDashboard;
  String? gstNumber;
  String? panNumber;
  String? gaAddress;
  String? cinNumber;
  String? branchEmail;
  String? customerCare;
  String? vat;
  String? fax;
  String? cst;
  String? website;
  String? billingAddress;
  String? gaLabel;
  String? projectLogo;
  String? clientLogo;
  String? pmcLogo;
  String? contractorLogo;
  String? client;
  String? projectDesc;
  String? businessObject;
  String? pmc;
  String? contractor;
  String? gaCustomCode;
  String? areaName;
  String? areacode;
  String? cityId;
  String? subareacod;
  String? readyForConnection;
  String? dmaRegId;
  String? proposedDate;
  String? feasibilityVisitDate;
  String? additionalBom;
  String? createdAt;
  String? updatedAt;
  String? isFeasible;
  String? feasReason;
  String? followUpDate;
  String? deletedAt;
  String? source;
  String? extraPipePayment;
  String? installationStatus;
  String? modeOfDepositePayment;
  String? bounceCharge;
  String? bounceChargeTax;
  String? paymentCreditStatusLmc;
  String? invoiceNumber;
  String? invoiceAmount;
  String? extraPipe;
  String? totPipeLength;
  String? msgToCustomer;
  String? extraPipeUserId;
  String? invoiceDate;
  String? extraPipeStatus;
  String? meterNo;
  String? regulatorNo;
  String? lmcMeterReading;
  String? lastMeterReading;
  String? prevBalance;
  String? paidInstallment;
  String? actualLmcWorkStartedDate;
  String? tpaInspectionDate;
  String? ngcConversionDate;
  String? actualWorkStart;
  String? delayReason;
  String? meterType;
  String? meterMake;
  String? meterNumber;
  String? pipe;
  String? fittings;
  String? meterReading;
  String? meterReadingDate;
  String? meterPhoto;
  String? tfNumber;
  String? latitudeTf;
  String? longitudeTf;
  String? latitudeHg;
  String? longitudeHg;
  String? workCompletedDate;
  String? workCompletedImage;
  String? custAckImage;
  String? custAckDate;
  String? feasibilityId;
  String? extraPrice;
  String? cementingOfHoles;
  String? clampingPvc;
  String? claminngCopper;
  String? meterTesting;
  String? paintaingofGIpipe;
  String? conversionDate;
  String? typeOfNr;
  String? ngc;
  String? regulators;
  String? extraPipeId;
  String? isometricImage;
  String? isometricDate;
  String? pneumaticDate;
  String? pneumaticImage;
  String? rfcForm;
  String? tpaStatus;
  String? tpaRejectReason;
  String? tpaUserId;
  String? insExtraPipe;
  String? insExtraPrice;
  String? pipePaymentType;
  String? oldMeterNumber;
  String? meterReplacementDate;
  String? previousInstalledStatus;
  String? instDirPath;
  String? installationProcessStatus;
  String? rfcProcessStatus;
  String? assignId;
  String? isInstall;
  String? lmcFeasId;
  String? dma;
  String? states;
  String? dis;
  String? propName;
  String? propClass;

  InstallationDoneRows(
      {this.id,
      this.hplcprojectId,
      this.createdOn,
      this.status,
      this.lmcId,
      this.dmaId,
      this.isReassigned,
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
      this.transactionId,
      this.transactionTime,
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
      this.saleId,
      this.collectionId,
      this.ageingId,
      this.trNumber,
      this.alternateMobile,
      this.dmaDirPath,
      this.refundableStatus,
      this.name,
      this.address,
      this.phoneNumber,
      this.email,
      this.password,
      this.userAreaMappingTable,
      this.areaMappingId,
      this.adminId,
      this.userId,
      this.userIndentId,
      this.companyName,
      this.assigendGa,
      this.assignedChargearea,
      this.textpassword,
      this.craetedDate,
      this.activatedDate,
      this.deactivatedDate,
      this.cityTown,
      this.lead,
      this.isHo,
      this.level,
      this.pwdChanged,
      this.moduleId,
      this.userTypeId,
      this.userImage,
      this.signImage,
      this.gid,
      this.objectid1,
      this.objectid,
      this.add,
      this.shapeLeng,
      this.projectCode,
      this.shapeLe1,
      this.shapeArea,
      this.dbname,
      this.labelForDashboard,
      this.gstNumber,
      this.panNumber,
      this.gaAddress,
      this.cinNumber,
      this.branchEmail,
      this.customerCare,
      this.vat,
      this.fax,
      this.cst,
      this.website,
      this.billingAddress,
      this.gaLabel,
      this.projectLogo,
      this.clientLogo,
      this.pmcLogo,
      this.contractorLogo,
      this.client,
      this.projectDesc,
      this.businessObject,
      this.pmc,
      this.contractor,
      this.gaCustomCode,
      this.areaName,
      this.areacode,
      this.cityId,
      this.subareacod,
      this.readyForConnection,
      this.dmaRegId,
      this.proposedDate,
      this.feasibilityVisitDate,
      this.additionalBom,
      this.createdAt,
      this.updatedAt,
      this.isFeasible,
      this.feasReason,
      this.followUpDate,
      this.deletedAt,
      this.source,
      this.extraPipePayment,
      this.installationStatus,
      this.modeOfDepositePayment,
      this.bounceCharge,
      this.bounceChargeTax,
      this.paymentCreditStatusLmc,
      this.invoiceNumber,
      this.invoiceAmount,
      this.extraPipe,
      this.totPipeLength,
      this.msgToCustomer,
      this.extraPipeUserId,
      this.invoiceDate,
      this.extraPipeStatus,
      this.meterNo,
      this.regulatorNo,
      this.lmcMeterReading,
      this.lastMeterReading,
      this.prevBalance,
      this.paidInstallment,
      this.actualLmcWorkStartedDate,
      this.tpaInspectionDate,
      this.ngcConversionDate,
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
      this.workCompletedDate,
      this.workCompletedImage,
      this.custAckImage,
      this.custAckDate,
      this.feasibilityId,
      this.extraPrice,
      this.cementingOfHoles,
      this.clampingPvc,
      this.claminngCopper,
      this.meterTesting,
      this.paintaingofGIpipe,
      this.conversionDate,
      this.typeOfNr,
      this.ngc,
      this.regulators,
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
      this.instDirPath,
      this.installationProcessStatus,
      this.rfcProcessStatus,
      this.assignId,
      this.isInstall,
      this.lmcFeasId,
      this.dma,
      this.states,
      this.dis,
      this.propName,
      this.propClass});

  InstallationDoneRows.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    hplcprojectId = json['hplcproject_id'] ?? "";
    createdOn = json['created_on'] ?? "";
    status = json['status'] ?? "";
    lmcId = json['lmc_id'] ?? "";
    dmaId = json['dma_id'] ?? "";
    isReassigned = json['is_reassigned'] ?? "";
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
    transactionId = json['transaction_id'] ?? "";
    transactionTime = json['transaction_time'] ?? "";
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
    saleId = json['sale_id'] ?? "";
    collectionId = json['collection_id'] ?? "";
    ageingId = json['ageing_id'] ?? "";
    trNumber = json['tr_number'] ?? "";
    alternateMobile = json['alternateMobile'] ?? "";
    dmaDirPath = json['dma_dir_path'] ?? "";
    refundableStatus = json['refundable_status'] ?? "";
    name = json['name'] ?? "";
    address = json['address'] ?? "";
    phoneNumber = json['phone_number'] ?? "";
    email = json['email'] ?? "";
    password = json['password'] ?? "";
    userAreaMappingTable = json['user_area_mapping_table'] ?? "";
    areaMappingId = json['area_mapping_id'] ?? "";
    adminId = json['admin_id'] ?? "";
    userId = json['user_id'] ?? "";
    userIndentId = json['user_indent_id'] ?? "";
    companyName = json['company_name'] ?? "";
    assigendGa = json['assigend_ga'] ?? "";
    assignedChargearea = json['assigned_chargearea'] ?? "";
    textpassword = json['textpassword'] ?? "";
    craetedDate = json['craeted_date'] ?? "";
    activatedDate = json['activated_date'] ?? "";
    deactivatedDate = json['deactivated_date'] ?? "";
    cityTown = json['city_town'] ?? "";
    lead = json['lead'] ?? "";
    isHo = json['is_ho'] ?? "";
    level = json['level'] ?? "";
    pwdChanged = json['pwd_changed'] ?? "";
    moduleId = json['module_id'] ?? "";
    userTypeId = json['user_type_id'] ?? "";
    userImage = json['user_image'] ?? "";
    signImage = json['sign_image'] ?? "";
    gid = json['gid'] ?? "";
    objectid1 = json['objectid_1'] ?? "";
    objectid = json['objectid'] ?? "";
    add = json['add_'] ?? "";
    shapeLeng = json['shape_leng'] ?? "";
    projectCode = json['project_code'] ?? "";
    shapeLe1 = json['shape_le_1'] ?? "";
    shapeArea = json['shape_area'] ?? "";
    dbname = json['dbname'] ?? "";
    labelForDashboard = json['label_for_dashboard'] ?? "";
    gstNumber = json['gst_number'] ?? "";
    panNumber = json['pan_number'] ?? "";
    gaAddress = json['ga_address'] ?? "";
    cinNumber = json['cin_number'] ?? "";
    branchEmail = json['branch_email'] ?? "";
    customerCare = json['customer_care'] ?? "";
    vat = json['vat'] ?? "";
    fax = json['fax'] ?? "";
    cst = json['cst'] ?? "";
    website = json['website'] ?? "";
    billingAddress = json['billing_address'] ?? "";
    gaLabel = json['ga_label'] ?? "";
    projectLogo = json['project_logo'] ?? "";
    clientLogo = json['client_logo'] ?? "";
    pmcLogo = json['pmc_logo'] ?? "";
    contractorLogo = json['contractor_logo'] ?? "";
    client = json['client'] ?? "";
    projectDesc = json['project_desc'] ?? "";
    businessObject = json['business_object'] ?? "";
    pmc = json['pmc'] ?? "";
    contractor = json['contractor'] ?? "";
    gaCustomCode = json['ga_custom_code'] ?? "";
    areaName = json['area_name'] ?? "";
    areacode = json['areacode'] ?? "";
    cityId = json['city_id'] ?? "";
    subareacod = json['subareacod'] ?? "";
    readyForConnection = json['ready_for_connection'] ?? "";
    dmaRegId = json['dma_reg_id'] ?? "";
    proposedDate = json['proposed_date'] ?? "";
    feasibilityVisitDate = json['feasibility_visit_date'] ?? "";
    additionalBom = json['additional_bom'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    isFeasible = json['is_feasible'] ?? "";
    feasReason = json['feas_reason'] ?? "";
    followUpDate = json['follow_up_date'] ?? "";
    deletedAt = json['deleted_at'] ?? "";
    source = json['source'] ?? "";
    extraPipePayment = json['extra_pipe_payment'] ?? "";
    installationStatus = json['installation_status'] ?? "";
    modeOfDepositePayment = json['mode_of_deposite_payment'] ?? "";
    bounceCharge = json['bounce_charge'] ?? "";
    bounceChargeTax = json['bounce_charge_tax'] ?? "";
    paymentCreditStatusLmc = json['payment_credit_status_lmc'] ?? "";
    invoiceNumber = json['invoice_number'] ?? "";
    invoiceAmount = json['invoice_amount'] ?? "";
    extraPipe = json['extra_pipe'] ?? "";
    totPipeLength = json['tot_pipe_length'] ?? "";
    msgToCustomer = json['msg_to_customer'] ?? "";
    extraPipeUserId = json['extra_pipe_user_id'] ?? "";
    invoiceDate = json['invoice_date'] ?? "";
    extraPipeStatus = json['extra_pipe_status'] ?? "";
    meterNo = json['meter_no'] ?? "";
    regulatorNo = json['regulator_no'] ?? "";
    lmcMeterReading = json['lmc_meter_reading'] ?? "";
    lastMeterReading = json['last_meter_reading'] ?? "";
    prevBalance = json['prev_balance'] ?? "";
    paidInstallment = json['paid_installment'] ?? "";
    actualLmcWorkStartedDate = json['actual_lmc_work_started_date'] ?? "";
    tpaInspectionDate = json['tpa_inspection_date'] ?? "";
    ngcConversionDate = json['ngc_conversion_date'] ?? "";
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
    workCompletedDate = json['work_completed_date'] ?? "";
    workCompletedImage = json['work_completed_image'] ?? "";
    custAckImage = json['cust_ack_image'] ?? "";
    custAckDate = json['cust_ack_date'] ?? "";
    feasibilityId = json['feasibility_id'] ?? "";
    extraPrice = json['extra_price'] ?? "";
    cementingOfHoles = json['cementing_of_holes'] ?? "";
    clampingPvc = json['clamping_pvc'] ?? "";
    claminngCopper = json['claminng_copper'] ?? "";
    meterTesting = json['meter_testing'] ?? "";
    paintaingofGIpipe = json['paintaingofGIpipe'] ?? "";
    conversionDate = json['conversion_date'] ?? "";
    typeOfNr = json['type_of_nr'] ?? "";
    ngc = json['ngc'] ?? "";
    regulators = json['regulators'] ?? "";
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
    instDirPath = json['inst_dir_path'] ?? "";
    installationProcessStatus = json['installation_process_status'] ?? "";
    rfcProcessStatus = json['rfc_process_status'] ?? "";
    assignId = json['assign_id'] ?? "";
    isInstall = json['is_install'] ?? "";
    lmcFeasId = json['lmc_feas_id'] ?? "";
    dma = json['Dma'] ?? "";
    states = json['States'] ?? "";
    dis = json['Dis'] ?? "";
    propName = json['prop_name'] ?? "";
    propClass = json['prop_class'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hplcproject_id'] = this.hplcprojectId;
    data['created_on'] = this.createdOn;
    data['status'] = this.status;
    data['lmc_id'] = this.lmcId;
    data['dma_id'] = this.dmaId;
    data['is_reassigned'] = this.isReassigned;
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
    data['transaction_id'] = this.transactionId;
    data['transaction_time'] = this.transactionTime;
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
    data['sale_id'] = this.saleId;
    data['collection_id'] = this.collectionId;
    data['ageing_id'] = this.ageingId;
    data['tr_number'] = this.trNumber;
    data['alternateMobile'] = this.alternateMobile;
    data['dma_dir_path'] = this.dmaDirPath;
    data['refundable_status'] = this.refundableStatus;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['user_area_mapping_table'] = this.userAreaMappingTable;
    data['area_mapping_id'] = this.areaMappingId;
    data['admin_id'] = this.adminId;
    data['user_id'] = this.userId;
    data['user_indent_id'] = this.userIndentId;
    data['company_name'] = this.companyName;
    data['assigend_ga'] = this.assigendGa;
    data['assigned_chargearea'] = this.assignedChargearea;
    data['textpassword'] = this.textpassword;
    data['craeted_date'] = this.craetedDate;
    data['activated_date'] = this.activatedDate;
    data['deactivated_date'] = this.deactivatedDate;
    data['city_town'] = this.cityTown;
    data['lead'] = this.lead;
    data['is_ho'] = this.isHo;
    data['level'] = this.level;
    data['pwd_changed'] = this.pwdChanged;
    data['module_id'] = this.moduleId;
    data['user_type_id'] = this.userTypeId;
    data['user_image'] = this.userImage;
    data['sign_image'] = this.signImage;
    data['gid'] = this.gid;
    data['objectid_1'] = this.objectid1;
    data['objectid'] = this.objectid;
    data['add_'] = this.add;
    data['shape_leng'] = this.shapeLeng;
    data['project_code'] = this.projectCode;
    data['shape_le_1'] = this.shapeLe1;
    data['shape_area'] = this.shapeArea;
    data['dbname'] = this.dbname;
    data['label_for_dashboard'] = this.labelForDashboard;
    data['gst_number'] = this.gstNumber;
    data['pan_number'] = this.panNumber;
    data['ga_address'] = this.gaAddress;
    data['cin_number'] = this.cinNumber;
    data['branch_email'] = this.branchEmail;
    data['customer_care'] = this.customerCare;
    data['vat'] = this.vat;
    data['fax'] = this.fax;
    data['cst'] = this.cst;
    data['website'] = this.website;
    data['billing_address'] = this.billingAddress;
    data['ga_label'] = this.gaLabel;
    data['project_logo'] = this.projectLogo;
    data['client_logo'] = this.clientLogo;
    data['pmc_logo'] = this.pmcLogo;
    data['contractor_logo'] = this.contractorLogo;
    data['client'] = this.client;
    data['project_desc'] = this.projectDesc;
    data['business_object'] = this.businessObject;
    data['pmc'] = this.pmc;
    data['contractor'] = this.contractor;
    data['ga_custom_code'] = this.gaCustomCode;
    data['area_name'] = this.areaName;
    data['areacode'] = this.areacode;
    data['city_id'] = this.cityId;
    data['subareacod'] = this.subareacod;
    data['ready_for_connection'] = this.readyForConnection;
    data['dma_reg_id'] = this.dmaRegId;
    data['proposed_date'] = this.proposedDate;
    data['feasibility_visit_date'] = this.feasibilityVisitDate;
    data['additional_bom'] = this.additionalBom;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_feasible'] = this.isFeasible;
    data['feas_reason'] = this.feasReason;
    data['follow_up_date'] = this.followUpDate;
    data['deleted_at'] = this.deletedAt;
    data['source'] = this.source;
    data['extra_pipe_payment'] = this.extraPipePayment;
    data['installation_status'] = this.installationStatus;
    data['mode_of_deposite_payment'] = this.modeOfDepositePayment;
    data['bounce_charge'] = this.bounceCharge;
    data['bounce_charge_tax'] = this.bounceChargeTax;
    data['payment_credit_status_lmc'] = this.paymentCreditStatusLmc;
    data['invoice_number'] = this.invoiceNumber;
    data['invoice_amount'] = this.invoiceAmount;
    data['extra_pipe'] = this.extraPipe;
    data['tot_pipe_length'] = this.totPipeLength;
    data['msg_to_customer'] = this.msgToCustomer;
    data['extra_pipe_user_id'] = this.extraPipeUserId;
    data['invoice_date'] = this.invoiceDate;
    data['extra_pipe_status'] = this.extraPipeStatus;
    data['meter_no'] = this.meterNo;
    data['regulator_no'] = this.regulatorNo;
    data['lmc_meter_reading'] = this.lmcMeterReading;
    data['last_meter_reading'] = this.lastMeterReading;
    data['prev_balance'] = this.prevBalance;
    data['paid_installment'] = this.paidInstallment;
    data['actual_lmc_work_started_date'] = this.actualLmcWorkStartedDate;
    data['tpa_inspection_date'] = this.tpaInspectionDate;
    data['ngc_conversion_date'] = this.ngcConversionDate;
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
    data['work_completed_date'] = this.workCompletedDate;
    data['work_completed_image'] = this.workCompletedImage;
    data['cust_ack_image'] = this.custAckImage;
    data['cust_ack_date'] = this.custAckDate;
    data['feasibility_id'] = this.feasibilityId;
    data['extra_price'] = this.extraPrice;
    data['cementing_of_holes'] = this.cementingOfHoles;
    data['clamping_pvc'] = this.clampingPvc;
    data['claminng_copper'] = this.claminngCopper;
    data['meter_testing'] = this.meterTesting;
    data['paintaingofGIpipe'] = this.paintaingofGIpipe;
    data['conversion_date'] = this.conversionDate;
    data['type_of_nr'] = this.typeOfNr;
    data['ngc'] = this.ngc;
    data['regulators'] = this.regulators;
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
    data['inst_dir_path'] = this.instDirPath;
    data['installation_process_status'] = this.installationProcessStatus;
    data['rfc_process_status'] = this.rfcProcessStatus;
    data['assign_id'] = this.assignId;
    data['is_install'] = this.isInstall;
    data['lmc_feas_id'] = this.lmcFeasId;
    data['Dma'] = this.dma;
    data['States'] = this.states;
    data['Dis'] = this.dis;
    data['prop_name'] = this.propName;
    data['prop_class'] = this.propClass;
    return data;
  }
}
