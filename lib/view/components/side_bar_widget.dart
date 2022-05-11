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
  // void _navigateTo(String menu) {
  //   setState(() {
  //     widget.title = menu;
  //   });
  // }

  void _navigateTo(BuildContext context, String to) {
    if (widget.title.toLowerCase() != to) {
      Navigator.pushNamed(context, "/$to");
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    const ListTileStyle menuStyle = ListTileStyle.list;
    const Color bgTileColor = Colors.black12;

    return Drawer(
      child: Column(children: [
        DrawerHeader(
            decoration: const BoxDecoration(
                color: Colors.blue,
                border: Border(bottom: BorderSide(color: Colors.black12))),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.asset(
                  "assets/img/logo.png",
                  width: MediaQuery.of(context).size.width * .5,
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
            _navigateTo(context, "empresa");
          },
        ),
        const Separator(),
        ListTile(
          selectedTileColor: bgTileColor,
          style: menuStyle,
          selected: widget.title.toLowerCase() == "produtos/serviços",
          title: const Text(
            "Produtos/Serviços",
          ),
          onTap: () {
            _navigateTo(context, "produtos");
          },
        ),
        const Separator(),
        ListTile(
          selectedTileColor: bgTileColor,
          style: menuStyle,
          selected: widget.title.toLowerCase() == "clientes",
          title: const Text(
            "Clientes",
          ),
          onTap: () {
            _navigateTo(context, "clientes");
          },
        ),
        const Separator(),
        ListTile(
          selectedTileColor: bgTileColor,
          style: menuStyle,
          selected: widget.title.toLowerCase() == "stock",
          title: const Text(
            "Stock",
          ),
          onTap: () {
            _navigateTo(context, "stock");
          },
        ),
        const Separator(),
        ListTile(
          selectedTileColor: bgTileColor,
          style: menuStyle,
          selected: widget.title.toLowerCase() == "relatorios",
          title: const Text(
            "Relatorios",
          ),
          onTap: () {
            // _navigateTo(context, "relatorios");
          },
        ),
        const Separator(),
        ListTile(
          selectedTileColor: bgTileColor,
          style: menuStyle,
          selected: widget.title.toLowerCase() == "faturaçao",
          title: const Text(
            "Faturaçao",
          ),
          onTap: () {
            _navigateTo(context, "faturacao");
          },
        ),
        const Separator(),
        ListTile(
          selectedTileColor: bgTileColor,
          style: menuStyle,
          selected: widget.title.toLowerCase() == "definiçoes",
          title: const Text(
            "Definiçoes",
          ),
          onTap: () {
            _navigateTo(context, "definiçoes");
          },
        ),
        const Spacer(),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.black38))),
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.only(top: 20),
          // color: Colors.blue,
          child: const Text("@Copyright - Candimba Tecnologia",
              style: TextStyle(fontSize: 10), textAlign: TextAlign.center),
        )
      ]),
    );
  }
}

class Separator extends StatelessWidget {
  const Separator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: Colors.black12,
    );
  }
}
