import 'package:apple_music/models/HorizontalScrollCategoryModel.dart';
import 'package:flutter/material.dart';

import 'HorizontalScrollCategoryConstant.dart';

// ignore: must_be_immutable
class CategoryElement extends StatefulWidget {
    CategoryElement({
        Key ? key,
        required this.categoryModel,
        required this.isSelected,
        required this.onTapElement,
    }): super(key: key);

    CategoryModel categoryModel;
    bool isSelected;
    // ignore: inference_failure_on_function_return_type
    Function(CategoryModel) onTapElement;
    @override
    State < CategoryElement > createState() => _CategoryElementState();
}

class _CategoryElementState extends State < CategoryElement > with SingleTickerProviderStateMixin{
    late AnimationController fadeBackgroundAnimation;
    @override
    void initState() {
        super.initState();
        fadeBackgroundAnimation = AnimationController(vsync: this, value: widget.isSelected ? 1 : 0, duration: const Duration(milliseconds: 100));
    }

    

    @override
    Widget build(BuildContext context) {
        fadeBackgroundAnimation.animateTo(widget.isSelected ? 1 : 0, duration: const Duration(milliseconds: 100));
        return AnimatedBuilder(
            animation: fadeBackgroundAnimation,
            builder: (context, child) => 
            Material(
              color:kCategoryElementSelectedBackgroundColor.withOpacity(fadeBackgroundAnimation.value),
              borderRadius: BorderRadius.circular(kCategoryElementBorderRadius),
              child: InkWell(
                  borderRadius: BorderRadius.circular(kCategoryElementBorderRadius),
                  onTap: () {
                      widget.onTapElement(widget.categoryModel);
                  },
                  child: Container(
                      width: 90,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: kCategoryElementSelectedBackgroundColor),
                          borderRadius: BorderRadius.circular(kCategoryElementBorderRadius)
                      ),
                      child: Text(widget.categoryModel.categoryName, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: kCategoryElementFontSize, color: widget.isSelected ? kCategoryElementOnSelectedFontColor : kCategoryElementNotSelectedFontColor, fontWeight: FontWeight.bold), ),
                  ),
              ),
          ),
        );
    }
}