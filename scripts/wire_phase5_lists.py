#!/usr/bin/env python3
"""Wire Phase 5 list body widgets into FlutterFlow pages."""

from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def replace_single_child_scrollview(content: str, body_widget: str) -> str:
    marker = "child: SingleChildScrollView("
    idx = content.find(marker)
    if idx == -1:
        raise ValueError("SingleChildScrollView not found")
    start = content.rfind("\n", 0, idx) + 1
    paren_open = content.index("(", idx)
    depth = 0
    i = paren_open
    while i < len(content):
        if content[i] == "(":
            depth += 1
        elif content[i] == ")":
            depth -= 1
            if depth == 0:
                break
        i += 1
    end = i + 1
    if end < len(content) and content[end] == ",":
        end += 1
    replacement = f"                                        child: const {body_widget}(),"
    return content[:start] + replacement + content[end:]


def patch_file(rel_path: str, import_line: str, body_widget: str) -> None:
    path = ROOT / rel_path
    text = path.read_text(encoding="utf-8")
    if import_line.split("\n")[0] not in text:
        anchor = "import '/flutter_flow/flutter_flow_theme.dart';"
        if "guardAdminAccess" not in import_line:
            text = text.replace(
                anchor,
                "import '/auth/admin_auth_util.dart';\n" + anchor,
                1,
            )
        first = import_line.split("\n")[0]
        text = text.replace(anchor, anchor + "\n" + import_line, 1)
    if "guardAdminAccess" not in text:
        init_marker = "_model = createModel(context, () =>"
        pos = text.find(init_marker)
        if pos != -1:
            end = text.find(");", pos)
            insert = text.find("\n", end) + 1
            guard = """
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await guardAdminAccess(context);
    });
"""
            text = text[:insert] + guard + text[insert:]
    text = replace_single_child_scrollview(text, body_widget)
    path.write_text(text, encoding="utf-8")
    print(f"Patched {rel_path}")


def main() -> int:
    patches = [
        (
            "lib/banner/banner_list_page/banner_list_page_widget.dart",
            "import '/components/admin_common/banner_list_body_widget.dart';",
            "BannerListBodyWidget",
        ),
        (
            "lib/report/report_list_page/report_list_page_widget.dart",
            "import '/components/admin_common/report_list_body_widget.dart';",
            "ReportListBodyWidget",
        ),
        (
            "lib/affiliate/affiliate_list_page/affiliate_list_page_widget.dart",
            "import '/components/admin_common/affiliate_list_body_widget.dart';",
            "AffiliateListBodyWidget",
        ),
    ]
    for rel, imp, widget in patches:
        try:
            patch_file(rel, imp, widget)
        except Exception as exc:
            print(f"FAILED {rel}: {exc}", file=sys.stderr)
            return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
