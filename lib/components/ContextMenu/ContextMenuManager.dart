import 'package:apple_music/components/ContextMenu/ContextMenu.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuItem.dart';
import 'package:flutter/cupertino.dart';

class ContextMenuManager {
  ContextMenuManager();
  Map<String, OverlayEntry> overlayMap = {};
  BuildContext? _context;
  set context(BuildContext context) {
    _context = context;
  }
  BuildContext get context {
    return _context!;
  }
  void insertOverlay(ContextMenu contextMenu) {
    if (_context == null) return;
    OverlayEntry overlayEntry = OverlayEntry(builder: ((context) {
      return contextMenu;
    }));
    overlayMap.addAll({contextMenu.name : overlayEntry});
    Overlay.of(_context!)!.insert(overlayEntry);
  }
  void removeOverlay(String overlayName) {
    if (overlayMap[overlayName] == null) return;

    overlayMap[overlayName]!.remove();
    overlayMap.remove(overlayName);
  }
}