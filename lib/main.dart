import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var initialRoute = await Routes.initialRoute;
  runApp(Main(initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;
  Main(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Chat App",
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: Nav.routes,
    );
  }
}
