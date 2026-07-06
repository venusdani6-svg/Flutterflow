import '/backend/cloud_functions/admin_calls.dart';
import '/components/admin_common/admin_confirm_dialog.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AdminRelatedLink {
  const AdminRelatedLink({
    required this.label,
    required this.routeName,
    this.queryParameters = const {},
  });

  final String label;
  final String routeName;
  final Map<String, String> queryParameters;
}

/// Common detail page actions: edit mode, save/cancel, audit log, related links.
class AdminDetailCommonSection extends StatefulWidget {
  const AdminDetailCommonSection({
    super.key,
    required this.targetType,
    required this.targetId,
    this.relatedLinks = const [],
    this.onSave,
    this.onFreeze,
    this.onDelete,
  });

  final String targetType;
  final String targetId;
  final List<AdminRelatedLink> relatedLinks;
  final Future<void> Function()? onSave;
  final Future<void> Function()? onFreeze;
  final Future<void> Function()? onDelete;

  @override
  State<AdminDetailCommonSection> createState() =>
      _AdminDetailCommonSectionState();
}

class _AdminDetailCommonSectionState extends State<AdminDetailCommonSection> {
  bool _isEditing = false;
  bool _isLoadingLogs = true;
  List<Map<String, dynamic>> _auditLogs = [];
  final _dateFormat = DateFormat('yy.MM.dd　HH : mm');

  @override
  void initState() {
    super.initState();
    _loadAuditLogs();
  }

  @override
  void didUpdateWidget(covariant AdminDetailCommonSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.targetId != widget.targetId) {
      _loadAuditLogs();
    }
  }

  Future<void> _loadAuditLogs() async {
    if (widget.targetId.isEmpty) {
      return;
    }
    setState(() => _isLoadingLogs = true);
    try {
      final result = await adminGetAuditLogs(
        targetType: widget.targetType,
        targetId: widget.targetId,
        limit: 10,
      );
      final logs = (result?['logs'] as List?) ?? [];
      setState(() {
        _auditLogs = logs
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList();
        _isLoadingLogs = false;
      });
    } catch (_) {
      setState(() {
        _auditLogs = [];
        _isLoadingLogs = false;
      });
    }
  }

  Future<void> _handleFreeze() async {
    if (widget.onFreeze == null) {
      return;
    }
    final ok = await showAdminConfirmDialog(
      context,
      title: 'ユーザー凍結',
      message: 'このユーザーを凍結しますか？',
    );
    if (ok) {
      await widget.onFreeze!();
      await _loadAuditLogs();
    }
  }

  Future<void> _handleDelete() async {
    if (widget.onDelete == null) {
      return;
    }
    final ok = await showAdminConfirmDialog(
      context,
      title: 'ユーザー削除',
      message: 'この操作は取り消せません。削除しますか？',
    );
    if (ok) {
      await widget.onDelete!();
      if (mounted) {
        context.safePop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (widget.onSave != null) ...[
                FFButtonWidget(
                  onPressed: () async {
                    if (_isEditing) {
                      await widget.onSave!();
                      await _loadAuditLogs();
                    }
                    setState(() => _isEditing = !_isEditing);
                  },
                  text: _isEditing ? '保存' : '編集',
                  options: FFButtonOptions(
                    height: 36.0,
                    color: const Color(0xFF3829FE),
                    textStyle: const TextStyle(color: Colors.white, fontSize: 12.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                const SizedBox(width: 8.0),
                if (_isEditing)
                  FFButtonWidget(
                    onPressed: () => setState(() => _isEditing = false),
                    text: 'キャンセル',
                    options: FFButtonOptions(
                      height: 36.0,
                      color: FlutterFlowTheme.of(context).alternate,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
              ],
              const Spacer(),
              if (widget.onFreeze != null)
                FFButtonWidget(
                  onPressed: _handleFreeze,
                  text: '凍結',
                  options: FFButtonOptions(
                    height: 36.0,
                    color: Colors.orange.shade800,
                    textStyle: const TextStyle(color: Colors.white, fontSize: 12.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              const SizedBox(width: 8.0),
              if (widget.onDelete != null)
                FFButtonWidget(
                  onPressed: _handleDelete,
                  text: '削除',
                  options: FFButtonOptions(
                    height: 36.0,
                    color: Colors.red.shade700,
                    textStyle: const TextStyle(color: Colors.white, fontSize: 12.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
            ],
          ),
          if (widget.relatedLinks.isNotEmpty) ...[
            const SizedBox(height: 12.0),
            Text(
              '関連リンク',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(fontWeight: FontWeight.bold),
                  ),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: widget.relatedLinks
                  .map(
                    (link) => ActionChip(
                      label: Text(link.label),
                      onPressed: () {
                        context.pushNamed(
                          link.routeName,
                          queryParameters: link.queryParameters,
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
          const SizedBox(height: 12.0),
          Text(
            '変更履歴',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(fontWeight: FontWeight.bold),
                ),
          ),
          const SizedBox(height: 8.0),
          if (_isLoadingLogs)
            const Center(child: CircularProgressIndicator())
          else if (_auditLogs.isEmpty)
            const Text('変更履歴はありません')
          else
            ..._auditLogs.map(_buildAuditRow),
        ],
      ),
    );
  }

  Widget _buildAuditRow(Map<String, dynamic> log) {
    final createdRaw = log['created_at'];
    String when = '-';
    if (createdRaw is String) {
      final dt = DateTime.tryParse(createdRaw);
      if (dt != null) {
        when = _dateFormat.format(dt.toLocal());
      }
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).alternate,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('操作: ${log['action'] ?? '-'}'),
          Text('対象: ${log['target_id'] ?? widget.targetId}'),
          Text('日時: $when'),
        ],
      ),
    );
  }
}
