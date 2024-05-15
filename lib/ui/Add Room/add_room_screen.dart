// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:chat/base/base.dart';
import 'package:chat/ui/Add%20Room/add_room_view_model.dart';
import 'package:chat/ui/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/room_category.dart';

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({super.key});
  static const routeName = '/add_room';

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseState<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {
  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
  }

  List<RoomCategory> allCats = RoomCategory.getRoomCategory();

  late RoomCategory selectedRoomCategory;
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedRoomCategory = allCats[0];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.fill)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: const Text('Create Room'),
            ),
            body: Card(
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Add Room',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Image.asset('assets/images/room.png'),
                      TextFormField(
                        controller: titleController,
                        validator: (text) {
                          if (text!.trim().isEmpty) {
                            return 'please enter room title';
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(labelText: 'Room Name'),
                      ),
                      const SizedBox(height: 10),
                      DropdownButton<RoomCategory>(
                          // itemHeight: Checkbox.width,
                          value: selectedRoomCategory,
                          items: allCats.map((cat) {
                            return DropdownMenuItem<RoomCategory>(
                              value: cat,
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/${cat.imageName}',
                                    // height: 60,
                                    // width: 60,
                                  ),
                                  const VerticalDivider(
                                    color: Colors.transparent,
                                    width: 40,
                                  ),
                                  Text(cat.name),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (item) {
                            if (item == null) return;
                            setState(() {
                              selectedRoomCategory = item;
                            });
                          }),
                      TextFormField(
                        controller: descriptionController,
                        validator: (text) {
                          if (text!.trim().isEmpty) {
                            return 'please enter room description';
                          }
                          return null;
                        },
                        minLines: 3,
                        maxLines: 3,
                        decoration: const InputDecoration(
                            labelText: 'Room Descreption'),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            submit();
                            Navigator.pushNamed(context, HomeScreen.routeName);
                          },
                          child: const Text('Create Room')),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  void submit() async {
    // if (formKey.currentState?.validate() == false) return;

    // viewModel.addRoom(titleController.text, descriptionController.text,
    //     selectedRoomCategory.id);
    if (formKey.currentState!.validate()) {
      viewModel.addRoom(titleController.text, descriptionController.text,
          selectedRoomCategory.id);
    }
  }

  @override
  goBack() {
    Navigator.pop(context);
  }
}
