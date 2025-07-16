import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Login/domain/model/login_model.dart';

abstract class HomeState extends Equatable {}

class HomeInitialState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomePageLoadState extends HomeState {
  @override
  List<Object> get props => [];
}

class FetchHomeDataState extends HomeState {
  final bool isLoader;
  final String baseUrl;
  final String installationName;
  final String pendingNgc;
  final String feasibilityName;
  final int pageIndex;
  final int currentIndex;
  final List<Widget> pageWidgets;
  final List<Accessright> listOFAccessRight;
  final List<BottomNavigationBarItem> bottomNavyBarItemList;

  FetchHomeDataState({
    required this.isLoader,
    required this.baseUrl,
    required this.pageIndex,
    required this.pageWidgets,
    required this.listOFAccessRight,
    required this.installationName,
    required this.feasibilityName,
    required this.pendingNgc,
    required this.currentIndex,
    required this.bottomNavyBarItemList,
  });

  @override
  List<Object> get props => [
    isLoader,
    baseUrl,
    pageIndex,
    installationName,
    feasibilityName,
    pendingNgc,
    currentIndex,
    bottomNavyBarItemList,
    listOFAccessRight,
    pageWidgets,
  ];
}
