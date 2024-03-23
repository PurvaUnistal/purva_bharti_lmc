class GlobalConstants {
  static String isUserLogIn = "IsUserLogIn";
  static String username = "username";
  static String password = "password";
  static String token = "token";
  static String id = "id";
  static String lmcId = "lmcId";
  static String role = "role";
  static String changePassword = "changePassword";
  static String schema = "schema";
  static String name = "name";
  static String bpNumber = "bp Number";
  static String dmaId = "DMA ID";
  static String lmcProposedDate = "LMC Proposed Date";


  static const String BaseUrl = "http://142.79.231.30:8097/api/";
//  static const String BaseUrl = "http://pbgpl.smartgasnet.com/api/";
  static String login = BaseUrl + "auth";
  static String getLmcApi = BaseUrl + "getlmcapi";
  static String getlmcInstallationApi = BaseUrl + "getlmcInstallationApi";
  static String getFreeMaterialApi = BaseUrl + "getAllFreeMaterial?schema=";
  static String getExtraPipeDetails = BaseUrl + "getExtraPipeDetails";
  static String postFeasibilityDataApi = BaseUrl + "saveLmcFeasibility";
  static String saveLmcInstallation = BaseUrl + "saveLmcInstallation";
  // static String getMeters           = BaseUrl+"getMeters?schema=meterSerial=dia&user_id=12" ;
  static String getMeters = BaseUrl + "getMeters?schema=";
  static String getRegulators = BaseUrl + "getRegulators?schema=";
  static String getLabels = BaseUrl + "getLabel";
  static String hpclLabels = "HPCL_Labels";
  static String isFeasible = '$BaseUrl' + "/getConstant?key=is_feasible";
  static String lmcReason = '$BaseUrl' + "/getConstant?key=lmcReason";
  static String getRfc = '$BaseUrl' + "/getConstant?key=rfc";
  static String getReadyForNgc =
      '$BaseUrl' + "/getConstant?key=isCustomerReadyForNgc";
  static String getTypeOfNr = '$BaseUrl' + "/getConstant?key=typeOfNr";

  static String getAllArea = BaseUrl + "getAllArea";
  static String getNgcList = BaseUrl + "getlmcInstallationbyNgc?";
  static String saveNgcReport = BaseUrl + "setNGCReport";
  static String getConstant = BaseUrl + "getConstant";

  static String areaList = BaseUrl + "getAllArea?schema=";
  static String getLmcInstallationDone = BaseUrl + "getlmcInstallationdone?";
  static String updateLMCInstallationImages =
      BaseUrl + "UpdateLMCInstallationImages";
  static String getLmcFeasibilityAPI = BaseUrl + "getlmcFeasibilityAPI";
  static String resetPassword = BaseUrl + "resetpassword";
}
