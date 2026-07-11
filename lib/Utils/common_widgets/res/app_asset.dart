import 'app_config.dart';
import 'enums.dart';

class AppIcon {

  static logo(){
    return AppConfig.instanceInit()!.client == Client.purvaBharti
        ? AppIcon.pbgplLogo
        :AppConfig.instanceInit()!.client == Client.mahaNagar
        ? AppIcon.mglLogo
        :AppConfig.instanceInit()!.client == Client.hpoil
        ? AppIcon.hpOilLogo
        :AppConfig.instanceInit()!.client == Client.vppl
        ? AppIcon.vpplLogo
        :AppConfig.instanceInit()!.client == Client.vrpl
        ? AppIcon.vrplLogo
        :AppConfig.instanceInit()!.client == Client.agcl
        ? AppIcon.agclLogo
        :AppConfig.instanceInit()!.client == Client.hpcl
        ? AppIcon.hpclLogo
        : AppIcon.unistalLogo;
  }
  static String pbgplLogo = 'assets/icons/pbg_logo.png';
  static String mglLogo = 'assets/icons/mgl_logo.png';
  static String hpclLogo = 'assets/icons/hpcl_logo.png';
  static String agclLogo = 'assets/icons/agcl_logo.png';
  static String oilIndiaLogo = 'assets/icons/oil_india_logo.png';
  static String hpOilLogo = 'assets/icons/hp_oil_logo.png';
  static String vpplLogo = 'assets/icons/vppl_plcms.png';
  static String vrplLogo = 'assets/icons/vrpl_plcms.png';
  static String unistalLogo = 'assets/icons/unistal_logo.png';
  static String pbgplBanner = 'assets/icons/lmc-banner1.png';
  static String mglBanner = 'assets/icons/mgl_banner.png';
  static String lmcBanner = 'assets/icons/lmc_banner.png';
}