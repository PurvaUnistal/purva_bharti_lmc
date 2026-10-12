import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/res/app_config.dart';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/features/Login/presentation/login_view.dart';

class LogoutService {
  LogoutService._();

  static Future<void> clearAllData() async {
    await _run('SharedPreferences', () => SharedPref.clearAll());

    await _run('AppConfig', () async {
      AppConfig.instanceInit()?.clear();
    });

    await _run('Image cache', () async {
      PaintingBinding.instance.imageCache
        ..clear()
        ..clearLiveImages();
    });

    await _run('Temporary / cache directory', () async {
      await _emptyDirectory(await getTemporaryDirectory());
    });

    await _run('App support directory', () async {
      await _emptyDirectory(await getApplicationSupportDirectory());
    });

    // Documents directory holds user-saved files (downloads, PDFs, etc.).
    // Keep this if those files belong to the user account; remove it if
    // they should survive a logout.
    await _run('Documents directory', () async {
      await _emptyDirectory(await getApplicationDocumentsDirectory());
    });

    // ---- Optional: enable the ones your app uses ----

    // Network image cache (cached_network_image / flutter_cache_manager)
    // await _run('Network cache', () => DefaultCacheManager().emptyCache());

    // Secure storage (tokens, passwords)
    // await _run('Secure storage', () => const FlutterSecureStorage().deleteAll());

    // Hive boxes
    // await _run('Hive', () async {
    //   await Hive.deleteFromDisk();
    // });

    // sqflite: close your DB first, then delete the file
    // await _run('SQLite', () async {
    //   await AppDatabase.instance.close();
    //   await deleteDatabase(join(await getDatabasesPath(), 'app.db'));
    // });
  }

  /// Deletes everything inside [dir] but keeps the folder itself,
  /// because the OS expects these directories to exist.
  static Future<void> _emptyDirectory(Directory dir) async {
    if (!await dir.exists()) return;
    await for (final entity in dir.list(followLinks: false)) {
      try {
        await entity.delete(recursive: true);
      } catch (e) {
        debugPrint('Logout: could not delete ${entity.path}: $e');
      }
    }
  }

  static Future<void> _run(String label, Future<void> Function() task) async {
    try {
      await task();
      debugPrint('Logout: cleared $label');
    } catch (e) {
      debugPrint('Logout: failed to clear $label: $e');
    }
  }
}



/// Call this from anywhere to open the logout sheet.
Future<void> showLogoutSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.45),
    builder: (_) => const LogoutWidget(),
  );
}

class LogoutWidget extends StatefulWidget {
  const LogoutWidget({super.key});

  @override
  State<LogoutWidget> createState() => _LogoutWidgetState();
}

class _LogoutWidgetState extends State<LogoutWidget> {
  bool _loading = false;

  static const _danger = Color(0xFFD64545);

  Future<void> _logout() async {
    setState(() => _loading = true);
    await LogoutService.clearAllData();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginView()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 28),

              // Icon badge
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: _danger.withOpacity(0.10),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.logout_rounded, color: _danger, size: 34),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                '${AppString.logout}?',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),

              // Message
              Text(
                AppString.logoutMsg,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 28),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _loading ? null : () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(AppString.no),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: _loading ? null : _logout,
                      style: FilledButton.styleFrom(
                        backgroundColor: _danger,
                        disabledBackgroundColor: _danger.withOpacity(0.6),
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: _loading
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: Colors.white,
                        ),
                      )
                          : Text(
                        AppString.logout,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}