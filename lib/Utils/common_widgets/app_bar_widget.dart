import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lmc/Utils/common_widgets/app_color.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? boolLeading;
  final Widget? leadingWidget;
  final List<Widget>? actions;
  final Widget? tabBar;
  const AppBarWidget({Key? key, this.title, this.leadingWidget, this.boolLeading, this.actions, this.tabBar})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: boolLeading ?? false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColor.primer,
      ),
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      backgroundColor: AppColor.primer,
      elevation: 0,
      centerTitle: true,
      leading: leadingWidget,
      title: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Text(
          title ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.none),
        ),
      ),
      actions: actions ?? [],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: AppColor.primer,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(20.0),
        child: SizedBox(
          height: 29,
            child: tabBar ?? Container()),
      ),
    );
  }
}
