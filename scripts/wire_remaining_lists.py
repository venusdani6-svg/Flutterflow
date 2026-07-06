#!/usr/bin/env python3
"""Wire remaining list body widgets (cocoten, job board, audit log)."""

from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))
from wire_phase5_lists import patch_file  # noqa: E402


def main() -> int:
    patches = [
        (
            "lib/cocomise/cocomise_list_page/cocomise_list_page_widget.dart",
            "import '/components/admin_common/cocoten_list_body_widget.dart';",
            "CocotenListBodyWidget",
        ),
        (
            "lib/job_board/job_board_list_page/job_board_list_page_widget.dart",
            "import '/components/admin_common/job_board_list_body_widget.dart';",
            "JobBoardListBodyWidget",
        ),
        (
            "lib/audit_log/audit_log_list_page/audit_log_list_page_widget.dart",
            "import '/components/admin_common/audit_log_list_body_widget.dart';",
            "AuditLogListBodyWidget",
        ),
    ]
    for rel, imp, widget in patches:
        patch_file(rel, imp, widget)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
