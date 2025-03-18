class Apis {

  // static String baseUrl = 'http://pbgpl.smartgasnet.com/api/';
   static String baseUrl = 'https://pbgpluat.smartgasnet.com/api/';
  static String basePath = 'https://pbgpluat.smartgasnet.com/';

  static String loginUrl = baseUrl + "auth";
  static String areaList = baseUrl + "getAllArea?schema=";
  static String getLMCFeasibility = baseUrl + "getlmcapi?";
  static String getLMCInstallation = baseUrl + "getlmcInstallationApi?";
  static String getRFCInstallation = baseUrl + "getlmcRFCInstallationApi?";
  static String getConstant = baseUrl + "getConstant?";
  static String getlmcRFCInstallationApi = baseUrl + "getlmcRFCInstallationApi?";
  static String lmcReason = baseUrl + "lmcreason";
  static String meterReplaceType = baseUrl + "meterreplacetype";
  static String ngcReason = baseUrl + "ngcreason";
  static String regulatorType = baseUrl + "regulatortype";
  static String getMeters = baseUrl + "getMeters?";
  static String getRegulators = baseUrl + "getRegulators?";
  static String getNgcMeters = baseUrl + "getNgcMeters?";
  static String getNgcRegulators = baseUrl + "getNgcRegulators?";
  static String getAllFreeMaterial = baseUrl + "getAllFreeMaterial?";
  static String getAllFreePipeMaterial = baseUrl + "getAllFreePipeMaterial?";
  static String getExtraPipeDetails = baseUrl + "getExtraPipeDetails?";
  static String saveLmcFeasibility = baseUrl + "saveLmcFeasibility";
  static String saveLmcInstallation = baseUrl + "saveLmcInstallation";
  static String saveLmcRFCInstallation  = baseUrl + "saveLmcRFCInstallation";


  static String getLmcInstallationByNgc = baseUrl + 'getlmcInstallationbyNgc?';
  static String setNGCReport = baseUrl + 'setNGCReport';
  static String list = 'getlmcInstallationbyNgc';

}
