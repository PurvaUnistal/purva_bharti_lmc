import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/app_bar_widget.dart';

class FeasibilityView extends StatefulWidget {
  const FeasibilityView({super.key});

  @override
  State<FeasibilityView> createState() => _FeasibilityViewState();
}

class _FeasibilityViewState extends State<FeasibilityView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: RoutesName.lmcFeasibility,
        boolLeading: true,
      ),
    );
  }
}
