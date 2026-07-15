import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_config.dart';
import 'environment_config.dart';

class AppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final bool? boolLeading;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? tabBar;

  const AppBarWidget({
    super.key,
    this.title,
    this.leading,
    this.boolLeading,
    this.actions,
    this.tabBar,
  });

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (tabBar?.preferredSize.height ?? 0),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final double logoSize = size.width * 0.10;
    final double titleFont = size.width * 0.032;
    final double subTitleFont = size.width * 0.022;

    // Null-safe: on the login page (or anywhere before login completes),
    // loginData.user will be null. Everything below degrades gracefully
    // instead of throwing "Null check operator used on a null value".
    final user = AppConfig.instanceInit()?.loginData.user;

    return AppBar(
      automaticallyImplyLeading: boolLeading ?? true,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      elevation: 0,
      centerTitle: true,
      leading: leading,
      actions: actions,
      bottom: tabBar,

      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              EnvironmentConfig.of(context)!.primaryTheme,
              EnvironmentConfig.of(context)!.secondaryTheme,
            ],
          ),
        ),
      ),

      titleSpacing: 0,

      title: Row(
        children: [
          _logoContainer(
            context,
            user?.projectLogo,
            logoSize,
          ),
          SizedBox(width: size.width * 0.02),
          Expanded(
            child: Text(
              title ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleFont,
                fontWeight: FontWeight.w700,
                color: AppColor.white,
              ),
            ),
          ),

          SizedBox(width: size.width * 0.02),
          _logoContainer(
            context,
            user?.smartLogo,
            logoSize,
          ),

          SizedBox(width: size.width * 0.01),
        ],
      ),
    );
  }

  Widget _logoContainer(
      BuildContext context,
      String? url,
      double size,
      ) {
    final hasUrl = url != null && url.trim().isNotEmpty;

    // No URL at all -> render nothing, not even the white box.
    if (!hasUrl) {
      return const SizedBox.shrink();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.15)
            : Colors.white,
        borderRadius: BorderRadius.circular(size * 0.2),
      ),
      padding: const EdgeInsets.all(3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.2),
        child: Image.network(
          url,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: SizedBox(
                width: size * 0.4,
                height: size * 0.4,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: isDark ? Colors.white : AppColor.white,
                ),
              ),
            );
          },
          errorBuilder: (_, __, ___) {
            // URL was provided but failed to load (404, network error, etc).
            // Only NOW do we fall back to showing a small placeholder box,
            // since a broken image is different from "no image expected".
            return Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.15)
                    : Colors.white,
                borderRadius: BorderRadius.circular(size * 0.2),
              ),
              child: const Icon(
                Icons.image_not_supported,
                size: 18,
              ),
            );
          },
        ),
      ),
    );
  }
}
