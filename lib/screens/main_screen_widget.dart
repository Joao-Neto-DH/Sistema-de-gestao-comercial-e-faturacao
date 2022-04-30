import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/screens/side_bar_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OLA"),
        // automaticallyImplyLeading: false,
      ),
      drawer: const SideBar(),
    );
  }
}
