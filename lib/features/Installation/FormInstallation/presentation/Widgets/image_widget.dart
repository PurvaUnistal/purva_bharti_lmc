import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/enlarge_widge.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
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
    this.isRequired = false,
    required this.title,
    required this.onPressed,
  });

  bool _isNetworkPath(String path) =>
      path.startsWith('http://') || path.startsWith('https://');

  Color _accent(BuildContext c) =>
      EnvironmentConfig.of(c)?.primaryTheme ?? Theme.of(c).primaryColor;

  @override
  Widget build(BuildContext context) {
    // Compact: small fixed height (just enough to see the image),
    // width fills the available space (it's inside Expanded in the form).
    const double boxHeight = 70;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              if (isRequired) TextSpan(text: "* ", style: Styles.stars),
              TextSpan(text: title,   style: Styles.subTitle.copyWith(color: _accent(context))),
            ],
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: double.infinity,
          height: boxHeight,
          child: InkWell(
            onTap: onPressed,
            child: _dottedBox(
              context: context,
              child: imgFile.path.isEmpty
                  ? _placeholder(context)
                  : Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: _buildImage(context: context),
                  ),
                  Positioned(
                    top: -8,
                    right: -8,
                    child: Material(
                      color: _accent(context),
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => _showEnlarged(context),
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.zoom_out_map,
                            color: AppColor.white,
                            size: 16,
                          ),
                        ),
                      ),
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

  // Dashed border drawn manually — no external package, version-proof.
  Widget _dottedBox({required BuildContext context, required Widget child}) {
    return CustomPaint(
      painter: _DashedBorderPainter(color: _accent(context)),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: SizedBox.expand(child: child),
      ),
    );
  }

  Future<void> _showEnlarged(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => EnlargeWidget(text: title, photoPath: imgFile),
    );
  }

  Widget _buildImage({required BuildContext context}) {
    if (_isNetworkPath(imgFile.path)) {
      return Image.network(
        imgFile.path,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (context, child, progress) => progress == null
            ? child
            : const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        errorBuilder: (_, __, ___) => _placeholder(context),
      );
    }
    return Image.file(
      imgFile,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, __, ___) => _placeholder(context),
    );
  }

  Widget _placeholder(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.photo_camera_back_outlined,
          color: _accent(context),
          size: 18,
        ),
        Text("Photo", style: Styles.labels),
      ],
    );
  }
}

/// Paints a dashed rounded-rectangle border.
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dash;
  final double gap;
  final double radius;

  _DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.dash = 5.0,
    this.gap = 3.0,
    this.radius = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final source = Path()..addRRect(rrect);

    final dashed = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        dashed.addPath(
          metric.extractPath(distance, distance + dash),
          Offset.zero,
        );
        distance += dash + gap;
      }
    }
    canvas.drawPath(dashed, paint);
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter old) =>
      old.color != color ||
          old.strokeWidth != strokeWidth ||
          old.dash != dash ||
          old.gap != gap ||
          old.radius != radius;
}