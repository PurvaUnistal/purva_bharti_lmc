class HpclLabel {
  Steps steps;
  Registration registration;
  Inspection inspection;
  Photo photo;
  Kyc kyc;
  Deposit deposit;
  Consent consent;
  Lmc lmc;

  HpclLabel(
      {this.steps,
        this.registration,
        this.inspection,
        this.photo,
        this.kyc,
        this.deposit,
        this.consent,
        this.lmc});

  HpclLabel.fromJson(Map<String, dynamic> json) {
    steps = json['steps'] != null ? new Steps.fromJson(json['steps']) : null;
    registration = json['registration'] != null ? new Registration.fromJson(json['registration'])  : null;
    inspection = json['inspection'] != null ? new Inspection.fromJson(json['inspection']) : null;
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
    kyc = json['kyc'] != null ? new Kyc.fromJson(json['kyc']) : null;
    deposit = json['deposit'] != null ? new Deposit.fromJson(json['deposit']) : null;
    consent = json['consent'] != null ? new Consent.fromJson(json['consent']) : null;
    lmc = json['lmc'] != null ? new Lmc.fromJson(json['lmc']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.steps != null) {
      data['steps'] = this.steps.toJson();
    }
    if (this.registration != null) {
      data['registration'] = this.registration.toJson();
    }
    if (this.inspection != null) {
      data['inspection'] = this.inspection.toJson();
    }
    if (this.photo != null) {
      data['photo'] = this.photo.toJson();
    }
    if (this.kyc != null) {
      data['kyc'] = this.kyc.toJson();
    }
    if (this.deposit != null) {
      data['deposit'] = this.deposit.toJson();
    }
    if (this.consent != null) {
      data['consent'] = this.consent.toJson();
    }
    if (this.lmc != null) {
      data['lmc'] = this.lmc.toJson();
    }
    return data;
  }
}

class Steps {
  String reg;
  String kyc;
  String photo;
  String consent;
  String deposit;
  String step1;
  String step2;
  String step3;
  String step4;
  String step5;
  String mobile;
  String firstname;
  String middlename;
  String lastname;
  String button;

  Steps(
      {
        this.reg,
        this.kyc,
        this.photo,
        this.consent,
        this.deposit,
        this.step1,
        this.step2,
        this.step3,
        this.step4,
        this.step5,
        this.mobile,
        this.firstname,
        this.middlename,
        this.lastname,
        this.button});

  Steps.fromJson(Map<String, dynamic> json) {
    reg = json['reg'];
    kyc = json['kyc'];
    photo = json['photo'];
    consent = json['consent'];
    deposit = json['deposit'];
    step1 = json['step1'];
    step2 = json['step2'];
    step3 = json['step3'];
    step4 = json['step4'];
    step5 = json['step5'];
    mobile = json['mobile'];
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    button = json['button'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reg'] = this.reg;
    data['kyc'] = this.kyc;
    data['photo'] = this.photo;
    data['consent'] = this.consent;
    data['deposit'] = this.deposit;
    data['step1'] = this.step1;
    data['step2'] = this.step2;
    data['step3'] = this.step3;
    data['step4'] = this.step4;
    data['step5'] = this.step5;
    data['mobile'] = this.mobile;
    data['firstname'] = this.firstname;
    data['middlename'] = this.middlename;
    data['lastname'] = this.lastname;
    data['button'] = this.button;
    return data;
  }
}

class Registration {
  String area;
  String lastname;
  String guardian;
  String email;
  String propertyCategory;
  String propertyClass;
  String house;
  String locality;
  String town;
  String pincode;
  String district;
  String mdpe;
  String resident;
  String kitchen;
  String bathroom;
  String fuel;
  String family;
  String location;
  String long;
  String lat;
  String getLoc;
  String remarks;
  String submit;

  Registration(
      {this.area,
        this.lastname,
        this.guardian,
        this.email,
        this.propertyCategory,
        this.propertyClass,
        this.house,
        this.locality,
        this.town,
        this.pincode,
        this.district,
        this.mdpe,
        this.resident,
        this.kitchen,
        this.bathroom,
        this.fuel,
        this.family,
        this.location,
        this.long,
        this.lat,
        this.getLoc,
        this.remarks,
        this.submit});

