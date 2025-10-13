import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weider/core/constants/intervals/intervals.dart';
import 'package:weider/features/user/data/models/user_model/user_model.dart';

enum Boxes {users}
class HivePrepared {
  static Future<void> init() async {
    final UserModelAdapter userModelAdapter = UserModelAdapter();
    final dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);
if (!Hive.isAdapterRegistered(1)) {
  Hive.registerAdapter<Intervals>(IntervalsAdapter());
}

    if (!Hive.isAdapterRegistered(userModelAdapter.typeId)) {
      Hive.registerAdapter<UserModel>(userModelAdapter);
    }
    await _openBoxes();
  }

  static Future<void> _openBoxes() async {
    if(!Hive.isBoxOpen(Boxes.users.name)){
      await Hive.openBox<UserModel>(Boxes.users.name);
    }
  }

  
}
