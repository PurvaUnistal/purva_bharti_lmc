import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class HomeEvent extends Equatable{}

class HomeLoadEvent extends HomeEvent {
  final BuildContext context;
  HomeLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class HomeSetPageIndex extends HomeEvent {
  final int pageIndex;
  HomeSetPageIndex({required this.pageIndex});
  @override
  List<Object?> get props => [pageIndex];
}