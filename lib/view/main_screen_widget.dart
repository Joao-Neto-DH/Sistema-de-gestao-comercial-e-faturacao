import 'package:flutter/material.dart';
import './components/side_bar_widget.dart';

/// Tela comum com o Menu Lateral
class MainScreen extends StatelessWidget {
  /// title - Titulo da barra de navegaçao
  /// body - Conteudo do tela
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
