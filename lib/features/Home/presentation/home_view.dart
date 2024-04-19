import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/app_color.dart';
import 'package:lmc/features/Home/presentation/widget/card_widget.dart';
import 'package:lmc/features/Home/presentation/widget/logout_widget.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/presentation/lmc_feasibility_view.dart';
import 'package:lmc/features/LMC%20Installation/presentation/installation_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: RoutesName.home,
        boolLeading: false,
        actions: [
          IconButton(
              onPressed: () async {
                showModalBottomSheet(context: context, builder: (context) => const LogoutWidget());
              },
              icon: Icon(
                Icons.logout,
                color: AppColor.white,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CardWidget(
              icon: Icons.balance_outlined,
              text: "LMC Feasibility",
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FeasibilityView()));
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            CardWidget(
              icon: Icons.arrow_circle_down_outlined,
              text: "LMC Installation",
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => InstallationView()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
