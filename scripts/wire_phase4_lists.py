#!/usr/bin/env python3
"""Replace static FlutterFlow list scroll views with admin body widgets."""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def find_matching_bracket(text: str, open_idx: int, open_ch: str, close_ch: str) -> int:
    depth = 0
    i = open_idx
    while i < len(text):
        ch = text[i]
        if ch == open_ch:
            depth += 1
        elif ch == close_ch:
            depth -= 1
            if depth == 0:
                return i
        i += 1
    raise ValueError(f"No matching {close_ch} for {open_ch} at {open_idx}")


def replace_single_child_scrollview(
    content: str,
    body_widget: str,
    height_factor: str = "0.9",
) -> str:
    marker = "child: SingleChildScrollView("
    idx = content.find(marker)
    if idx == -1:
        raise ValueError("SingleChildScrollView not found")

    # Walk back to find `child:` line start for Container
    start = content.rfind("\n", 0, idx) + 1
    # Find opening paren of SingleChildScrollView
    paren_open = content.index("(", idx)
    paren_close = find_matching_bracket(content, paren_open, "(", ")")
    # Skip trailing comma after closing paren if present
    end = paren_close + 1
    if end < len(content) and content[end] == ",":
        end += 1

    replacement = f"                                        child: const {body_widget}(),"
    return content[:start] + replacement + content[end:]


def replace_tabbarview_children(content: str) -> str:
    marker = "child: TabBarView("
    idx = content.find(marker)
    if idx == -1:
        raise ValueError("TabBarView not found")

    children_marker = "children: ["
    children_idx = content.find(children_marker, idx)
    if children_idx == -1:
        raise ValueError("TabBarView children not found")

    bracket_open = content.index("[", children_idx)
    bracket_close = find_matching_bracket(content, bracket_open, "[", "]")

    replacement = """children: [
                                                                const LedgerListBodyWidget(),
                                                                const StripeLogsListBodyWidget(),
                                                              ]"""
    return content[:children_idx] + replacement + content[bracket_close + 1 :]


def patch_file(
    rel_path: str,
    import_line: str,
    body_widget: str | None = None,
    tabbar: bool = False,
    guard_admin: bool = False,
) -> None:
    path = ROOT / rel_path
    text = path.read_text(encoding="utf-8")

    if import_line not in text:
        # insert after first import block line
        first_import_end = text.find("\n", text.find("import "))
        text = text[: first_import_end + 1] + import_line + "\n" + text[first_import_end + 1 :]

    if guard_admin and "guardAdminAccess" not in text:
        text = text.replace(
            "import '/flutter_flow/flutter_flow_theme.dart';",
            "import '/auth/admin_auth_util.dart';\nimport '/flutter_flow/flutter_flow_theme.dart';",
            1,
        )
        init_marker = "_model = createModel(context, () => "
        init_idx = text.find(init_marker)
        if init_idx != -1:
            line_end = text.find(");", init_idx)
            insert_at = text.find("\n", line_end) + 1
            guard_block = """
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await guardAdminAccess(context);
    });
"""
            text = text[:insert_at] + guard_block + text[insert_at:]

    if tabbar:
        text = replace_tabbarview_children(text)
    elif body_widget:
        text = replace_single_child_scrollview(text, body_widget)

    path.write_text(text, encoding="utf-8")
    print(f"Patched {rel_path}")


def main() -> int:
    patches = [
        (
            "lib/user_management/staff_user_list_page/staff_user_list_page_widget.dart",
            "import '/components/admin_common/staff_user_list_body_widget.dart';",
            "StaffUserListBodyWidget",
            False,
            True,
        ),
        (
            "lib/user_management/guest_user_list_page/guest_user_list_page_widget.dart",
            "import '/components/admin_common/guest_user_list_body_widget.dart';",
            "GuestUserListBodyWidget",
            False,
            True,
        ),
        (
            "lib/user_management/administrator_list_page/administrator_list_page_widget.dart",
            "import '/components/admin_common/administrator_list_body_widget.dart';",
            "AdministratorListBodyWidget",
            False,
            True,
        ),
        (
            "lib/kyc/k_y_c_review_list_page/k_y_c_review_list_page_widget.dart",
            "import '/components/admin_common/kyc_review_list_body_widget.dart';",
            "KycReviewListBodyWidget",
            False,
            True,
        ),
        (
            "lib/reservations_management/reservation_list_page/reservation_list_page_widget.dart",
            "import '/components/admin_common/reservation_list_body_widget.dart';",
            "ReservationListBodyWidget",
            False,
            True,
        ),
        (
            "lib/withdrawal_application/withdrawal_application_list_page/withdrawal_application_list_page_widget.dart",
            "import '/components/admin_common/payout_list_body_widget.dart';",
            "PayoutListBodyWidget",
            False,
            True,
        ),
        (
            "lib/paymet_ledger/payment_ledger_list_page/payment_ledger_list_page_widget.dart",
            "import '/components/admin_common/ledger_list_body_widget.dart';\nimport '/components/admin_common/stripe_logs_list_body_widget.dart';",
            None,
            True,
            True,
        ),
    ]

    for rel, imp, widget, tabbar, guard in patches:
        try:
            patch_file(rel, imp, widget, tabbar, guard)
        except Exception as exc:
            print(f"FAILED {rel}: {exc}", file=sys.stderr)
            return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
