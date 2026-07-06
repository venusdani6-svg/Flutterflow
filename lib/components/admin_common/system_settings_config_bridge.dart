import '/system/system_settings_list_page/system_settings_list_page_model.dart';

/// Maps [SystemSettingsListPageModel] fields ↔ `system_config` API sections.
class SystemSettingsConfigBridge {
  static const prefectureNames = [
    '東京都',
    '千葉県',
    '神奈川県',
    '岐阜県',
    '愛知県',
    '京都府',
    '大阪府',
    '兵庫県',
    '岡山県',
    '広島県',
    '福岡県',
  ];

  static void applyToModel(
    Map<String, dynamic>? config,
    SystemSettingsListPageModel model,
  ) {
    if (config == null) {
      return;
    }
    final settings = _map(config['settings']);
    final features = _map(config['features_enabled']);
    final rewards = _map(config['rewards']);
    final affiliate = _map(config['affiliate']);
    final taxi = _map(config['taxi']);
    final areas = config['service_areas'];

    model.textController1?.text =
        '${settings['extension_max_count'] ?? settings['extension_max'] ?? ''}';
    model.textController2?.text = '${settings['chat_close_sec'] ?? ''}';
    model.countControllerValue1 =
        _int(settings['extension_min_count'] ?? settings['extension_min']);
    model.countControllerValue2 =
        _int(settings['extension_max_count'] ?? settings['extension_max']);

    final slots = settings['night_time_slots'];
    if (slots is List) {
      model.checkboxListTileValue1 = slots.contains(1) || slots.contains('1');
      model.checkboxListTileValue2 = slots.contains(2) || slots.contains('2');
      model.checkboxListTileValue3 = slots.contains(3) || slots.contains('3');
      model.checkboxListTileValue4 = slots.contains(4) || slots.contains('4');
    }

    model.switchListTileValue1 =
        features['staff_security'] ?? features['staff'] ?? true;
    model.switchListTileValue2 = features['staff_shuttle'] ?? true;
    model.switchListTileValue3 = features['affiliate'] ?? true;
    model.switchListTileValue4 = features['cocoten'] ?? false;

    model.dropDownValue1 = rewards['cast_default']?.toString();
    model.dropDownValue2 = rewards['security_staff_default']?.toString();
    model.dropDownValue3 = rewards['shuttle_staff_default']?.toString();
    model.dropDownValue4 = rewards['cast_bonus']?.toString();
    model.dropDownValue5 = rewards['security_bonus']?.toString();
    model.dropDownValue6 = rewards['shuttle_bonus']?.toString();

    model.dropDownValue7 = affiliate['payout_day_1']?.toString();
    model.dropDownValue8 = affiliate['payout_day_2']?.toString();
    model.dropDownValue9 = affiliate['min_payout']?.toString();
    model.dropDownValue10 = affiliate['default_rate']?.toString();
    model.dropDownValue11 = affiliate['hold_days']?.toString();
    model.dropDownValue12 = affiliate['payout_cycle_day']?.toString();

    model.textController3?.text = '${taxi['base_fee'] ?? ''}';
    model.textController4?.text = '${taxi['night_surcharge'] ?? ''}';

    if (areas is List) {
      _applyServiceAreas(areas, model);
    } else if (areas is Map && areas['areas'] is List) {
      _applyServiceAreas(areas['areas'] as List, model);
    }
  }

  static void _applyServiceAreas(
    List<dynamic> areas,
    SystemSettingsListPageModel model,
  ) {
    final switches = List<bool?>.filled(prefectureNames.length, null);
    for (var i = 0; i < prefectureNames.length; i++) {
      final name = prefectureNames[i];
      final entry = areas.cast<Map?>().firstWhere(
            (e) => e?['name'] == name || e?['prefecture'] == name,
            orElse: () => null,
          );
      switches[i] = entry?['enabled'] == true || entry?['active'] == true;
    }
    model.switchValue1 = switches[0] ?? false;
    model.switchValue2 = switches[1] ?? false;
    model.switchValue3 = switches[2] ?? false;
    model.switchValue4 = switches[3] ?? false;
    model.switchValue5 = switches[4] ?? false;
    model.switchValue6 = switches[5] ?? false;
    model.switchValue7 = switches[6] ?? false;
    model.switchValue8 = switches[7] ?? false;
    model.switchValue9 = switches[8] ?? false;
    model.switchValue10 = switches[9] ?? false;
    model.switchValue11 = switches[10] ?? false;
  }

