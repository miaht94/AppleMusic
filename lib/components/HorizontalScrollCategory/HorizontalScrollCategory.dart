import 'package:apple_music/components/HorizontalScrollCategory/CategoryElement.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/HorizontalScrollCategoryModel.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HorizontalScrollCategory extends StatelessWidget {
  HorizontalScrollCategory({
                            Key? key, 
                            required this.horizontalScrollCategoryModel,
                            required this.onTapElement,
                          }) : super(key: key);
  // ignore: inference_failure_on_function_return_type
  Function(CategoryModel) onTapElement;
  HorizontalScrollCategoryModel horizontalScrollCategoryModel;
  List<Widget> _initListCategoryElement(String selectedElementId) {
    final List<Widget> listCategoryElement = [];
    for (final CategoryModel i in horizontalScrollCategoryModel.categoryModels) {
      listCategoryElement.add(CategoryElement(categoryModel: i, isSelected: i.id == selectedElementId, onTapElement: onTapElement,));
      // ignore: cascade_invocations
      listCategoryElement.add(const SizedBox(width: kDefaultPadding));
    }
    listCategoryElement.insert(0, const SizedBox(width: kDefaultPadding));
    return listCategoryElement;
  }

  @override
  Widget build(BuildContext context) {
    
    
    // TODO: implement build
          final List<Widget> listCategoryElement =_initListCategoryElement(horizontalScrollCategoryModel.selectedElementId);
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: 
                Row(children: 
                  listCategoryElement
                )
              ),
          );
  }

  
}