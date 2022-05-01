import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/screens/side_bar_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key, required this.title, required this.body})
      : super(key: key);
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: SideBar(
        title: title,
      ),
      body: body,
    );
  }
}
