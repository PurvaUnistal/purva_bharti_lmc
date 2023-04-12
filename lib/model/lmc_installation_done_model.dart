
  class LmcInstallationDoneModel {
  int success;
  bool error;
  Data data;

  LmcInstallationDoneModel({this.success, this.error, this.data});

  LmcInstallationDoneModel.fromJson(Map<String, dynamic> json) {
  success = json['success'];
  error = json['error'];
  data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['success'] = this.success;
  data['error'] = this.error;
  if (this.data != null) {
  data['data'] = this.data.toJson();
  }
  return data;
  }
  }

  class Data {
  Pager pager;
  List<Rows> rows;

  Data({this.pager, this.rows});

  Data.fromJson(Map<String, dynamic> json) {
  pager = json['pager'] != null ? new Pager.fromJson(json['pager']) : null;
  if (json['rows'] != null) {
  rows = new List<Rows>();
  json['rows'].forEach((v) { rows.add(new Rows.fromJson(v)); });
  }
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (this.pager != null) {
  data['pager'] = this.pager.toJson();
  }
  if (this.rows != null) {
  data['rows'] = this.rows.map((v) => v.toJson()).toList();
  }
  return data;
  }
  }

  class Pager {
 // Uri uri;
  bool hasMore;
  int total;
  int perPage;
  int pageCount;
  String pageSelector;
  int currentPage;
  String next;
  String previous;
  int segment;

  Pager({
   // this.uri,
    this.hasMore, this.total, this.perPage, this.pageCount, this.pageSelector, this.currentPage, this.next, this.previous, this.segment});

  Pager.fromJson(Map<String, dynamic> json) {
 // uri = json['uri'] != null ? new Uri.fromJson(json['uri']) : null;
  hasMore = json['hasMore'];
  total = json['total'];
  perPage = json['perPage'];
  pageCount = json['pageCount'];
  pageSelector = json['pageSelector'];
  currentPage = json['currentPage'];
  next = json['next'];
  previous = json['previous'];
  segment = json['segment'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  // if (this.uri != null) {
  // data['uri'] = this.uri.toJson();
  // }
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

  // class Uri {
  //
  //
  // Uri();
  //
  // Uri.fromJson(Map<String, dynamic> json) {
  // }
  //
  // Map<String, dynamic> toJson() {
  // final Map<String, dynamic> data = new Map<String, dynamic>();
  // return data;
  // }
  // }

  class Rows {
  String bpNumber;
  String lmcCreatedAt;
  String id;
  String dmaId;
  String actualWorkStart;
  String delayReason;
  String meterType;
  String meterMake;
  String meterNumber;
  String pipe;
  String fittings;
  String meterReading;
  String meterReadingDate;
  String meterPhoto;
  String tfNumber;
  String latitudeTf;
  String longitudeTf;
  String latitudeHg;
  String longitudeHg;
  String workCompletedDate;
  String workCompletedImage;
  String custAckImage;
  String createdAt;
  String updatedAt;
  String custAckDate;
  String feasibilityId;
  String extraPipe;
  String extraPrice;
  String cementingOfHoles;
  String clampingPvc;
  String claminngCopper;
  String meterTesting;
  String paintaingofGIpipe;
  String conversionDate;
  String typeOfNr;
  String ngc;
  String regulators;
  String extraPipeId;
  String isometricImage;
  String isometricDate;
  String pneumaticDate;
  String pneumaticImage;
  String rfcForm;

  Rows({this.bpNumber, this.lmcCreatedAt, this.id, this.dmaId, this.actualWorkStart, this.delayReason, this.meterType, this.meterMake, this.meterNumber, this.pipe, this.fittings, this.meterReading, this.meterReadingDate, this.meterPhoto, this.tfNumber, this.latitudeTf, this.longitudeTf, this.latitudeHg, this.longitudeHg, this.workCompletedDate, this.workCompletedImage, this.custAckImage, this.createdAt, this.updatedAt, this.custAckDate, this.feasibilityId, this.extraPipe, this.extraPrice, this.cementingOfHoles, this.clampingPvc, this.claminngCopper, this.meterTesting, this.paintaingofGIpipe, this.conversionDate, this.typeOfNr, this.ngc, this.regulators, this.extraPipeId, this.isometricImage, this.isometricDate, this.pneumaticDate, this.pneumaticImage, this.rfcForm});

  Rows.fromJson(Map<String, dynamic> json) {
  bpNumber = json['bp_number'] ?? "";
  lmcCreatedAt = json['lmc_created_at'] ?? "";
  id = json['id'] ?? "";
  dmaId = json['dma_id'] ?? "";
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
  createdAt = json['created_at'] ?? "";
  updatedAt = json['updated_at'] ?? "";
  custAckDate = json['cust_ack_date'] ?? "";
  feasibilityId = json['feasibility_id'] ?? "";
  extraPipe = json['extra_pipe'] ?? "";
  extraPrice = json['extra_price'] ?? "";
  cementingOfHoles = json['cementing_of_holes'] ?? "";
  clampingPvc = json['clamping_pvc'] ?? "";
  claminngCopper = json['claminng_copper'] ?? "";
  meterTesting = json['meter_testing'];
  paintaingofGIpipe = json['paintaingofGIpipe']?? "";
  conversionDate = json['conversion_date']?? "";
  typeOfNr = json['type_of_nr']?? "";
  ngc = json['ngc']?? "";
  regulators = json['regulators']?? "";
  extraPipeId = json['extra_pipe_id']?? "";
  isometricImage = json['isometric_image']?? "";
  isometricDate = json['isometric_date']?? "";
  pneumaticDate = json['pneumatic_date']?? "";
  pneumaticImage = json['pneumatic_image']?? "";
  rfcForm = json['rfc_form']?? "";
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['bp_number'] = this.bpNumber;
  data['lmc_created_at'] = this.lmcCreatedAt;
  data['id'] = this.id;
  data['dma_id'] = this.dmaId;
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
  data['created_at'] = this.createdAt;
  data['updated_at'] = this.updatedAt;
  data['cust_ack_date'] = this.custAckDate;
  data['feasibility_id'] = this.feasibilityId;
  data['extra_pipe'] = this.extraPipe;
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
  return data;
  }
  }



class InstallDoneResModel{
  final String schema;
  final String userId;
  InstallDoneResModel({ this.schema,this.userId, });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "schema": schema.trim().toString(),
      "user_id": userId.trim().toString(),
    };
    return map ;
  }
}