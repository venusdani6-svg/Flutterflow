import '/auth/admin_permissions_util.dart';
import '/backend/cloud_functions/admin_calls.dart';
import '/components/admin_common/system_settings_config_bridge.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

/// Super-admin editor for admin_role / admin_permissions / managed_prefectures.
class AdminPermissionsEditorSection extends StatefulWidget {
  const AdminPermissionsEditorSection({
    super.key,
    required this.userId,
    this.onSaved,
  });

  final String userId;
  final VoidCallback? onSaved;

  @override
  State<AdminPermissionsEditorSection> createState() =>
      _AdminPermissionsEditorSectionState();
}

class _AdminPermissionsEditorSectionState
    extends State<AdminPermissionsEditorSection> {
  bool _loading = true;
  bool _saving = false;
  String? _error;
  String _adminRole = 'prefecture_admin';
  final Map<String, bool> _permissions = {};
  final Set<String> _prefectures = {};

  @override
  void initState() {
    super.initState();
    for (final key in AdminPermissions.permissionKeys) {
      _permissions[key] = false;
    }
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final user = await adminGetUser(userId: widget.userId);
      final role = user?['admin_role'] as String? ?? 'prefecture_admin';
      final perms = Map<String, dynamic>.from(
        (user?['admin_permissions'] as Map?) ?? {},
      );
      final managed = List<String>.from(
        (user?['managed_prefectures'] as List?) ?? [],
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _adminRole = role;
        for (final key in AdminPermissions.permissionKeys) {
          _permissions[key] = perms[key] == true;
        }
        _prefectures
          ..clear()
          ..addAll(managed);
        _loading = false;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await adminUpdateAdminAccess(
        userId: widget.userId,
        adminRole: _adminRole,
        adminPermissions: Map<String, bool>.from(_permissions),
        managedPrefectures: _prefectures.toList(),
      );
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('管理者権限を保存しました')),
      );
      widget.onSaved?.call();
    } catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('保存に失敗しました: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!AdminPermissions.isSuperAdmin) {
      return const SizedBox.shrink();
    }
    final theme = FlutterFlowTheme.of(context);
    if (_loading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(_error!, style: TextStyle(color: theme.error)),
      );
    }

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('管理者権限設定', style: theme.titleMedium),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _adminRole,
              decoration: const InputDecoration(
                labelText: '管理者アカウント種別',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'super_admin',
                  child: Text('スーパー管理者'),
                ),
                DropdownMenuItem(
                  value: 'prefecture_admin',
                  child: Text('都道府県別管理者'),
                ),
              ],
              onChanged: _saving
                  ? null
                  : (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() => _adminRole = value);
                    },
            ),
            const SizedBox(height: 16),
            Text('画面権限', style: theme.titleSmall),
            const SizedBox(height: 8),
            ...AdminPermissions.permissionKeys.map(
              (key) => SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(AdminPermissions.permissionLabels[key] ?? key),
                value: _adminRole == 'super_admin' ? true : (_permissions[key] ?? false),
                onChanged: _saving || _adminRole == 'super_admin'
                    ? null
                    : (value) => setState(() => _permissions[key] = value),
              ),
            ),
            if (_adminRole == 'prefecture_admin') ...[
              const SizedBox(height: 16),
              Text('管轄都道府県', style: theme.titleSmall),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: SystemSettingsConfigBridge.prefectureNames.map(
                  (name) {
                    final selected = _prefectures.contains(name);
                    return FilterChip(
                      label: Text(name),
                      selected: selected,
                      onSelected: _saving
                          ? null
                          : (value) {
                              setState(() {
                                if (value) {
                                  _prefectures.add(name);
                                } else {
                                  _prefectures.remove(name);
                                }
                              });
                            },
                    );
                  },
                ).toList(),
              ),
            ],
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('権限を保存'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