  static Map<String, dynamic> buildSettings(SystemSettingsListPageModel model) {
    final slots = <int>[];
    if (model.checkboxListTileValue1 == true) slots.add(1);
    if (model.checkboxListTileValue2 == true) slots.add(2);
    if (model.checkboxListTileValue3 == true) slots.add(3);
    if (model.checkboxListTileValue4 == true) slots.add(4);
    return {
      'extension_min_count': model.countControllerValue1 ?? 0,
      'extension_max_count':
          int.tryParse(model.textController1?.text ?? '') ??
              model.countControllerValue2 ??
              0,
      'chat_close_sec': int.tryParse(model.textController2?.text ?? '') ?? 0,
      'night_time_slots': slots,
    };
  }

  static Map<String, dynamic> buildFeaturesEnabled(
    SystemSettingsListPageModel model,
  ) {
    return {
      'staff': model.switchListTileValue1 ?? false,
      'staff_security': model.switchListTileValue1 ?? false,
      'staff_shuttle': model.switchListTileValue2 ?? false,
      'affiliate': model.switchListTileValue3 ?? false,
      'cocoten': model.switchListTileValue4 ?? false,
    };
  }

  static Map<String, dynamic> buildRewards(SystemSettingsListPageModel model) {
    return {
      if (model.dropDownValue1 != null) 'cast_default': model.dropDownValue1,
      if (model.dropDownValue2 != null)
        'security_staff_default': model.dropDownValue2,
      if (model.dropDownValue3 != null)
        'shuttle_staff_default': model.dropDownValue3,
      if (model.dropDownValue4 != null) 'cast_bonus': model.dropDownValue4,
      if (model.dropDownValue5 != null)
        'security_bonus': model.dropDownValue5,
      if (model.dropDownValue6 != null) 'shuttle_bonus': model.dropDownValue6,
    };
  }

  static Map<String, dynamic> buildAffiliate(SystemSettingsListPageModel model) {
    return {
      if (model.dropDownValue7 != null) 'payout_day_1': model.dropDownValue7,
      if (model.dropDownValue8 != null) 'payout_day_2': model.dropDownValue8,
      if (model.dropDownValue9 != null) 'min_payout': model.dropDownValue9,
      if (model.dropDownValue10 != null) 'default_rate': model.dropDownValue10,
      if (model.dropDownValue11 != null) 'hold_days': model.dropDownValue11,
      if (model.dropDownValue12 != null)
        'payout_cycle_day': model.dropDownValue12,
    };
  }

  static List<Map<String, dynamic>> buildServiceAreas(
    SystemSettingsListPageModel model,
  ) {
    final values = [
      model.switchValue1,
      model.switchValue2,
      model.switchValue3,
      model.switchValue4,
      model.switchValue5,
      model.switchValue6,
      model.switchValue7,
      model.switchValue8,
      model.switchValue9,
      model.switchValue10,
      model.switchValue11,
    ];
    return List.generate(prefectureNames.length, (i) {
      return {
        'name': prefectureNames[i],
        'enabled': values[i] ?? false,
      };
    });
  }

  static Map<String, dynamic> buildTaxi(SystemSettingsListPageModel model) {
    return {
      'base_fee': num.tryParse(model.textController3?.text ?? '') ?? 0,
      'night_surcharge': num.tryParse(model.textController4?.text ?? '') ?? 0,
    };
  }

  static Map<String, dynamic> _map(dynamic value) {
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return {};
  }

  static int? _int(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.round();
    }
    return int.tryParse('$value');
  }
}
