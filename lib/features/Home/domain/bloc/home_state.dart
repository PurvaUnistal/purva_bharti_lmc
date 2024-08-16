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
  final String scheme;
  final String userName;
  final String baseUrl;
  final String installationName;
  final String feasibilityName;
  final int pageIndex;
  final int currentIndex;
  final List<Widget> pageWidgets;
  final List<BottomNavigationBarItem> bottomNavyBarItemList;
  FetchHomeDataState({
    required this.isLoader,
    required this.scheme,
    required this.baseUrl,
    required this.userName,
    required this.pageIndex,
    required this.pageWidgets,
    required this.installationName,
    required this.feasibilityName,
    required this.currentIndex,
    required this.bottomNavyBarItemList});
  @override
  List<Object> get props => [
    isLoader,
    scheme,
    userName,
    baseUrl,
    pageIndex,
   installationName,
  feasibilityName,
    currentIndex,
    bottomNavyBarItemList,
    pageWidgets];
}