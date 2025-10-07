import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weider/core/utils/shared_pref_prepared.dart';

part 'user_image_state.dart';

class UserImageCubit extends Cubit<String?> {
  UserImageCubit() : super(null);

  Future<void> storeImagePath({required String? imagePath}) async {
    if (imagePath != null) {
      final isStored = await SharedPrefPrepared.storedImagePath(
        imagePath: imagePath,
      );
      isStored ? emit(imagePath) : null;
      log("You stored image in path $imagePath");
    }
  }

  Future<void> getImagePath() async {
    emit(await SharedPrefPrepared.getImagePath());
  }
}
