import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
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
  String scheme = '';
  String role = '';
  String userName = '';
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

  _pageLoad(HomeLoadEvent event, emit) async {
    isLoader =  false;
    scheme = await SharedPref.getString(key: PrefsValue.schema);
    role = await SharedPref.getString(key: PrefsValue.userRole);
    userName = await SharedPref.getString(key: PrefsValue.userName);
    baseUrl = await SharedPref.getString(key: PrefsValue.baseUrl);
    feasibilityName = await SharedPref.getString(key: PrefsValue.feasibilityName);
    installationName = await SharedPref.getString(key: PrefsValue.installationName);
    pendingNgc = await SharedPref.getString(key: PrefsValue.pendingNgc);
    var json = await SharedPref.getString(key: PrefsValue.accessRight);
    listOFAccessRight = Accessright.accessrightListFromJson(json);
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
        scheme: scheme,
        baseUrl: baseUrl,
        userName: userName,
        role: role,
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
