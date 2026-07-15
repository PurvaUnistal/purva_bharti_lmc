import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/WidgetStyles/common_style.dart';
import 'package:lmc/Utils/common_widgets/app_update_message_widget.dart';
import 'package:lmc/Utils/common_widgets/background_widget.dart';
import 'package:lmc/Utils/common_widgets/message_box_two_button_pop.dart';
import 'package:lmc/Utils/common_widgets/res/UserContext.dart';
import 'package:lmc/Utils/common_widgets/res/app_asset.dart';
import 'package:lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_config.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/Utils/common_widgets/res/enums.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/presentation/lmc_feasibility_view.dart';
import 'package:lmc/features/Home/domain/bloc/home_bloc.dart';
import 'package:lmc/features/Home/domain/bloc/home_event.dart';
import 'package:lmc/features/Home/domain/bloc/home_state.dart';
import 'package:lmc/features/Home/presentation/widget/card_widget.dart';
import 'package:lmc/features/Home/presentation/widget/logout_widget.dart';
import 'package:lmc/features/Installation/LMCInstallation/presentation/lmc_installation_view.dart';
import 'package:lmc/features/NGC/NGCTable/presentation/ngc_table_view.dart';
import 'package:lmc/service/Apis.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  late final Client _client;

  bool get _isAGCL => _client == Client.agcl;

  @override
  void initState() {
    _client = AppConfig.instanceInit()!.client!;
    BlocProvider.of<HomeBloc>(context).add(HomeLoadEvent(context: context));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callMethodeChannel();
    });
    super.initState();
  }

  static const MethodChannel platform = MethodChannel('pbgpl/lmc');

  callMethodeChannel()  async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String applicationId = packageInfo.packageName;
      String androidPlayStoreUrl =
          "https://play.google.com/store/apps/details?id=$applicationId&hl=en&gl=US";
      final dynamic result = await platform.invokeMethod('getAppUpdate');
      if (Platform.isAndroid) {
        if (kDebugMode) {
          print("Upgrade Message ============== $result");
        }
        if (result.toString() == "success") {
          try {
            AppUpdateMessage.showAlertDialog(
                context: context, url: androidPlayStoreUrl, isLater: false);
          } catch (e) {
            AppUpdateMessage.showAlertDialog(
                context: context, url: androidPlayStoreUrl);
          }
        }
      }
    } on PlatformException catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("buildName-->${AppConfig.instanceInit()?.buildNumber}");
    return WillPopScope(
      onWillPop: () =>_onWillPop(),
      child: Scaffold(
        backgroundColor: AppColor.green50,
        appBar: AppBarWidget(
          title: AppString.lmcMobilityH,
          boolLeading: false,
          actions: [
            IconButton(
                onPressed: () async {
                  showModalBottomSheet(context: context, builder: (context) => const LogoutWidget());
                },
                icon: Icon(
                  Icons.logout,
                  color: AppColor.white,
                ))
          ],
        ),
        body:  SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is FetchHomeDataState) {
                return BackgroundWidget(
                  child: _buildLayout(dataState: state),
                );
                return state.pageWidgets[state.currentIndex];
              } else {
                return const Center(child: SpinLoader());
              }
            },
          ),
        ),
      ),
    );
  }
  Future<bool> _onWillPop() async {
    return (await showDialog(
        context: context,
        builder: (BuildContext mContext) => MessageBoxTwoButtonPopWidget(
            message: "Do you want to exit an App?",
            okButtonText: "Exit",
            onPressed: () => Navigator.of(context).pop(true)))) ??
        false;
  }


  _buildLayout({required FetchHomeDataState dataState}) {
    final ctx = UserContext.getUserContext();
    return ListView(
        children: [
          Image.asset(
            AppConfig.instanceInit()!.client == Client.purvaBharti
                ? AppIcon.pbgplBanner
           : AppConfig.instanceInit()!.client == Client.mahaNagar
            ?AppIcon.mglBanner
            :AppIcon.lmcBanner,
            width: double.infinity,),
          CommonStyle.vertical(context: context),
          CommonStyle.vertical(context: context),
          if (_isAGCL ? ctx.user.role == "feasibility" || ctx.user.role == "lmc" || ctx.user.role == "ngc": ctx.user.role == "lmc" || ctx.user.role == "ngc") ...[
            ...dataState.listOFAccessRight
                .where((access) => ["LMC01", "LMC02", "NGC01"].contains(access.menuCode))
                .map((access) {
              switch (access.menuCode) {
                case "LMC01":
                  return CardWidget(
                    icon: Icons.balance_outlined,
                    text: "LMC Feasibility",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FeasibilityView()),
                      );
                    },
                  );
                case "LMC02":
                  return CardWidget(
                    icon: Icons.arrow_circle_down_outlined,
                    text: "LMC Installation",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LMCInstallationView()),
                      );
                    },
                  );
                case "NGC01":
                  return CardWidget(
                    icon: Icons.sync,
                    text: "NG Conversion",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NgcTableView()),
                      );
                    },
                  );
                default:
                  return const SizedBox.shrink();
              }
            }).toList(),
          ]
        ],

    );
  }
}
