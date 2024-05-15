import 'package:chat/base/base.dart';
import 'package:chat/data%20base/my_data_base.dart';
import 'package:chat/model/room.dart';

abstract class AddRoomNavigator extends BaseNavigator {
  void goBack();
}

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  void addRoom(String title, String description, String catId) async {
    navigator?.showLoadingDialog(message: 'Creating room ....');
    try {
      var res = await MyDataBase.createRoom(
          Room(title: title, description: description, catId: catId));
      navigator?.hideLoadingDialog();
      navigator?.showMessage(
        'Room Created ',
        posActionTitle: 'ok',
        posAction: () {
          navigator?.goBack();
        },
        isDismissible: false
      );
    } catch (e) {
      navigator?.hideLoadingDialog();
      navigator?.showMessage('Something went wrong ${e.toString()}');
    }
  }
}
