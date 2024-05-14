import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/presentation/lmc_feasibility_view.dart';
import 'package:lmc/features/Home/domain/bloc/home_event.dart';
import 'package:lmc/features/Home/domain/bloc/home_state.dart';
import 'package:lmc/features/LMC%20Installation/presentation/installation_view.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  bool _isLoader =  false;
  bool get isLoader => _isLoader;

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  List<BottomNavigationBarItem> _bottomNavyBarItemList = [];
  List<BottomNavigationBarItem> get bottomNavyBarItemList => _bottomNavyBarItemList;

  List<Widget> _pageWidgets  = [];
  List<Widget> get pageWidgets  => _pageWidgets;

  HomeBloc() : super(HomeInitialState()) {
    on<HomeLoadEvent>(_pageLoad);
    on<HomeSetPageIndex>(_setPageIndex);
  }

  _pageLoad(HomeLoadEvent event, emit) {
    _pageIndex = 0;
    _isLoader =  false;
    _currentIndex = 0;
    _pageWidgets  = [];
    _bottomNavyBarItemList = [];
    _pageWidgets.add(
      FeasibilityView(),
    );
    _pageWidgets.add(
      InstallationView(),
    );
    _bottomNavyBarItemList.add(
        BottomNavigationBarItem(
            label: 'LMC Feasibility',
            icon: Icon(Icons.balance_outlined))
    );
    _bottomNavyBarItemList.add(
      BottomNavigationBarItem(
          label: 'LMC Installation',
          icon: Icon(Icons.arrow_circle_down_outlined)),
    );
    _eventCompleted(emit);
  }

  _setPageIndex(HomeSetPageIndex event, emit) {
    _pageIndex =  event.pageIndex;
    _currentIndex = event.pageIndex;
    print("Current Page No  ==== > ${currentIndex}");
    _eventCompleted(emit);
  }

  _eventCompleted(Emitter<HomeState> emit) {
    emit(FetchHomeDataState(
        isLoader: isLoader,
        pageIndex: pageIndex,
        currentIndex: currentIndex,
        bottomNavyBarItemList: bottomNavyBarItemList,
        pageWidgets: pageWidgets
    ));
  }
}
