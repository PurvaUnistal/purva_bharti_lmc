import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/Utils/common_widgets/res/environment_config.dart';

class ImageWidget extends StatelessWidget {
  final File imgFile;
  final String title;
  final bool isRequired;
  final void Function() onPressed;

  const ImageWidget({
    super.key,
    required this.imgFile,
    required this.title,
    required this.onPressed,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.23;
    final height = MediaQuery.of(context).size.height * 0.12;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔴 Title with required *
        Text.rich(
          TextSpan(
            children: [
              if (isRequired) TextSpan(text: "* ", style: Styles.stars),
              TextSpan(text: title, style: Styles.subTitle),
            ],
          ),
        ),

        const SizedBox(height: 6),

        /// 📦 Image Box
        SizedBox(
          width: width,
          height: height,
          child: InkWell(
            onTap: () {
              if (imgFile.path.isEmpty) {
                onPressed(); // pick image
              } else {
                _showFullImage(context); // preview
              }
            },
            child: Card(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  /// 📷 IMAGE / PLACEHOLDER
                  Positioned.fill(
                    child:
                        imgFile.path.isNotEmpty
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(imgFile, fit: BoxFit.cover),
                            )
                            : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.photo_camera_back_outlined,
                                  color:
                                      EnvironmentConfig.of(
                                        context,
                                      )!.primaryTheme,
                                  size: 20,
                                ),
                                const SizedBox(height: 4),
                                Text(AppString.photo, style: Styles.labels),
                              ],
                            ),
                  ),

                  /// 🔄 PICK / REFRESH BUTTON
                  Positioned(
                    top: -10,
                    right: -10,
                    child: InkWell(
                      onTap: onPressed,
                      child:
                          imgFile.path.isNotEmpty
                              ? Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color:
                                      EnvironmentConfig.of(
                                        context,
                                      )!.primaryTheme,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.refresh,
                                  color: AppColor.white,
                                  size: 16,
                                ),
                              )
                              : SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 🔍 FULL IMAGE VIEW
  void _showFullImage(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => Dialog(
            backgroundColor: Colors.black,
            child: Stack(
              children: [
                InteractiveViewer(
                  child: Center(
                    child: Image.file(imgFile, fit: BoxFit.contain),
                  ),
                ),

                /// ❌ CLOSE BUTTON
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
