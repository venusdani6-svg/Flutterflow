import '/backend/cloud_functions/admin_calls.dart';
import '/components/admin_common/system_settings_config_bridge.dart';
import '/system/system_settings_list_page/system_settings_list_page_model.dart';
import 'package:flutter/material.dart';

class SystemSettingsService {
  static Future<String?> load(SystemSettingsListPageModel model) async {
    try {
      final config = await adminGetSystemConfig();
      SystemSettingsConfigBridge.applyToModel(config, model);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> saveBasic(
    SystemSettingsListPageModel model,
    BuildContext context,
  ) async {
    try {
      await adminUpdateSystemConfig(
        section: 'settings',
        payload: SystemSettingsConfigBridge.buildSettings(model),
      );
      await adminUpdateSystemConfig(
        section: 'features_enabled',
        payload: SystemSettingsConfigBridge.buildFeaturesEnabled(model),
      );
      return _showSaved(context, '基本設定を保存しました');
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> saveRewards(
    SystemSettingsListPageModel model,
    BuildContext context,
  ) async {
    try {
      await adminUpdateSystemConfig(
        section: 'rewards',
        payload: SystemSettingsConfigBridge.buildRewards(model),
      );
      return _showSaved(context, 'キャスト報酬設定を保存しました');
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> saveAffiliate(
    SystemSettingsListPageModel model,
    BuildContext context,
  ) async {
    try {
      await adminUpdateSystemConfig(
        section: 'affiliate',
        payload: SystemSettingsConfigBridge.buildAffiliate(model),
      );
      return _showSaved(context, 'アフィリエイト設定を保存しました');
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> saveServiceAreas(
    SystemSettingsListPageModel model,
    BuildContext context,
  ) async {
    try {
      await adminUpdateSystemConfig(
        section: 'service_areas',
        payload: SystemSettingsConfigBridge.buildServiceAreas(model),
      );
      return _showSaved(context, '提供エリア設定を保存しました');
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> saveTaxi(
    SystemSettingsListPageModel model,
    BuildContext context,
  ) async {
    try {
      await adminUpdateSystemConfig(
        section: 'taxi',
        payload: SystemSettingsConfigBridge.buildTaxi(model),
      );
      return _showSaved(context, 'タクシー代設定を保存しました');
    } catch (e) {
      return e.toString();
    }
  }

  static String? _showSaved(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
    return null;
  }
}
