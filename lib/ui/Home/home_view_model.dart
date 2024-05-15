import 'package:chat/base/base.dart';
import 'package:chat/data%20base/my_data_base.dart';

import '../../model/room.dart';

abstract class HomeNavigator extends BaseNavigator {}

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  List<Room> rooms = [];
  void loadRooms() async {
    rooms = await MyDataBase.loadRooms();
    notifyListeners();
  }
}
