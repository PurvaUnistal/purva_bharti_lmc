import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/res/app_asset.dart';
import 'package:lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/features/Home/domain/bloc/home_bloc.dart';
import 'package:lmc/features/Home/domain/bloc/home_event.dart';
import 'package:lmc/features/Home/domain/bloc/home_state.dart';
import 'package:lmc/features/Home/presentation/widget/card_widget.dart';
import 'package:lmc/features/Home/presentation/widget/logout_widget.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/presentation/lmc_feasibility_view.dart';
import 'package:lmc/features/Installation/LMCInstallation/presentation/lmc_installation_view.dart';
import 'package:lmc/service/Apis.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBarWidget(
        title: RoutesName.home,
        boolLeading: false,
        leadingWidget:  Align(
          alignment: Alignment.bottomLeft,
          child: Text("${AppString.release}: ${AppString.reDate}",textAlign: TextAlign.start, style: Styles.rel,
          ),
        ),
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
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is FetchHomeDataState) {
             return _buildLayout(dataState: state);
              return state.pageWidgets[state.currentIndex];
            } else {
              return const Center(child: SpinLoader());
            }
          },
        ),
      ),
     /* bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if(state is FetchHomeDataState){
            return  Container(
                child: BottomNavigationBar(
                  currentIndex: state.currentIndex,
                  onTap: (index) {
                    BlocProvider.of<HomeBloc>(context).add(HomeSetPageIndex(pageIndex: index));
                  },
                  items: state.bottomNavyBarItemList,
                ));
          } else{
            return const SizedBox.shrink();
          }
        },
      ),*/
    );
  }
  _buildLayout({required FetchHomeDataState dataState}){
    return ListView(
      children: [
        Stack(
          children: [
            Image.asset(AssetPath.household,width: double.infinity,),
            Positioned(
                child: Text(dataState.baseUrl == Apis.baseUrl ? "UAT APP" : "", textAlign: TextAlign.end,style: Styles.title,))
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: CardWidget(
                icon: Icons.balance_outlined,
                text: "LMC Feasibility",
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FeasibilityView()));
                },
              ),
            ),
            Flexible(
              child: CardWidget(
                icon: Icons.arrow_circle_down_outlined,
                text: "LMC Installation",
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LMCInstallationView()));

                },
              ),
            ),
          ],
        ),
     //   SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
        /*CardWidget(
          icon: Icons.arrow_circle_down_outlined,
          text: "NGC",
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => NgcTableView()));
          },
        ),*/
      ],

    );
  }
  }

