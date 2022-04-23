import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class HorizontalScrollCategoryModel {
  HorizontalScrollCategoryModel(List<CategoryModel> categoryModels) {
    if (categoryModels.length == 0) throw ArgumentError(["categoryModels List length must be greater than 0"]);
    // selectedElementId = categoryModels[0].id;
    selectedElementId = categoryModels[0].id;
    _categoryModels = categoryModels;
  }
  String selectedElementId = ("");
  List<CategoryModel> _categoryModels = [];
  List<CategoryModel> get categoryModels {
    return _categoryModels;
  }

  static HorizontalScrollCategoryModel createDefaultModel() {
    List<String> categories = ["Bài hát", "Nghệ sĩ", "Album", "Playlist"];
    List<String> _id = ["song_name", "artist_name", "album_name", "playlist_name"];
    List<CategoryModel> categoryModels = [];
    int count = 0;
    for (String name in categories) {
      CategoryModel categoryModel = CategoryModel(name, _id[count]);
      categoryModels.add(categoryModel);
      count++;
    }
    return HorizontalScrollCategoryModel(categoryModels); 
  }
}

class CategoryModel {
  CategoryModel(String categoryName, String? _id) {

    _categoryName = categoryName;
    if (_id == null) 
      this._id = Uuid().v4();
    else this._id = _id;
  }
  late String _id;
  late String _categoryName;

  String get id {
    return _id;
  }

  String get categoryName {
    return _categoryName;
  }

}


class HorizontalScrollCategoryModelNotifier extends ValueNotifier<HorizontalScrollCategoryModel> {
    HorizontalScrollCategoryModelNotifier(HorizontalScrollCategoryModel value): super(value);
    void changeSelectedElementId(String selectedElementId) {
      value.selectedElementId = selectedElementId;
      notifyListeners();
    }
}