import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/app_color.dart';
import 'package:lmc/Utils/common_widgets/styles_widget.dart';

class CardWidget extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;
  final String text;
  const CardWidget({super.key,required this.onTap, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: AppColor.primer1,),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                  Text(text,style: Styles.labels,),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color:   AppColor.primer1
              ),
            ],
          ),
        ),
      ),
    );
  }
}
