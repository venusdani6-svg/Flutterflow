import '/components/admin_common/admin_timestamp_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AdminUserListItem {
  AdminUserListItem({
    required this.id,
    required this.displayName,
    required this.email,
    required this.roleLabel,
    this.role,
    this.photoUrl,
    this.createdAt,
    this.kycStatus,
    this.isFrozen = false,
  });

  final String id;
  final String displayName;
  final String email;
  final String roleLabel;
  final int? role;
  final String? photoUrl;
  final DateTime? createdAt;
  final String? kycStatus;
  final bool isFrozen;

  factory AdminUserListItem.fromMap(Map<String, dynamic> map) {
    final created = parseAdminTimestamp(map['created_time']);
    final roleInt = role is int ? role : int.tryParse(role?.toString() ?? '');
    return AdminUserListItem(
      id: map['id']?.toString() ?? map['uid']?.toString() ?? '',
      displayName: map['display_name']?.toString() ??
          map['displayName']?.toString() ??
          '-',
      email: map['email']?.toString() ?? '-',
      roleLabel: _roleLabel(role),
      role: roleInt,
      photoUrl: map['photo_url']?.toString() ?? map['prefile_image']?.toString(),
      createdAt: created,
      kycStatus: map['kyc_status']?.toString(),
      isFrozen: map['is_frozen'] == true,
    );
  }

  static String _roleLabel(dynamic role) {
    switch (role) {
      case 0:
        return 'ゲスト';
      case 1:
        return 'キャスト';
      case 2:
        return 'スタッフ';
      default:
        return 'ユーザー';
    }
  }

  String get createdAtLabel {
    if (createdAt == null) {
      return '-';
    }
    return DateFormat('yyyy. MM. dd').format(createdAt!.toLocal());
  }
}

class AdminUserListCard extends StatelessWidget {
  const AdminUserListCard({
    super.key,
    required this.user,
    required this.selected,
    required this.onSelectedChanged,
    required this.onTap,
  });

  final AdminUserListItem user;
  final bool selected;
  final ValueChanged<bool> onSelectedChanged;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: selected
                ? FlutterFlowTheme.of(context).primary
                : FlutterFlowTheme.of(context).alternate,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Checkbox(
                value: selected,
                onChanged: (v) => onSelectedChanged(v ?? false),
              ),
              _avatar(context),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0,
                            ),
                          ),
                    ),
                    Text(
                      user.email,
                      style: FlutterFlowTheme.of(context).bodySmall,
                    ),
                  ],
                ),
              ),
              _infoColumn(
                context,
                'アカウント種別',
                user.roleLabel,
              ),
              _infoColumn(context, '登録年月日', user.createdAtLabel),
              _infoColumn(
                context,
                'KYC',
                user.kycStatus ?? '-',
              ),
              _infoColumn(
                context,
                '状態',
                user.isFrozen ? '凍結' : '有効',
              ),
            ].divide(const SizedBox(width: 8.0)),
          ),
        ),
      ),
    );
  }

  Widget _avatar(BuildContext context) {
    final url = user.photoUrl;
    return Container(
      width: 50.0,
      height: 50.0,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: url != null && url.isNotEmpty
          ? CachedNetworkImage(imageUrl: url, fit: BoxFit.cover)
          : Image.asset('assets/images/image1.jpeg', fit: BoxFit.cover),
    );
  }

  Widget _infoColumn(BuildContext context, String label, String value) {
    return SizedBox(
      width: 120.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 11.0,
                  ),
                ),
          ),
          Text(
            value,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(fontSize: 12.0),
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