  Registration.fromJson(Map<String, dynamic> json) {
    area = json['area'];
    lastname = json['lastname'];
    guardian = json['guardian'];
    email = json['email'];
    propertyCategory = json['property_category'];
    propertyClass = json['property_class'];
    house = json['house'];
    locality = json['locality'];
    town = json['town'];
    pincode = json['pincode'];
    district = json['district'];
    mdpe = json['mdpe'];
    resident = json['resident'];
    kitchen = json['kitchen'];
    bathroom = json['bathroom'];
    fuel = json['fuel'];
    family = json['family'];
    location = json['location'];
    long = json['long'];
    lat = json['lat'];
    getLoc = json['getLoc'];
    remarks = json['remarks'];
    submit = json['submit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area'] = this.area;
    data['lastname'] = this.lastname;
    data['guardian'] = this.guardian;
    data['email'] = this.email;
    data['property_category'] = this.propertyCategory;
    data['property_class'] = this.propertyClass;
    data['house'] = this.house;
    data['locality'] = this.locality;
    data['town'] = this.town;
    data['pincode'] = this.pincode;
    data['district'] = this.district;
    data['mdpe'] = this.mdpe;
    data['resident'] = this.resident;
    data['kitchen'] = this.kitchen;
    data['bathroom'] = this.bathroom;
    data['fuel'] = this.fuel;
    data['family'] = this.family;
    data['location'] = this.location;
    data['long'] = this.long;
    data['lat'] = this.lat;
    data['getLoc'] = this.getLoc;
    data['remarks'] = this.remarks;
    data['submit'] = this.submit;
    return data;
  }
}

class Inspection {
  String inspectMeter;
  String inspectRegulator;
  String inspectOtherFittings;
  String asPerLmcQty;
  String customerSatisfication;
  String conversionAgreement;
  String photo;
  String conversionDate;
  String remarks;
  String extraPipe;
  String extraPrice;

  Inspection(
      {this.inspectMeter,
        this.inspectRegulator,
        this.inspectOtherFittings,
        this.asPerLmcQty,
        this.customerSatisfication,
        this.conversionAgreement,
        this.photo,
        this.conversionDate,
        this.remarks,
        this.extraPipe,
        this.extraPrice});

  Inspection.fromJson(Map<String, dynamic> json) {
    inspectMeter = json['inspect_meter'];
    inspectRegulator = json['inspect_regulator'];
    inspectOtherFittings = json['inspect_other_fittings'];
    asPerLmcQty = json['as_per_lmc_qty'];
    customerSatisfication = json['customer_satisfication'];
    conversionAgreement = json['conversion_agreement'];
    photo = json['photo'];
    conversionDate = json['conversion_date'];
    remarks = json['remarks'];
    extraPipe = json['extra_pipe'];
    extraPrice = json['extra_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inspect_meter'] = this.inspectMeter;
    data['inspect_regulator'] = this.inspectRegulator;
    data['inspect_other_fittings'] = this.inspectOtherFittings;
    data['as_per_lmc_qty'] = this.asPerLmcQty;
    data['customer_satisfication'] = this.customerSatisfication;
    data['conversion_agreement'] = this.conversionAgreement;
    data['photo'] = this.photo;
    data['conversion_date'] = this.conversionDate;
    data['remarks'] = this.remarks;
    data['extra_pipe'] = this.extraPipe;
    data['extra_price'] = this.extraPrice;
    return data;
  }
}

class Photo {
  String customerPhoto;
  String homePhoto;

  Photo({this.customerPhoto, this.homePhoto});

  Photo.fromJson(Map<String, dynamic> json) {
    customerPhoto = json['customer_photo'];
    homePhoto = json['home_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_photo'] = this.customerPhoto;
    data['home_photo'] = this.homePhoto;
    return data;
  }
}

class Kyc {
  String uploadDoc1;
  String uploadDoc1No;
  String uploadDoc1Front;
  String uploadDoc1Back;
  String selectDoc;
  String uploadDoc2;
  String uploadDoc2No;
  String uploadDoc2Front;
  String uploadDoc2Back;
  String uploadDoc3;
  String uploadDoc3No;
  String uploadDoc3Front;
  String uploadDoc3Back;

  Kyc(
      {this.uploadDoc1,
        this.uploadDoc1No,
        this.uploadDoc1Front,
        this.uploadDoc1Back,
        this.selectDoc,
        this.uploadDoc2,
        this.uploadDoc2No,
        this.uploadDoc2Front,
        this.uploadDoc2Back,
        this.uploadDoc3,
        this.uploadDoc3No,
        this.uploadDoc3Front,
        this.uploadDoc3Back});

