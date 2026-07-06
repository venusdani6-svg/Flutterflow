#!/usr/bin/env python3
"""Hide static FlutterFlow placeholder tabs when API-backed ID is present."""

from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

# After API sections, static FF tabs start with this pattern (user details).
USER_STATIC_MARKER = """                                            ],
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    width: 100.0,
                                                    height: 2000.0,"""

USER_STATIC_REPLACEMENT = """                                            ],
                                            if (_model.userId.isEmpty)
                                              Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    width: 100.0,
                                                    height: 2000.0,"""

RES_STATIC_MARKER = """                                                ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      width: 100.0,
                                                      decoration: BoxDecoration("""

RES_STATIC_REPLACEMENT = """                                                ),
                                              if (_model.reservationId.isEmpty)
                                                Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      width: 100.0,
                                                      decoration: BoxDecoration("""


def patch(path: str, marker: str, replacement: str) -> None:
    file_path = ROOT / path
    text = file_path.read_text(encoding="utf-8")
    if "if (_model.userId.isEmpty)" in text or "if (_model.reservationId.isEmpty)" in text:
        print(f"Skip (already patched): {path}")
        return
    if marker not in text:
        print(f"Skip (marker not found): {path}")
        return
    file_path.write_text(text.replace(marker, replacement, 1), encoding="utf-8")
    print(f"Patched {path}")


def main() -> int:
    for rel in [
        "lib/user_management/cast_userdetails_page/cast_userdetails_page_widget.dart",
        "lib/user_management/staff_userdetails_page/staff_userdetails_page_widget.dart",
        "lib/user_management/guest_userdetails_page/guest_userdetails_page_widget.dart",
        "lib/user_management/administratodetails_page/administratodetails_page_widget.dart",
    ]:
        patch(rel, USER_STATIC_MARKER, USER_STATIC_REPLACEMENT)

    patch(
        "lib/reservations_management/reservationdetails_page/reservationdetails_page_widget.dart",
        RES_STATIC_MARKER,
        RES_STATIC_REPLACEMENT,
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
