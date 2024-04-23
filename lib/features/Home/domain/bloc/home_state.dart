import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
  final int pageIndex;
  final int currentIndex;
  final List<Widget> pageWidgets;
  final List<BottomNavigationBarItem> bottomNavyBarItemList;
  FetchHomeDataState({required this.isLoader, required this.pageIndex,
    required this.pageWidgets,
    required this.currentIndex,
    required this.bottomNavyBarItemList});
  @override
  List<Object> get props => [isLoader, pageIndex, currentIndex, bottomNavyBarItemList, pageWidgets];
}