  Kyc.fromJson(Map<String, dynamic> json) {
    uploadDoc1 = json['uploadDoc1'];
    uploadDoc1No = json['uploadDoc1No'];
    uploadDoc1Front = json['uploadDoc1Front'];
    uploadDoc1Back = json['uploadDoc1Back'];
    selectDoc = json['selectDoc'];
    uploadDoc2 = json['uploadDoc2'];
    uploadDoc2No = json['uploadDoc2No'];
    uploadDoc2Front = json['uploadDoc2Front'];
    uploadDoc2Back = json['uploadDoc2Back'];
    uploadDoc3 = json['uploadDoc3'];
    uploadDoc3No = json['uploadDoc3No'];
    uploadDoc3Front = json['uploadDoc3Front'];
    uploadDoc3Back = json['uploadDoc3Back'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploadDoc1'] = this.uploadDoc1;
    data['uploadDoc1No'] = this.uploadDoc1No;
    data['uploadDoc1Front'] = this.uploadDoc1Front;
    data['uploadDoc1Back'] = this.uploadDoc1Back;
    data['selectDoc'] = this.selectDoc;
    data['uploadDoc2'] = this.uploadDoc2;
    data['uploadDoc2No'] = this.uploadDoc2No;
    data['uploadDoc2Front'] = this.uploadDoc2Front;
    data['uploadDoc2Back'] = this.uploadDoc2Back;
    data['uploadDoc3'] = this.uploadDoc3;
    data['uploadDoc3No'] = this.uploadDoc3No;
    data['uploadDoc3Front'] = this.uploadDoc3Front;
    data['uploadDoc3Back'] = this.uploadDoc3Back;
    return data;
  }
}

class Deposit {
  String depositSta;
  String modeOfDep;
  String depositDate;
  String depositType;
  String depositAmt;
  String chqNum;
  String chqBank;
  String bankAcc;
  String chqDate;
  String chqPhoto;
  String payStatus;
  String reason;

  Deposit(
      {this.depositSta,
        this.modeOfDep,
        this.depositDate,
        this.depositType,
        this.depositAmt,
        this.chqNum,
        this.chqBank,
        this.bankAcc,
        this.chqDate,
        this.chqPhoto,
        this.payStatus,
        this.reason});

  Deposit.fromJson(Map<String, dynamic> json) {
    depositSta = json['deposit_sta'];
    modeOfDep = json['mode_of_dep'];
    depositDate = json['deposit_date'];
    depositType = json['deposit_type'];
    depositAmt = json['deposit_amt'];
    chqNum = json['chq_num'];
    chqBank = json['chq_bank'];
    bankAcc = json['bank_acc'];
    chqDate = json['chq_date'];
    chqPhoto = json['chq_photo'];
    payStatus = json['pay_status'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deposit_sta'] = this.depositSta;
    data['mode_of_dep'] = this.modeOfDep;
    data['deposit_date'] = this.depositDate;
    data['deposit_type'] = this.depositType;
    data['deposit_amt'] = this.depositAmt;
    data['chq_num'] = this.chqNum;
    data['chq_bank'] = this.chqBank;
    data['bank_acc'] = this.bankAcc;
    data['chq_date'] = this.chqDate;
    data['chq_photo'] = this.chqPhoto;
    data['pay_status'] = this.payStatus;
    data['reason'] = this.reason;
    return data;
  }
}

class Consent {
  String takePhoto;
  String custBank;
  String custAcc;
  String custIfsc;
  String custBankAdd;
  String cancelledPhoto;
  String preferredBilling;
  String acceptConversionPolicy;
  String acceptExtraCost;

  Consent(
      {this.takePhoto,
        this.custBank,
        this.custAcc,
        this.custIfsc,
        this.custBankAdd,
        this.cancelledPhoto,
        this.preferredBilling,
        this.acceptConversionPolicy,
        this.acceptExtraCost});

