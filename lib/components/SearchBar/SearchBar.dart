import 'package:apple_music/components/HorizontalCard/HorizontalCardConstant.dart';
import 'package:apple_music/components/SearchBar/SearchBarConstant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

// ignore: must_be_immutable
class SearchBar extends StatefulWidget {
  SearchBar({
    Key ? key,
    this.onSubmitSearchBar
  }): super(key: key);
  // ignore: inference_failure_on_function_return_type
  Function(String) ? onSubmitSearchBar;
  @override
  State < SearchBar > createState() => _SearchBarState();
}

class _SearchBarState extends State < SearchBar > {
  Color cancelButtonFontColor = kCancelButtonFontColor;
  late TextEditingController inputController;
  FocusNode focusNode = FocusNode();
  bool xMarkVisible = false;
  
  @override
  void initState() {
    super.initState();
    inputController = TextEditingController(text: '');
    inputController.addListener(() {
      if (kDebugMode) {
        print(inputController.text);
      }
      if (inputController.text != '') {
        setState(() {
          xMarkVisible = true;
        });
      } else {
        setState(() {
          xMarkVisible = false;
        });
      }
    }, );
    // focusNode.addListener(() {
    //   if (focusNode.hasFocus) {

    //   }
    // });

  }
  void onTapDownCancelBtn() {
    setState(() {
      cancelButtonFontColor = kCancelButtonFontColor.withOpacity(0.5);
    });
  }

  void onTapUpCancelBtn() {
    setState(() {
      cancelButtonFontColor = kCancelButtonFontColor.withOpacity(1);
      // inputController.text = "";

      inputController.clear();
      focusNode.unfocus();
    });
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (kDebugMode) {
        print(constraints);
      }
      return Row(
        children: [
          Expanded(
            flex: 20,
            child: Container(
              //   width: focusNode.hasFocus ? constraints.maxWidth * kSearchBarWidthRatio : constraints.maxWidth,
              height: constraints.maxWidth * kSearchBarHeightRatio,
              alignment: Alignment.center,
              //   constraints: BoxConstraints(maxHeight: kSearchBarMaxHeight, minHeight: kSearchBarMinHeight, minWidth: kSearchBarMinWidth),
              // decoration: BoxDecoration(
              //     color: kBackgroundSearchBarColor,
              //     borderRadius: BorderRadius.circular(kSearchBarBorderRadius)
              // ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(SFSymbols.search, color: kPlaceholderColor, size: 20),
                  // SizedBox(width: kPaddingBtwIconAndSearchBar, ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: TextField(
                        style: const TextStyle(fontSize: 17),
                        textAlignVertical: TextAlignVertical.center,
                        autocorrect: false,
                        focusNode: focusNode,
                        onSubmitted: (String value) {
                          // ignore: unnecessary_statements
                          widget.onSubmitSearchBar != null ? widget.onSubmitSearchBar!(value) : '';
                        },
                        controller: inputController,
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon:
                          Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(kCardBorderRadius))),
                          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Search',
                        ),
                      ),
                    )
                  ),

                  if (xMarkVisible)
                    GestureDetector(
                      child: const Icon(
                        SFSymbols.xmark_circle_fill,
                        color: kXMarkCircleFontColor,
                      ),
                      onTap: () {
                        inputController.clear();
                      }
                    ),

                ]),
            ),
          ),
          if (focusNode.hasFocus)
            Flexible(child: Container()),
            if (focusNode.hasFocus)
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    if (kDebugMode) {
                      print(constraints);
                    }
                    onTapDownCancelBtn();
                  },
                  onTapUp: (TapUpDetails details) {
                    onTapUpCancelBtn();
                  },
                  onTapCancel: onTapUpCancelBtn,
                  child: Text('Hủy',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: cancelButtonFontColor,
                      overflow: TextOverflow.clip
                    )
                  ),
                ),
              )
        ],
      );
    });
  }
}