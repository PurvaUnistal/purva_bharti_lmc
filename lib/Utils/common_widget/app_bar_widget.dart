import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widget/app_color.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const AppBarWidget(
      {Key? key,
      required this.title,
       this.actions})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
          color: Colors.white
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColor.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.none),
        ),
      ),
      actions: actions ?? [],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[AppColor.primer, AppColor.primer1]),
        ),
      ),
    );
  }
}
