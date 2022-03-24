import 'package:apple_music/components/SearchBar/SearchBarConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class SearchBar extends StatefulWidget {
    SearchBar({
        Key ? key
    }): super(key: key);

    @override
    State < SearchBar > createState() => _SearchBarState();
}

class _SearchBarState extends State < SearchBar > {
    Color cancelButtonFontColor = kCancelButtonFontColor;
    late TextEditingController inputController;
    FocusNode focusNode = FocusNode(canRequestFocus: true);
    bool xMarkVisible = false;
    Function(String)? onSubmitSearchBar;
    @override
    void initState() {
        super.initState();
        inputController = TextEditingController(text: "");
        inputController.addListener(() {
            print(inputController.text);
            if (inputController.text != "") {
                setState(() {
                    xMarkVisible = true;
                });
            } else {
                setState(() {
                    xMarkVisible = false;
                });
            }
        }, );
        focusNode.addListener(() {
            if (focusNode.hasFocus) {

            }
        });

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
        Size screenSize = MediaQuery.of(context).size;
        return LayoutBuilder(builder: ((context, constraints) {
            print(constraints);
            return Row(
                children: [
                    Expanded(
                        flex: 20,
                        child: Container(
                            //   width: focusNode.hasFocus ? constraints.maxWidth * kSearchBarWidthRatio : constraints.maxWidth,
                            height: constraints.maxWidth * kSearchBarHeightRatio,
                            alignment: Alignment.center,
                            //   constraints: BoxConstraints(maxHeight: kSearchBarMaxHeight, minHeight: kSearchBarMinHeight, minWidth: kSearchBarMinWidth),
                            decoration: BoxDecoration(
                                color: kBackgroundSearchBarColor,
                                borderRadius: BorderRadius.circular(kSearchBarBorderRadius)
                            ),
                            child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    Icon(SFSymbols.search, color: kPlaceholderColor, ),
                                    SizedBox(width: kPaddingBtwIconAndSearchBar, ),
                                    Expanded(
                                        child: TextField(
                                            autocorrect: false,
                                            focusNode: focusNode,
                                            onSubmitted: (String value) {
                                              onSubmitSearchBar!(value);
                                            },
                                            controller: inputController,
                                            textAlignVertical: TextAlignVertical.center,
                                            decoration: InputDecoration(
                                                hintText: "Search ...",
                                                border: InputBorder.none
                                            ),
                                        )
                                    ),
                                    
                                    if (xMarkVisible)
                                        GestureDetector(
                                            child: Icon(
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
                        Flexible(flex: 1,child: Container()),
                    if (focusNode.hasFocus)
                        Expanded(
                            flex: 2,
                            child: Container(

                                child: GestureDetector(
                                    onTapDown: (TapDownDetails details) {
                                        print(constraints);
                                        onTapDownCancelBtn();
                                    },
                                    onTapUp: (TapUpDetails details) {
                                        onTapUpCancelBtn();
                                    },
                                    onTapCancel: () {
                                        onTapUpCancelBtn();
                                    },
                                    child: Container(
                                        child: Text("Hủy",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(color: cancelButtonFontColor,
                                                overflow: TextOverflow.clip
                                                )
                                        )
                                    ),
                                ),
                            ),
                        )
                ],
            );
        }));
    }
}