import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';


class CameraPopWidget extends StatelessWidget {
  final void Function() onTapCamera;
  const CameraPopWidget(
      { Key? key, required this.onTapCamera})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child:
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text('Choose One',textAlign: TextAlign.center, style:Styles.text),),
              Divider(color: AppColor.primer1,),
              ListTile(
                leading: Icon(Icons.photo_camera,color: AppColor.primer),
                title: const Text('Camera'),
                onTap: onTapCamera,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
