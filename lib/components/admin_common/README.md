# Admin Common UI Kit

Reusable components for admin list and detail pages (Phase 3).

## List pages

| Component | File | Purpose |
|-----------|------|---------|
| `AdminListQueryState` | `admin_list_query_state.dart` | Search, sort, filter, pagination, selection |
| `AdminListToolbar` | `admin_list_toolbar.dart` | Search bar, filter dialog, sort, CSV, bulk actions |
| `AdminPaginationBar` | `admin_pagination_bar.dart` | Previous / next page |
| `AdminUserListCard` | `admin_user_list_card.dart` | Selectable user row |
| `CastUserListBodyWidget` | `cast_user_list_body_widget.dart` | **Template** for cast user list (role=1) |

## Detail pages

| Component | File | Purpose |
|-----------|------|---------|
| `AdminDetailCommonSection` | `admin_detail_common_section.dart` | Edit/save, freeze, delete, audit log, related links |
| `showAdminConfirmDialog` | `admin_confirm_dialog.dart` | Destructive action confirmation |

## Utilities

| Utility | File |
|---------|------|
| CSV export | `admin_csv_export.dart` |

## Replicating to other list pages

1. Copy `cast_user_list_body_widget.dart` → e.g. `guest_user_list_body_widget.dart`
2. Change `_castRole` constant and CSV filename
3. Replace static list area in target page with the new body widget
4. Wire filter dialog for that domain (or reuse `SearchUserDialogCompWidget` for users)

## Template pages (completed)

- **List:** `CastUserListPage` → `CastUserListBodyWidget`
- **Detail:** `CastUserdetailsPage` → `AdminDetailCommonSection`
