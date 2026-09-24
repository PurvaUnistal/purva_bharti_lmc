import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';

import 'res/environment_config.dart';

class ButtonWidget extends StatefulWidget {
  final Function() onPressed;
  final String text;
  final IconData? icon;
  final bool isLoading;
  final bool enabled;
  final EdgeInsetsGeometry padding;

  const ButtonWidget({
    Key? key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.isLoading = false,
    this.enabled = true,
    this.padding = const EdgeInsets.all(8.0),
  }) : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool _pressed = false;

  static const double _height = 50;
  static const double _radius = 14;

  bool get _active => widget.enabled && !widget.isLoading;

  void _setPressed(bool value) {
    if (_active && _pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final config = EnvironmentConfig.of(context)!;
    final primary = config.primaryTheme;
    final secondary = config.secondaryTheme;

    final colors = widget.enabled
        ? [secondary, primary]
        : [const Color(0xFFD1D5DB), const Color(0xFFC4C8CE)];

    return Padding(
      padding: widget.padding,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: _height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: colors,
            ),
            borderRadius: BorderRadius.circular(_radius),
            boxShadow: widget.enabled
                ? [
              BoxShadow(
                color: primary.withValues(alpha: _pressed ? 0.18 : 0.30),
                blurRadius: _pressed ? 6 : 14,
                offset: Offset(0, _pressed ? 2 : 6),
              ),
            ]
                : [],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(_radius),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              splashColor: Colors.white.withValues(alpha: 0.18),
              highlightColor: Colors.white.withValues(alpha: 0.06),
              onTapDown: (_) => _setPressed(true),
              onTapUp: (_) => _setPressed(false),
              onTapCancel: () => _setPressed(false),
              onTap: _active
                  ? () {
                HapticFeedback.lightImpact();
                widget.onPressed();
              }
                  : null,
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: widget.isLoading
                      ? const SizedBox(
                    key: ValueKey('loading'),
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: Colors.white,
                    ),
                  )
                      : Padding(
                    key: const ValueKey('label'),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(widget.icon,
                              color: Colors.white, size: 20),
                          const SizedBox(width: 8),
                        ],
                        Flexible(
                          child: Text(
                            widget.text,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: Styles.btnText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}