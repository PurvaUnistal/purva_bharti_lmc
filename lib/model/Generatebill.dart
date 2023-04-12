class Generatebill {
  bool success;
  int code;
  bool error;
  List<Data> data;
  Generatebill({this.success, this.code, this.error, this.data});
  Generatebill.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    error = json['error'];
    if (json['data'] != String) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['error'] = this.error;
    if (this.data != String) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
   }
class Data {
  Cycle cycle;
  String billNo;
  String amount;
  String billDueDate;
  String billGeneratedDate;
  String address;
  String crn;
  String meterSerialNumber;
  String oldReading;
  String currentBillReading;
  String perScmAmt;
  String bpNumber;
  String firstName;
  String middleName;
  String lastName;
  String billFetchRef;
  String lateFee;
  String billApproved;
  String rejectReason;
  String rejectDate;

  Data(
      {this.cycle,
        this.billNo,
        this.amount,
        this.billDueDate,
        this.billGeneratedDate,
        this.address,
        this.crn,
        this.meterSerialNumber,
        this.oldReading,
        this.currentBillReading,
        this.perScmAmt,
        this.bpNumber,
        this.firstName,
        this.middleName,
        this.lastName,
        this.billFetchRef,
        this.lateFee,
        this.billApproved,
        this.rejectReason,
        this.rejectDate});

  Data.fromJson(Map<String, dynamic> json) {
    cycle = json['cycle'] != String ? new Cycle.fromJson(json['cycle']) : String;
    billNo = json['bill_no'];
    amount = json['amount'];
    billDueDate = json['bill_due_date'];
    billGeneratedDate = json['bill_generated_date'];
    address = json['address'];
    crn = json['crn'];
    meterSerialNumber = json['meter_serial_number'];
    oldReading = json['old_reading'];
    currentBillReading = json['current_bill_reading'];
    perScmAmt = json['per_scm_amt'];
    bpNumber = json['bp_number'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    billFetchRef = json['bill_fetch_ref'];
    lateFee = json['late_fee'];
    billApproved = json['bill_approved'];
    rejectReason = json['reject_reason'];
    rejectDate = json['reject_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cycle != String) {
      data['cycle'] = this.cycle.toJson();
    }
    data['bill_no'] = this.billNo;
    data['amount'] = this.amount;
    data['bill_due_date'] = this.billDueDate;
    data['bill_generated_date'] = this.billGeneratedDate;
    data['address'] = this.address;
    data['crn'] = this.crn;
    data['meter_serial_number'] = this.meterSerialNumber;
    data['old_reading'] = this.oldReading;
    data['current_bill_reading'] = this.currentBillReading;
    data['per_scm_amt'] = this.perScmAmt;
    data['bp_number'] = this.bpNumber;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['bill_fetch_ref'] = this.billFetchRef;
    data['late_fee'] = this.lateFee;
    data['bill_approved'] = this.billApproved;
    data['reject_reason'] = this.rejectReason;
    data['reject_date'] = this.rejectDate;
    return data;
  }
}
class Cycle {
  String period;
  int interval;
  String fromDate;
  String toDate;
  Cycle({this.period, this.interval, this.fromDate, this.toDate});

  Cycle.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    interval = json['interval'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['period'] = this.period;
    data['interval'] = this.interval;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    return data;
  }
}