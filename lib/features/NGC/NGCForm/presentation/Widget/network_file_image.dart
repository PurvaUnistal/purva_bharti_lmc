import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/enlarge_widge.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/Utils/common_widgets/res/environment_config.dart';

class NetworkImageWidget extends StatelessWidget {
  final String title;
  final String? star;
  final String baseUrl;
  final File networkPath;
  final void Function() onPressed;

  const NetworkImageWidget({
    super.key,
    this.star,
    required this.baseUrl,
    required this.title,
    required this.onPressed,
    required this.networkPath,
  });

  bool get _isRequired => (star ?? '').trim().isNotEmpty;

  bool get _isNetwork =>
      baseUrl.isNotEmpty &&
          (networkPath.path.startsWith('http://') ||
              networkPath.path.startsWith('https://'));

  Color _accent(BuildContext c) =>
      EnvironmentConfig.of(c)?.primaryTheme ?? Theme.of(c).primaryColor;

  @override
  Widget build(BuildContext context) {
    const double boxHeight = 70;

    // Fills the available width when wrapped in Flexible/Expanded.
    // In a plain Row (unbounded width) it falls back to 23% of the screen.
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width * 0.23;

        return SizedBox(
          width: width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    if (_isRequired)
                      TextSpan(text: '${star!.trim()} ', style: Styles.stars),
                    TextSpan(
                      text: title,
                      style: Styles.subTitle
                          .copyWith(color: _accent(context)),
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                height: boxHeight,
                child: InkWell(
                  onTap: onPressed,
                  child: _dottedBox(
                    context: context,
                    child: networkPath.path.isEmpty
                        ? _placeholder(context)
                        : Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: _buildImage(context),
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
                                padding: const EdgeInsets.all(4),
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
          ),
        );
      },
    );
  }

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
      builder: (_) => EnlargeWidget(text: title, photoPath: networkPath),
    );
  }

  Widget _buildImage(BuildContext context) {
    if (_isNetwork) {
      return Image.network(
        networkPath.path,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (context, child, progress) => progress == null
            ? child
            : const Center(
          child: SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorBuilder: (_, __, ___) => _placeholder(context),
      );
    }
    return Image.file(
      networkPath,
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
        Text(AppString.photo, style: Styles.labels),
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

    final source = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Offset.zero & size,
        Radius.circular(radius),
      ));

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