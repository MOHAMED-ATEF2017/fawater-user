import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageCubitStates> {
  ImageCubit() : super(ImageCubitStart());

  File? profileImage;

  ImagePicker picker = ImagePicker();

  ///****get images */
  void getAddPics({
    ImageSource? source,
  }) async {
    // Get.focusScope!.dispose();
    final pickedFile = await picker.pickImage(source: source!);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ImageCubitStateSuccess(profileImage!));
      // Get.back();
    }
  }
}