  Consent.fromJson(Map<String, dynamic> json) {
    takePhoto = json['take_photo'];
    custBank = json['cust_bank'];
    custAcc = json['cust_acc'];
    custIfsc = json['cust_ifsc'];
    custBankAdd = json['cust_bank_add'];
    cancelledPhoto = json['cancelled_photo'];
    preferredBilling = json['preferred_billing'];
    acceptConversionPolicy = json['accept_conversion_policy'];
    acceptExtraCost = json['accept_extra_cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['take_photo'] = this.takePhoto;
    data['cust_bank'] = this.custBank;
    data['cust_acc'] = this.custAcc;
    data['cust_ifsc'] = this.custIfsc;
    data['cust_bank_add'] = this.custBankAdd;
    data['cancelled_photo'] = this.cancelledPhoto;
    data['preferred_billing'] = this.preferredBilling;
    data['accept_conversion_policy'] = this.acceptConversionPolicy;
    data['accept_extra_cost'] = this.acceptExtraCost;
    return data;
  }
}

class Lmc {
  String feasibilityDate;
  String proposedDate;
  String additional;
  String material;
  String qty;
  String regulators;
  String installation;
  String feasibility;
  String workStart;
  String reasonIfDelay;
  String reason;
  String isFeasible;
  String followUpDate;
  String meterNumber;
  String pipe;
  String fitting;
  String meterInitialReading;
  String readingDate;
  String meterPhoto;
  String tfNumber;
  String latitudeTf;
  String longitudeTf;
  String latitudeHg;
  String longitudeHg;
  String workCompletedDate;
  String workCompletedImage;
  String ackDate;
  String ackImage;
  String conversionDate;
  String typeNr;
  String isCustomerReady;

  Lmc(
      {this.feasibilityDate,
        this.proposedDate,
        this.additional,
        this.material,
        this.qty,
        this.regulators,
        this.installation,
        this.feasibility,
        this.workStart,
        this.reasonIfDelay,
        this.reason,
        this.isFeasible,
        this.followUpDate,
        this.meterNumber,
        this.pipe,
        this.fitting,
        this.meterInitialReading,
        this.readingDate,
        this.meterPhoto,
        this.tfNumber,
        this.latitudeTf,
        this.longitudeTf,
        this.latitudeHg,
        this.longitudeHg,
        this.workCompletedDate,
        this.workCompletedImage,
        this.ackDate,
        this.ackImage,
        this.conversionDate,
        this.typeNr,
        this.isCustomerReady});

  Lmc.fromJson(Map<String, dynamic> json) {
    feasibilityDate = json['feasibility_date'];
    proposedDate = json['proposed_date'];
    additional = json['additional'];
    material = json['material'];
    qty = json['qty'];
    regulators = json['regulators'];
    installation = json['installation'];
    feasibility = json['feasibility'];
    workStart = json['work_start'];
    reasonIfDelay = json['reason_if_delay'];
    reason = json['reason'];
    isFeasible = json['is_feasible'];
    followUpDate = json['follow_up_date'];
    meterNumber = json['meter_number'];
    pipe = json['pipe'];
    fitting = json['fitting'];
    meterInitialReading = json['meter_initial_reading'];
    readingDate = json['reading_date'];
    meterPhoto = json['meter_photo'];
    tfNumber = json['tf_number'];
    latitudeTf = json['latitude_tf'];
    longitudeTf = json['longitude_tf'];
    latitudeHg = json['latitude_hg'];
    longitudeHg = json['longitude_hg'];
    workCompletedDate = json['work_completed_date'];
    workCompletedImage = json['work_completed_image'];
    ackDate = json['ack_date'];
    ackImage = json['ack_image'];
    conversionDate = json['conversion_date'];
    typeNr = json['typeNr'];
    isCustomerReady = json['is_customer_ready'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feasibility_date'] = this.feasibilityDate;
    data['proposed_date'] = this.proposedDate;
    data['additional'] = this.additional;
    data['material'] = this.material;
    data['qty'] = this.qty;
    data['regulators'] = this.regulators;
    data['installation'] = this.installation;
    data['feasibility'] = this.feasibility;
    data['work_start'] = this.workStart;
    data['reason_if_delay'] = this.reasonIfDelay;
    data['reason'] = this.reason;
    data['is_feasible'] = this.isFeasible;
    data['follow_up_date'] = this.followUpDate;
    data['meter_number'] = this.meterNumber;
    data['pipe'] = this.pipe;
    data['fitting'] = this.fitting;
    data['meter_initial_reading'] = this.meterInitialReading;
    data['reading_date'] = this.readingDate;
    data['meter_photo'] = this.meterPhoto;
    data['tf_number'] = this.tfNumber;
    data['latitude_tf'] = this.latitudeTf;
    data['longitude_tf'] = this.longitudeTf;
    data['latitude_hg'] = this.latitudeHg;
    data['longitude_hg'] = this.longitudeHg;
    data['work_completed_date'] = this.workCompletedDate;
    data['work_completed_image'] = this.workCompletedImage;
    data['ack_date'] = this.ackDate;
    data['ack_image'] = this.ackImage;
    data['conversion_date'] = this.conversionDate;
    data['typeNr'] = this.typeNr;
    data['is_customer_ready'] = this.isCustomerReady;
    return data;
  }
}