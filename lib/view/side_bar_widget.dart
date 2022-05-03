import 'package:flutter/material.dart';

/// Menu de barra lateral
/// Drawer
// ignore: must_be_immutable
class SideBar extends StatefulWidget {
  SideBar({Key? key, required this.title}) : super(key: key);
  String title;

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  void _selectMenu(String menu) {
    setState(() {
      widget.title = menu;
    });
  }

  @override
  Widget build(BuildContext context) {
    const ListTileStyle menuStyle = ListTileStyle.list;
    const Color bgTileColor = Colors.black12;

    return Drawer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        DrawerHeader(
            decoration: const BoxDecoration(
                color: Colors.blue,
                border: Border(bottom: BorderSide(color: Colors.black12))),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.asset(
                  "assets/img/logo.png",
                  width: MediaQuery.of(context).size.width * .59,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Sistema de Gestao Comercial e Faturaçao",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
        ListTile(
          selectedTileColor: bgTileColor,
          style: menuStyle,
          selected: widget.title.toLowerCase() == "empresa",
          title: const Text(
            "Empresa",
          ),
          onTap: () {
            _selectMenu("empresa");
          },
        ),
        ListTile(
          selectedTileColor: bgTileColor,
          style: menuStyle,
          selected: widget.title.toLowerCase() == "produtos/serviços",
          title: const Text(
            "Produtos/Serviços",
          ),
          onTap: () {
            _selectMenu("produtos/serviços");
          },
        ),
        ListTile(
          selectedTileColor: bgTileColor,
          style: menuStyle,
          selected: widget.title.toLowerCase() == "clientes",
          title: const Text(
            "Clientes",
          ),
          onTap: () {
            _selectMenu("clientes");
          },
        ),
        ListTile(
          selectedTileColor: bgTileColor,
          style: menuStyle,
          selected: widget.title.toLowerCase() == "stock",
          title: const Text(
            "Stock",
          ),
          onTap: () {
            _selectMenu("stock");
          },
        ),
        ListTile(
          selectedTileColor: bgTileColor,
          style: menuStyle,
          selected: widget.title.toLowerCase() == "relatorios",
          title: const Text(
            "Relatorios",
          ),
          onTap: () {
            _selectMenu("relatorios");
          },
        ),
        ListTile(
          selectedTileColor: bgTileColor,
          style: menuStyle,
          selected: widget.title.toLowerCase() == "faturaçao",
          title: const Text(
            "Faturaçao",
          ),
          onTap: () {
            _selectMenu("faturaçao");
          },
        ),
        ListTile(
          selectedTileColor: bgTileColor,
          style: menuStyle,
          selected: widget.title.toLowerCase() == "definiçoes",
          title: const Text(
            "Definiçoes",
          ),
          onTap: () {
            _selectMenu("definiçoes");
          },
        ),
        const Spacer(),
        Container(
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.black38))),
          padding: const EdgeInsets.symmetric(vertical: 10),
          // color: Colors.blue,
          child: const Text("@Copyright - Candimba Tecnologia",
              style: TextStyle(fontSize: 10), textAlign: TextAlign.center),
        )
      ]),
    );
  }
}
