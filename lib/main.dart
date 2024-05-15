import 'package:chat/ui/chat/chat_thread.dart';
import 'package:chat/ui/Add%20Room/add_room_screen.dart';
import 'package:chat/ui/Home/home_screen.dart';
import 'package:chat/ui/registeration/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'ui/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        AddRoomScreen.routeName: (context) => const AddRoomScreen(),
        ChatTread.routeName: (context) => const ChatTread()
      },
      // initialRoute: RegisterScreen.routeName,
      home: const LoginScreen(),
    );
  }
}
// hossam@route.com