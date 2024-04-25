import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/app_color.dart';
import 'package:lmc/features/InternetConnection/domain/bloc/network_bloc.dart';
import 'package:lmc/features/InternetConnection/domain/bloc/network_event.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/MeterInstallation/presentation/meter_installation_view.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/RFCSection/presentation/rfc_section_view.dart';

class InstallationView extends StatefulWidget {
  const InstallationView({super.key});

  @override
  State<InstallationView> createState() => _InstallationViewState();
}

class _InstallationViewState extends State<InstallationView> {

  @override
  void initState() {
    BlocProvider.of<NetworkBloc>(context)
        .add(NetworkObserveEvent(context: context));
    super.initState();
  }


  final List<String> _tabs = <String>[
    RoutesName.meterInstallation,
    RoutesName.rfcSection,
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: DefaultTabController(
          length: _tabs.length,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100.0),
              child: AppBarWidget(
                boolLeading: true,
                title: RoutesName.lmcInstallation,
                tabBar: TabBar(
                  indicatorColor: AppColor.primer1,
                  labelColor: AppColor.white,
                  unselectedLabelColor:  AppColor.grey,
                    indicatorWeight: 5,
                  tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                ),
              ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
            //  controller: _tabController,
              children: <Widget>[
                MeterInstallationView(),
                RFCSectionView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}