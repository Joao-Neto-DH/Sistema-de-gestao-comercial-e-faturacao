import 'package:flutter/material.dart';

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
      child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            DrawerHeader(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Image.asset(
                        "assets/img/logo.png",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Sistema de Gestao Comercial e Faturaçao",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            // const Spacer(),
            // const Text("@Copyright - Candimba Tecnologia",
            //     style: TextStyle(fontSize: 14), textAlign: TextAlign.center)
          ]),
    );
  }
}
