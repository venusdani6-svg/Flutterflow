/// Shared list query state for admin list pages.
class AdminListQueryState {
  String search = '';
  String sortField = 'created_time';
  bool sortDescending = true;
  AdminUserFilter filter = AdminUserFilter();
  int page = 0;
  int pageSize = 20;
  final Set<String> selectedIds = {};

  int get offset => page * pageSize;

  void resetPage() => page = 0;

  void toggleSelection(String id) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
  }

  void clearSelection() => selectedIds.clear();

  Map<String, dynamic> toApiParams({int? role}) => {
        if (role != null) 'role': role,
        if (search.isNotEmpty) 'search': search,
        'orderBy': sortField,
        'orderDirection': sortDescending ? 'desc' : 'asc',
        if (filter.kycStatus != null) 'kycStatus': filter.kycStatus,
        if (filter.isFrozen != null) 'isFrozen': filter.isFrozen,
        'limit': pageSize,
        'offset': offset,
      };
}

/// Filter parameters from [SearchUserDialogCompWidget] / filter dialogs.
class AdminUserFilter {
  String? kycStatus;
  bool? isFrozen;
  String? accountType;
  String? region;
  String? registrationPeriod;
  String? searchKeyword;

  bool get isEmpty =>
      kycStatus == null &&
      isFrozen == null &&
      accountType == null &&
      region == null &&
      registrationPeriod == null &&
      (searchKeyword == null || searchKeyword!.isEmpty);

  AdminUserFilter copy() => AdminUserFilter()
    ..kycStatus = kycStatus
    ..isFrozen = isFrozen
    ..accountType = accountType
    ..region = region
    ..registrationPeriod = registrationPeriod;
}
