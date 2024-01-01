import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Components/text_style.dart';

dynamic openImagePicker({
  BuildContext? context,
  Function()? onGalleryTapped,
  // Function()? onCameraTapped,
}) {
  showCupertinoModalPopup(
      context: context!,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          cancelButton: CupertinoButton(
            child: Text(
//              translator.currentLanguage == "en" ? "Cancel" :
              "الغاء",
              style: textStyle(
                // color: orangColorFC6011,
                size: 16,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            CupertinoButton(
                onPressed: onGalleryTapped,
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.insert_photo,
                      // color: orangColorFC6011,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
//                      translator.currentLanguage == "en"
//                          ? "Gallery"
//                          :
                      "الاستوديو",
                      style: textStyle(
                        // color: orangColorFC6011,
                        size: 16,
                      ),
                    ),
                  ],
                )),
          ],
        );
      });
}
