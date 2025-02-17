import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/WidgetStyles/common_style.dart';
import 'package:lmc/Utils/common_widgets/app_update_message_widget.dart';
import 'package:lmc/Utils/common_widgets/background_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_asset.dart';
import 'package:lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
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
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    _checkForUpdate();
    BlocProvider.of<HomeBloc>(context).add(HomeLoadEvent(context: context));
    super.initState();
  }


  Future<void> _checkForUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String oldVersion = await SharedPref.getString(key: PrefsValue.appVersion);
    String currentVersion = packageInfo.version;
    print("oldVersion-->${oldVersion}");
    print("currentVersion-->${currentVersion}");

    if (_isVersionOutdated(oldVersion,currentVersion)) {
      print("oldVersion-->${oldVersion}");
      print("currentVersion-->${currentVersion}");
      _showUpdateDialog();
    }
  }

  bool _isVersionOutdated(String currentVersion, String latestVersion) {
    List<int> current = currentVersion.split('.').map(int.parse).toList();
    List<int> latest = latestVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < latest.length; i++) {
      if (current.length <= i || current[i] < latest[i]) {
        return true;
      } else if (current[i] > latest[i]) {
        return false;
      }
    }
    return false;
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return  AppUpdateMessage.showAlertDialog(context: context,onPressed: _openAppStoreLink,);
      },
    );
  }


  void _openAppStoreLink() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String applicationId = packageInfo.packageName.toString();
    String androidPlayStoreUrl =
        "https://play.google.com/store/apps/details?id=${applicationId}&hl=en&gl=US";
    String url =androidPlayStoreUrl;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: SafeArea(
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
      /* bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if(state is FetchHomeDataState){
            return  Container(
                child: BottomNavigationBar(
                  currentIndex: state.currentIndex,
                  onTap: (index) {
                    BlocProvider.of<HomeBloc>(context).add(HomeSetPageIndex(pageIndex: index));
                  },
                  items: state.bottomNavyBarItemList,
                ));
          } else{
            return const SizedBox.shrink();
          }
        },
      ),*/
    );
  }

  _buildLayout({required FetchHomeDataState dataState}) {
    return Scaffold(
      backgroundColor: AppColor.green50,
      appBar: AppBarWidget(
        title: AppString.lmcMobilityH,
        boolLeading: false,
        leadingWidget: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dataState.userName,
              textAlign: TextAlign.start,
              style: Styles.rel,
            ),
            Text(
              dataState.scheme,
              textAlign: TextAlign.start,
              style: Styles.rel,
            )
          ],
        ),
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
      body: ListView(
        children: [
          Stack(
            children: [
              Image.asset(
                AssetPath.lmcBanner, width: double.infinity,),
              Positioned(
                  child: Text(
                    dataState.baseUrl == Apis.basePath ? "UAT APP" : "",
                    textAlign: TextAlign.end,
                    style: Styles.title,
                  )
              )
            ],
          ),
          CommonStyle.vertical(context: context),
          CommonStyle.vertical(context: context),
          if(dataState.role == "lmc")...[
            for(int i = 0; i < dataState.listOFAccessRight.length; i++)...[
              dataState.listOFAccessRight[i].menuCode == "LMC01" ? CardWidget(
                icon: Icons.balance_outlined,
                text: "LMC Feasibility",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => FeasibilityView()));
                },
              )
                  : Container(),
              dataState.listOFAccessRight[i].menuCode == "LMC02" ? CardWidget(
                icon: Icons.arrow_circle_down_outlined,
                text: "LMC Installation",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LMCInstallationView()));
                },
              )
                  : Container(),
              dataState.listOFAccessRight[i].menuCode == "NGC01" ?
              CardWidget(
                icon: Icons.sync,
                text: "NG Conversion",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NgcTableView()));
                },
              )
                  : Container()
            ],
          ] else if(dataState.role == "ngc")...[
            for(int i = 0; i < dataState.listOFAccessRight.length; i++)...[
              dataState.listOFAccessRight[i].menuCode == "LMC01" ? CardWidget(
                icon: Icons.balance_outlined,
                text: "LMC Feasibility",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => FeasibilityView()));
                },
              )
                  : Container(),
              dataState.listOFAccessRight[i].menuCode == "LMC02" ? CardWidget(
                icon: Icons.arrow_circle_down_outlined,
                text: "LMC Installation",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LMCInstallationView()));
                },
              )
                  : Container(),
              dataState.listOFAccessRight[i].menuCode == "NGC01" ?
              CardWidget(
                icon: Icons.arrow_circle_down_outlined,
                text: "NG Conversion",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NgcTableView()));
                },
              )
                  : Container()
            ],
          ]
        ],
      ),
    );
  }
}
