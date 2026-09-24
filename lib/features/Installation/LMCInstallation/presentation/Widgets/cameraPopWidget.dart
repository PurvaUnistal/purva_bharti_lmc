import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/res/environment_config.dart';

class CameraPopWidget extends StatelessWidget {
  final void Function() onTapCamera;

  /// Optional texts, so the sheet can say what the photo is for.
  final String title;
  final String subtitle;

  const CameraPopWidget({
    Key? key,
    required this.onTapCamera,
    this.title = 'Take photo',
    this.subtitle = 'Use your camera to capture the image',
  }) : super(key: key);

  /// Convenience helper: CameraPopWidget.show(context, onTapCamera: ...)
  static Future<void> show(
      BuildContext context, {
        required void Function() onTapCamera,
        String title = 'Take photo',
        String subtitle = 'Use your camera to capture the image',
      }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => CameraPopWidget(
        onTapCamera: onTapCamera,
        title: title,
        subtitle: subtitle,
      ),
    );
  }

  static const Color _ink = Color(0xFF1F2A37);
  static const Color _muted = Color(0xFF6B7280);
  static const Color _line = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    final primary = EnvironmentConfig.of(context)?.primaryTheme ??
        Theme.of(context).primaryColor;

    return Padding(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: _line,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // Header
                Text(
                  title,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: _muted, fontSize: 13),
                ),
                const SizedBox(height: 18),

                // Camera option
                Material(
                  color: primary.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(18),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    splashColor: primary.withOpacity(0.12),
                    onTap: onTapCamera,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: primary.withOpacity(0.18)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: primary.withOpacity(0.30),
                                  blurRadius: 12,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.photo_camera_rounded,
                                color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Camera',
                                  style: TextStyle(
                                    color: _ink,
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Open camera and take a new photo',
                                  style:
                                  TextStyle(color: _muted, fontSize: 12.5),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right_rounded,
                              color: primary, size: 26),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Cancel
                SizedBox(
                  height: 48,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    style: TextButton.styleFrom(
                      foregroundColor: _muted,
                      backgroundColor: const Color(0xFFF3F4F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}