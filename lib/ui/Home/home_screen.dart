import 'package:chat/base/base.dart';
import 'package:chat/ui/Home/home_view_model.dart';
import 'package:chat/ui/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Add Room/add_room_screen.dart';
import 'room_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }

  @override
  void initState() {
    super.initState();
    viewModel.loadRooms();
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
                actions: [
                  InkWell(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.logout),
                      ))
                ],
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: const Text('Chat'),
              ),
              body: Column(
                children: [
                  Expanded(child: Consumer<HomeViewModel>(
                    builder: (buildContext, homeViewModel, _) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8),
                        itemBuilder: (context, index) {
                          return RoomWidget(homeViewModel.rooms[index]);
                        },
                        itemCount: homeViewModel.rooms.length,
                      );
                    },
                  )),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddRoomScreen.routeName);
                },
                child: const Icon(Icons.add),
              ),
            )));
  }
}
