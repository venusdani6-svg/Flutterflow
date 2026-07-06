import '/backend/cloud_functions/admin_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

/// Loads a single user via [adminGetUser] and exposes affiliate rate editing.
class AdminUserProfileSection extends StatefulWidget {
  const AdminUserProfileSection({
    super.key,
    required this.userId,
    this.showAffiliateRate = false,
    this.onSaved,
  });

  final String userId;
  final bool showAffiliateRate;
  final VoidCallback? onSaved;

  @override
  State<AdminUserProfileSection> createState() =>
      _AdminUserProfileSectionState();
}

class _AdminUserProfileSectionState extends State<AdminUserProfileSection> {
  bool _isLoading = true;
  String? _error;
  Map<String, dynamic>? _user;
  final _rateController = TextEditingController();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant AdminUserProfileSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userId != widget.userId) {
      _load();
    }
  }

  @override
  void dispose() {
    _rateController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    if (widget.userId.isEmpty) {
      return;
    }
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final user = await adminGetUser(userId: widget.userId);
      setState(() {
        _user = user;
        _rateController.text =
            (user?['affiliate_rate'] as num?)?.toString() ?? '';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _saveRate() async {
    final rate = double.tryParse(_rateController.text);
    if (rate == null) {
      return;
    }
    setState(() => _isSaving = true);
    try {
      await adminUpdateAffiliateRate(userId: widget.userId, rate: rate);
      widget.onSaved?.call();
      await _load();
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    if (widget.userId.isEmpty) {
      return const SizedBox.shrink();
    }
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ユーザー情報', style: theme.titleMedium),
            const SizedBox(height: 8),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_error != null)
              Text(_error!, style: TextStyle(color: theme.error))
            else if (_user != null) ...[
              Text('ID: ${_user!['id'] ?? widget.userId}'),
              Text('表示名: ${_user!['display_name'] ?? '-'}'),
              Text('メール: ${_user!['email'] ?? '-'}'),
              Text('KYC: ${_user!['kyc_status'] ?? '-'}'),
              Text(
                '状態: ${(_user!['is_frozen'] == true) ? '凍結' : '有効'}',
              ),
              if (widget.showAffiliateRate) ...[
                const SizedBox(height: 12),
                Text('個別報酬率 (%)', style: theme.labelMedium),
                const SizedBox(height: 4),
                Row(
                  children: [
                    SizedBox(
                      width: 120,
                      child: TextField(
                        controller: _rateController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: _isSaving ? null : _saveRate,
                      child: _isSaving
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('保存'),
                    ),
                  ],
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
