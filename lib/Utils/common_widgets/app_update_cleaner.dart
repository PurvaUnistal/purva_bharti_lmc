import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/res/app_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SharedPerfs/preference_utils.dart';

/// Step callback: message + progress (0.0 - 1.0)
typedef ClearStepCallback = void Function(String message, double progress);

/// Saara app data clear karne ki ek hi jagah:
/// - App update (Play Store) ke baad: `await AppUpdateCleaner.run();` (main me)
/// - Logout pe: `await AppUpdateCleaner.clearAllData(onStep: ...);`
class AppUpdateCleaner {
  AppUpdateCleaner._();

  static const String _versionKey = 'last_installed_app_version';

  // ---------------------------------------------------------------------------
  // App update check
  // ---------------------------------------------------------------------------

  /// true return karta hai agar data clear hua (yaani app update hua tha).
  ///
  /// [afterClear] optional — agar `clearAllHiveData` boxes ko delete/close
  /// karta hai to yahan boxes dobara open karo.
  static Future<bool> run({Future<void> Function()? afterClear}) async {
    try {
      final currentVersion = await _currentVersion();

      final prefs = await SharedPreferences.getInstance();
      final savedVersion = prefs.getString(_versionKey);

      // Same version -> kuch nahi karna
      if (savedVersion == currentVersion) return false;

      debugPrint('App updated: $savedVersion -> $currentVersion, clearing data');

      await clearAllData(clearAppFiles: true, afterClear: afterClear);
      return true;
    } catch (e) {
      // Version save nahi hua -> agli launch pe dobara try hoga
      debugPrint('AppUpdateCleaner.run failed: $e');
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // Clear all data (logout + update dono yahi use karte hain)
  // ---------------------------------------------------------------------------

  /// Hive + SharedPreferences + Cache + AppConfig clear karta hai,
  /// phir current version wapas save karta hai (taaki agli launch pe
  /// cleaner ko update na lage aur user dobara logout na ho).
  ///
  /// [clearAppFiles] true ho to Documents/Support folder ki loose files bhi hatata hai.
  static Future<void> clearAllData({
    ClearStepCallback? onStep,
    bool clearAppFiles = false,
    Future<void> Function()? afterClear,
  }) async {
    // onStep?.call("Please wait...", 0.2);
    // await _safe("Hive", HiveDataBase.clearAllHiveData);

    onStep?.call("Please wait...", 0.4);
    await _safe("SharedPreferences", SharedPref.clearAll);

    onStep?.call("Please wait...", 0.6);
    await _safe("Cache", deleteCacheDir);

    if (clearAppFiles) {
      onStep?.call("Please wait...", 0.75);
      await _safe("AppFiles", _clearAppDirectories);
    }

    AppConfig.reset();

    if (afterClear != null) {
      await _safe("AfterClear", afterClear);
    }

    // SharedPref.clearAll ne version bhi uda diya tha -> wapas save
    onStep?.call("Please wait...", 0.9);
    await _safe("AppVersion", saveCurrentVersion);

    onStep?.call("Done", 1.0);
    debugPrint("AppUpdateCleaner: saara data clear ho gaya");
  }

  /// Current version SharedPreferences me save karta hai.
  static Future<void> saveCurrentVersion() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    await prefs.setString(_versionKey, await _currentVersion());
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// buildNumber = versionCode, har Play Store release me badhna chahiye
  static Future<String> _currentVersion() async {
    final info = await PackageInfo.fromPlatform();
    return '${info.version}+${info.buildNumber}';
  }

  static Future<void> _safe(String name, Future<void> Function() task) async {
    try {
      await task();
    } catch (e) {
      debugPrint("AppUpdateCleaner [$name] failed: $e");
    }
  }

  /// Memory ka image cache + temp folder ki files clear karta hai.
  static Future<void> deleteCacheDir() async {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();

    final tempDir = await getTemporaryDirectory();
    if (!await tempDir.exists()) return;

    await for (final entity in tempDir.list()) {
      try {
        await entity.delete(recursive: true);
      } catch (e) {
        debugPrint("Cache delete skip: ${entity.path} -> $e");
      }
    }
  }

  /// Documents / Support folder ki sirf files delete karta hai.
  /// Folders skip (Hive ka subfolder ho sakta hai jiski boxes open hain),
  /// Hive files bhi skip — unhe clearAllHiveData handle karta hai.
  static Future<void> _clearAppDirectories() async {
    final dirs = <Directory>[
      await getApplicationDocumentsDirectory(),
      await getApplicationSupportDirectory(),
    ];

    for (final dir in dirs) {
      if (!await dir.exists()) continue;

      await for (final entity in dir.list(followLinks: false)) {
        if (entity is Directory) continue;

        final name = entity.path.split(Platform.pathSeparator).last;
        if (name.contains('.hive') || name.endsWith('.lock')) continue;

        try {
          await entity.delete();
        } catch (e) {
          debugPrint('Skip delete: ${entity.path} -> $e');
        }
      }
    }
  }
}