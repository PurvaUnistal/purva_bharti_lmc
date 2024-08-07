class Apis {

 //  static String baseUrl = 'http://pbgpl.smartgasnet.com/api/';
  static String baseUrl = 'http://142.79.231.30:8097/api/';
  static String loginUrl = baseUrl + "auth";
   static String areaList = baseUrl + "getAllArea?schema=";
  static String getLMCFeasibility = baseUrl + "getlmcapi?";
  static String getLMCInstallation = baseUrl + "getlmcInstallationApi?";
  static String getRFCInstallation = baseUrl + "getlmcRFCInstallationApi?";
  static String getConstant = baseUrl + "getConstant?";
  static String lmcReason = baseUrl + "lmcreason";
  static String regulatorType = baseUrl + "regulatortype";
  static String getMeters = baseUrl + "getMeters?";
  static String getRegulators = baseUrl + "getRegulators?";
  static String getAllFreeMaterial = baseUrl + "getAllFreeMaterial?";
  static String saveLmcFeasibility = baseUrl + "saveLmcFeasibility";
  static String saveLmcInstallation = baseUrl + "saveLmcInstallation";
  static String saveLmcRFCInstallation  = baseUrl + "saveLmcRFCInstallation";


  static String getLmcInstallationByNgc = baseUrl + 'getlmcInstallationbyNgc?';
  static String setNGCReport = baseUrl + 'setNGCReport';
  static String list = 'getlmcInstallationbyNgc';

}
