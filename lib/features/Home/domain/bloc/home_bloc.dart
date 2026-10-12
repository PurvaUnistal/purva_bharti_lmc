import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/res/app_config.dart';
import 'package:lmc/Utils/common_widgets/res/environment_config.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/presentation/lmc_feasibility_view.dart';
import 'package:lmc/features/Home/domain/bloc/home_event.dart';
import 'package:lmc/features/Home/domain/bloc/home_state.dart';
import 'package:lmc/features/Installation/LMCInstallation/presentation/lmc_installation_view.dart';
import 'package:lmc/features/Login/domain/model/login_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeLoadEvent>(_pageLoad);
    on<HomeSetPageIndex>(_setPageIndex);
  }

  bool isLoader = false;
  String baseUrl = '';
  String installationName = '';
  String feasibilityName = '';
  String pendingNgc = '';
  List<Accessright> listOFAccessRight = [];

  int pageIndex = 0;
  int currentIndex = 0;
  List<Widget> pageWidgets = [];
  List<BottomNavigationBarItem> bottomNavyBarItemList = [];

  // REMOVED: static context and static ctx (they kept old data)

  Future<void> _pageLoad(HomeLoadEvent event, Emitter<HomeState> emit) async {
    // 1. Clear old state so old user's data is never shown
    emit(HomeInitialState());

    isLoader = false;

    // 2. Use the context from the event
    baseUrl = EnvironmentConfig.of(event.context)?.imageBaseURL ?? '';

    // 3. Read the CURRENT logged-in user every time
    final user = AppConfig.instanceInit()!.loginData.user;
    final rights = user?.accessright ?? [];

    // 4. Remove duplicates by menuCode
    final seen = <String>{};
    listOFAccessRight =
        rights.where((a) => seen.add(a.menuCode ?? '')).toList();

    // 5. Safe sort (no crash on null)
    listOFAccessRight
        .sort((a, b) => (a.menuCode ?? '').compareTo(b.menuCode ?? ''));

    pageIndex = 0;
    currentIndex = 0;
    pageWidgets = [
      FeasibilityView(),
      LMCInstallationView(),
    ];
    bottomNavyBarItemList = const [
      BottomNavigationBarItem(
          label: 'LMC Feasibility', icon: Icon(Icons.balance_outlined)),
      BottomNavigationBarItem(
          label: 'LMC Installation',
          icon: Icon(Icons.arrow_circle_down_outlined)),
    ];

    _eventCompleted(emit);
  }

  void _setPageIndex(HomeSetPageIndex event, Emitter<HomeState> emit) {
    pageIndex = event.pageIndex;
    currentIndex = event.pageIndex;
    _eventCompleted(emit);
  }

  void _eventCompleted(Emitter<HomeState> emit) {
    emit(FetchHomeDataState(
      isLoader: isLoader,
      baseUrl: baseUrl,
      installationName: installationName,
      feasibilityName: feasibilityName,
      pendingNgc: pendingNgc,
      pageIndex: pageIndex,
      currentIndex: currentIndex,
      bottomNavyBarItemList: bottomNavyBarItemList,
      pageWidgets: pageWidgets,
      listOFAccessRight: listOFAccessRight,
    ));
  }
}