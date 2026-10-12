import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/WidgetStyles/common_style.dart';
import 'package:lmc/Utils/common_widgets/app_update_message_widget.dart';
import 'package:lmc/Utils/common_widgets/background_widget.dart';
import 'package:lmc/Utils/common_widgets/logout_widget.dart';
import 'package:lmc/Utils/common_widgets/message_box_two_button_pop.dart';
import 'package:lmc/Utils/common_widgets/res/app_asset.dart';
import 'package:lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_config.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/enums.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/presentation/lmc_feasibility_view.dart';
import 'package:lmc/features/Home/domain/bloc/home_bloc.dart';
import 'package:lmc/features/Home/domain/bloc/home_event.dart';
import 'package:lmc/features/Home/domain/bloc/home_state.dart';
import 'package:lmc/features/Home/presentation/widget/card_widget.dart';
import 'package:lmc/features/Installation/LMCInstallation/presentation/lmc_installation_view.dart';
import 'package:lmc/features/NGC/NGCTable/presentation/ngc_table_view.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static const MethodChannel platform = MethodChannel('pbgpl/lmc');

  @override
  void initState() {
    super.initState(); // FIX: must be the first line
    context.read<HomeBloc>().add(HomeLoadEvent(context: context));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callMethodeChannel();
    });
  }

  Future<void> callMethodeChannel() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final applicationId = packageInfo.packageName;
      final androidPlayStoreUrl =
          "https://play.google.com/store/apps/details?id=$applicationId&hl=en&gl=US";
      final dynamic result = await platform.invokeMethod('getAppUpdate');
      if (Platform.isAndroid) {
        if (kDebugMode) {
          print("Upgrade Message ============== $result");
        }
        if (result.toString() == "success" && mounted) {
          try {
            AppUpdateMessage.showAlertDialog(
                context: context, url: androidPlayStoreUrl, isLater: false);
          } catch (e) {
            AppUpdateMessage.showAlertDialog(
                context: context, url: androidPlayStoreUrl);
          }
        }
      }
    } on PlatformException catch (_) {
      // ignore
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColor.green50,
        appBar: AppBarWidget(
          title: AppString.lmcMobilityH,
          boolLeading: false,
          actions: [
            IconButton(
              onPressed: () => LogoutWidget.show(context),
              icon: Icon(Icons.logout, color: AppColor.white),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is FetchHomeDataState) {
                return BackgroundWidget(
                  child: _buildLayout(dataState: state),
                );
                // FIX: removed unreachable second return
              }
              return const Center(child: SpinLoader());
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog<bool>(
      context: context,
      builder: (BuildContext mContext) => MessageBoxTwoButtonPopWidget(
        message: "Do you want to exit an App?",
        okButtonText: "Exit",
        onPressed: () => Navigator.of(mContext).pop(true),
      ),
    )) ??
        false;
  }

  Widget _buildLayout({required FetchHomeDataState dataState}) {
    final role =
        AppConfig.instanceInit()!.loginData.user?.role?.toLowerCase() ?? '';
    final client = AppConfig.instanceInit()!.client;

    return ListView(
      children: [
        Image.asset(
          client == Client.purvaBharti
              ? AppIcon.pbgplBanner
              : client == Client.mahaNagar
              ? AppIcon.mglBanner
              : AppIcon.lmcBanner,
          width: double.infinity,
        ),
        CommonStyle.vertical(context: context),
        CommonStyle.vertical(context: context),
        if (role == 'lmc' || role == 'ngc')
          ...dataState.listOFAccessRight
              .where((a) => ['LMC01', 'LMC02', 'NGC01'].contains(a.menuCode))
              .map((access) {
            switch (access.menuCode) {
              case 'LMC01':
                return CardWidget(
                  icon: Icons.balance_outlined,
                  text: 'LMC Feasibility',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FeasibilityView()),
                  ),
                );
              case 'LMC02':
                return CardWidget(
                  icon: Icons.arrow_circle_down_outlined,
                  text: 'LMC Installation',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LMCInstallationView()),
                  ),
                );
              case 'NGC01':
                return CardWidget(
                  icon: Icons.sync,
                  text: 'NG Conversion',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => NgcTableView()),
                  ),
                );
              default:
                return const SizedBox.shrink();
            }
          }),
      ],
    );
  }
}