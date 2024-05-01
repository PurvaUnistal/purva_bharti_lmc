import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/app_color.dart';
import 'package:lmc/Utils/common_widgets/app_string.dart';
import 'package:lmc/Utils/common_widgets/styles_widget.dart';
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
        leadingWidget: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppString.release,style: Styles.rel,),
            Text(AppString.reDate,style: Styles.rel,),
          ],
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

//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
// import 'package:lmc/features/Home/domain/bloc/home_bloc.dart';
// import 'package:lmc/features/Home/domain/bloc/home_event.dart';
// import 'package:lmc/features/Home/domain/bloc/home_state.dart';
// import 'package:lmc/features/InternetConnection/domain/bloc/network_bloc.dart';
// import 'package:lmc/features/InternetConnection/domain/bloc/network_event.dart';
//
//
// class HomeView extends StatefulWidget {
//   const HomeView({Key? key}) : super(key: key);
//   @override
//   State<HomeView> createState() => _HomeViewState();
// }
//
// class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
//
//   @override
//   void initState() {
//     BlocProvider.of<NetworkBloc>(context)
//         .add(NetworkObserveEvent(context: context));
//     BlocProvider.of<HomeBloc>(context).add(HomeLoadEvent(context: context));
//     super.initState();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<HomeBloc, HomeState>(
//         builder: (context, state) {
//           if(state is HomePageLoadState) {
//             return Center(child: SpinLoader(),);
//           } else if( state is FetchHomeDataState){
//             return state.pageWidgets[state.currentIndex];
//           }else {
//             return const SizedBox.shrink();
//           }
//         },
//       ),
//       bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
//         builder: (context, state) {
//           if(state is FetchHomeDataState){
//             return  Container(
//                 child: BottomNavigationBar(
//                   currentIndex: state.currentIndex,
//                   onTap: (index) {
//                     BlocProvider.of<HomeBloc>(context).add(HomeSetPageIndex(pageIndex: index));
//                   },
//                   items: state.bottomNavyBarItemList,
//                 ));
//           } else{
//             return const SizedBox.shrink();
//           }
//         },
//       ),
//     );
//   }
//
// }