part of 'image_cubit.dart';

class ImageCubitStates {}

class ImageCubitStart extends ImageCubitStates {}

class ImageCubitStateSuccess extends ImageCubitStates {
  File profileImage;
  ImageCubitStateSuccess(this.profileImage);
}
