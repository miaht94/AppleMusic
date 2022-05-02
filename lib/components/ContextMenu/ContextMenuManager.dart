import 'package:apple_music/components/ContextMenu/ContextMenu.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuItem.dart';
import 'package:apple_music/components/ContextMenu/SubscreenContextMenu.dart';
import 'package:flutter/cupertino.dart';

class ContextMenuManager {
  ContextMenuManager();
  Map<String, OverlayEntry> overlayMap = {};
  Map<String, ContextMenu> contextMenuMap = {};
  Map<String, SubscreenContextMenu> subscreenMap = {};
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
    contextMenuMap.addAll({contextMenu.name: contextMenu});
    Overlay.of(_context!)!.insert(overlayEntry);
  }
  void removeOverlay(String overlayName) {
    if (overlayMap[overlayName] == null) return;
    overlayMap[overlayName]!.remove();
    overlayMap.remove(overlayName);
    contextMenuMap.remove(overlayName);
  }
  void insertSubscreen(SubscreenContextMenu contextMenu) {
    if (_context == null) return;
    OverlayEntry overlayEntry = OverlayEntry(builder: ((context) {
      return contextMenu;
    }));
    overlayMap.addAll({contextMenu.name : overlayEntry});
    subscreenMap.addAll({contextMenu.name: contextMenu});
    Overlay.of(_context!)!.insert(overlayEntry);
  }
  void removeSubscreen(String overlayName) {
    if (overlayMap[overlayName] == null) return;
    overlayMap[overlayName]!.remove();
    overlayMap.remove(overlayName);
    subscreenMap.remove(overlayName);
  }
}