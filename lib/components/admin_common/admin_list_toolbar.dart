import '/components/admin_common/admin_list_query_state.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/user_management/search_user_dialog_comp/search_user_dialog_comp_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef AdminListToolbarCallback = void Function();

class AdminListToolbar extends StatefulWidget {
  const AdminListToolbar({
    super.key,
    required this.query,
    required this.onQueryChanged,
    required this.onExportCsv,
    this.onBulkFreeze,
    this.bulkActionLabel = '一括凍結',
    this.sortOptions = const {
      'created_time': '登録日時',
      'display_name': '表示名',
      'email': 'メール',
    },
  });

  final AdminListQueryState query;
  final AdminListToolbarCallback onQueryChanged;
  final AdminListToolbarCallback onExportCsv;
  final AdminListToolbarCallback? onBulkFreeze;
  final String bulkActionLabel;
  final Map<String, String> sortOptions;

  @override
  State<AdminListToolbar> createState() => _AdminListToolbarState();
}

class _AdminListToolbarState extends State<AdminListToolbar> {
  late TextEditingController _searchController;
  FormFieldController<String>? _sortController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.query.search);
    _sortController = FormFieldController<String>(widget.query.sortField);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openFilterDialog() async {
    final result = await showDialog<AdminUserFilter>(
      context: context,
      builder: (dialogContext) => Dialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        alignment: AlignmentDirectional(0.0, -1.0)
            .resolve(Directionality.of(context)),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(dialogContext).unfocus();
          },
          child: SizedBox(
            height: 280.0,
            width: 760.0,
            child: SearchUserDialogCompWidget(
              initialFilter: widget.query.filter,
            ),
          ),
        ),
      ),
    );
    if (result != null) {
      widget.query.search = result.searchKeyword ?? widget.query.search;
      widget.query.filter = result;
      widget.query.resetPage();
      widget.onQueryChanged();
      setState(() {});
    }
  }

  void _applySearch() {
    widget.query.search = _searchController.text.trim();
    widget.query.resetPage();
    widget.onQueryChanged();
  }

  @override
  Widget build(BuildContext context) {
    final hasSelection = widget.query.selectedIds.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'メール・表示名で検索',
                    filled: true,
                    fillColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18.0),
                            onPressed: () {
                              _searchController.clear();
                              _applySearch();
                              setState(() {});
                            },
                          )
                        : null,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(fontSize: 12.0),
                      ),
                  onSubmitted: (_) => _applySearch(),
                ),
              ),
              const SizedBox(width: 8.0),
              FFButtonWidget(
                onPressed: _applySearch,
                text: '検索',
                options: FFButtonOptions(
                  height: 40.0,
                  color: const Color(0xFF3829FE),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.interTight(),
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(width: 8.0),
              InkWell(
                onTap: _openFilterDialog,
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: widget.query.filter.isEmpty
                          ? FlutterFlowTheme.of(context).alternate
                          : FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                  child: Icon(
                    Icons.filter_list,
                    size: 20.0,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Text(
                'ソート',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(fontSize: 12.0),
                    ),
              ),
              const SizedBox(width: 8.0),
              FlutterFlowDropDown<String>(
                controller: _sortController!,
                options: widget.sortOptions.keys.toList(),
                optionLabels: widget.sortOptions.values.toList(),
                onChanged: (val) {
                  if (val == null) {
                    return;
                  }
                  widget.query.sortField = val;
                  widget.query.resetPage();
                  widget.onQueryChanged();
                },
                width: 180.0,
                height: 40.0,
                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(fontSize: 12.0),
                    ),
                hintText: '並び替え',
                icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20.0),
                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                elevation: 0.0,
                borderColor: FlutterFlowTheme.of(context).alternate,
                borderWidth: 1.0,
                borderRadius: 8.0,
                margin: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                hidesUnderline: true,
              ),
              IconButton(
                tooltip: widget.query.sortDescending ? '降順' : '昇順',
                onPressed: () {
                  widget.query.sortDescending = !widget.query.sortDescending;
                  widget.query.resetPage();
                  widget.onQueryChanged();
                  setState(() {});
                },
                icon: Icon(
                  widget.query.sortDescending
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                  size: 20.0,
                ),
              ),
              const Spacer(),
              if (hasSelection && widget.onBulkFreeze != null)
                FFButtonWidget(
                  onPressed: widget.onBulkFreeze,
                  text: widget.bulkActionLabel,
                  options: FFButtonOptions(
                    height: 36.0,
                    color: Colors.red.shade700,
                    textStyle: const TextStyle(color: Colors.white, fontSize: 12.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              const SizedBox(width: 8.0),
              FFButtonWidget(
                onPressed: widget.onExportCsv,
                text: 'CSV',
                icon: const Icon(Icons.download, size: 16.0, color: Colors.white),
                options: FFButtonOptions(
                  height: 36.0,
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: const TextStyle(color: Colors.white, fontSize: 12.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
