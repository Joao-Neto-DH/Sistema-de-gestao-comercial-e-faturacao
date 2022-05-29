import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../util.dart';
import '../components/input_text_widget.dart';

class Senha extends StatefulWidget {
  const Senha({Key? key}) : super(key: key);

  @override
  State<Senha> createState() => _SenhaState();
}

class _SenhaState extends State<Senha> {
  final prefs = SharedPreferences.getInstance();
  SharedPreferences? _shared;
  final _senhaController = TextEditingController();
  final _tempoController = TextEditingController();

  _SenhaState() {
    _instance();
  }

  void _instance() async {
    _shared = await prefs;
    final psw = _shared!.getString("licenca");
    final date = _shared!.getString("tempo") ?? "";
    if (psw == "C@ndimb@.5000" &&
        DateTime.now().toString().split(" ")[0].compareTo(date) < 0) {
      Navigator.pushReplacementNamed(context, "/signin");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputText(
          obscureText: true,
          label: "LICENÇA",
          controller: _senhaController,
        ),
        AppUtil.defaultPadding,
        InputText(
          label: "TEMPO LIMITE EM DIAS",
          controller: _tempoController,
          validator: (value) {
            if (int.tryParse(value!) == null) return "Tempo de dias invalido";
            return null;
          },
        ),
        AppUtil.defaultPadding,
        // const Text("Senha"),

        ElevatedButton(
            onPressed: () async {
              if (Form.of(context)!.validate()) {
                if (_senhaController.value.text == "C@ndimb@.5000") {
                  final res =
                      await _shared!.setString("licenca", "C@ndimb@.5000");
                  final res2 = await _shared!.setString(
                      "tempo",
                      DateTime.now()
                          .add(Duration(
                              days: int.parse(_tempoController.value.text)))
                          .toString()
                          .split(" ")[0]);
                  if (!res || !res2) {
                    // print(DateTime.now()
                    //     .add(Duration(
                    //         days: int.parse(_tempoController.value.text)))
                    //     .toString()
                    //     .split(" ")[0]);
                    AppUtil.snackBar(
                        context, "Nao foi possivel salvar a licença");
                  } else {
                    Navigator.pushReplacementNamed(context, "/signin");
                  }
                } else {
                  AppUtil.snackBar(context, "Nao");
                }
              }
              // Navigator.pushReplacementNamed(context, "/signin");
            },
            child: const Text("Avançar"),
            style: TextButton.styleFrom(backgroundColor: Colors.blueGrey)),
      ],
    );
  }
}
