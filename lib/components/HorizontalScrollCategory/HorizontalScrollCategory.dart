import 'package:apple_music/components/HorizontalScrollCategory/CategoryElement.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/HorizontalScrollCategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HorizontalScrollCategory extends StatelessWidget {
  HorizontalScrollCategory({
                            Key? key, 
                            required this.horizontalScrollCategoryModel,
                            required this.onTapElement,
                          }) : super(key: key);
  Function(CategoryModel) onTapElement;
  HorizontalScrollCategoryModel horizontalScrollCategoryModel;
  List<Widget> _initListCategoryElement(String selectedElementId) {
    List<Widget> listCategoryElement = [];
    for (CategoryModel i in horizontalScrollCategoryModel.categoryModels) {
      listCategoryElement.add(CategoryElement(categoryModel: i, isSelected: i.id == selectedElementId, onTapElement: onTapElement,));
      listCategoryElement.add(SizedBox(width: kDefaultPadding));
    }
    listCategoryElement.insert(0, SizedBox(width: kDefaultPadding));
    return listCategoryElement;
  }

  @override
  Widget build(BuildContext context) {
    
    
    // TODO: implement build
          List<Widget> listCategoryElement =_initListCategoryElement(horizontalScrollCategoryModel.selectedElementId); 
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