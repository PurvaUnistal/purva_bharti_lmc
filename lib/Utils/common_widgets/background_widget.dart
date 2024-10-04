import 'package:flutter/material.dart';
import 'package:new_lmc/Utils/common_widgets/res/app_color.dart';
import 'package:new_lmc/Utils/common_widgets/res/app_string.dart';
import 'package:new_lmc/Utils/common_widgets/res/app_styles.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  const BackgroundWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child,
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  decoration: BoxDecoration(color: AppColor.primer),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Text(
                          AppString.companyName,
                          textAlign: TextAlign.start,
                          style: Styles.rel,
                        )),
                        Flexible(
                            child: Text(
                              AppString.version,
                              textAlign: TextAlign.start,
                              style: Styles.rel,
                            )),
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}
