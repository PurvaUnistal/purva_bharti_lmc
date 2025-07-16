import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/res/UserContext.dart';
import 'package:lmc/Utils/common_widgets/res/environment_config.dart';
import 'package:lmc/Utils/common_widgets/res/singleton.dart';
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
  bool isLoader =  false;
  String baseUrl = '';
  String installationName = '';
  String feasibilityName = '';
  String pendingNgc = '';
  String accessRightData = '';
  List<Accessright> listOFAccessRight = [];

  int pageIndex = 0;
  int currentIndex = 0;
  List<Widget> pageWidgets  = [];
  List<BottomNavigationBarItem> bottomNavyBarItemList = [];
  static BuildContext? context = Singleton.instanceInit()?.context;

  static final ctx = UserContext.getUserContext();

  _pageLoad(HomeLoadEvent event, emit) async {
    isLoader =  false;

    baseUrl = await EnvironmentConfig.of(context!)!.imageBaseURL;

    listOFAccessRight =  ctx.user.accessright ?? [];
    listOFAccessRight = await listOFAccessRight.toSet().toList();

    listOFAccessRight.sort((a,b) => a.menuCode!.compareTo(b.menuCode!));
    pageIndex = 0;
    currentIndex = 0;
    pageWidgets  = [];
    bottomNavyBarItemList = [];
    pageWidgets.add(
      FeasibilityView(),
    );
    pageWidgets.add(
      LMCInstallationView(),
    );
    bottomNavyBarItemList.add(
        BottomNavigationBarItem(
            label: 'LMC Feasibility',
            icon: Icon(Icons.balance_outlined))
    );
    bottomNavyBarItemList.add(
      BottomNavigationBarItem(
          label: 'LMC Installation',
          icon: Icon(Icons.arrow_circle_down_outlined)),
    );
    _eventCompleted(emit);
  }

  _setPageIndex(HomeSetPageIndex event, emit) {
    pageIndex =  event.pageIndex;
    currentIndex = event.pageIndex;
    print("Current Page No  ==== > ${currentIndex}");
    _eventCompleted(emit);
  }

  _eventCompleted(Emitter<HomeState> emit) {
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
