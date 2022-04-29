import 'package:flutter/material.dart';

enum OptionLogin { administracao, fatutracao }

// ignore: must_be_immutable
class SignIn extends StatefulWidget {
  SignIn({Key? key, required this.padding}) : super(key: key);

  final Padding padding;
  OptionLogin _optionLogin = OptionLogin.administracao;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          style: const TextStyle(fontSize: 14),
          // decoration: const InputDecoration(hintText: "Email"),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          // textAlign: TextAlign.center,
          decoration: const InputDecoration(
              labelText: "EMAIL",
              contentPadding: EdgeInsets.all(10),
              // floatingLabelAlignment: FloatingLabelAlignment.center,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90)))),
        ),
        widget.padding,
        // const Text("Senha"),
        TextFormField(
          style: const TextStyle(fontSize: 14),
          validator: (va) {
            return "false";
          },
          decoration: const InputDecoration(
              labelText: "SENHA",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90)))),
          // textAlign: TextAlign.center,
          obscureText: true,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            child: const Text("Esqueci a minha senha",
                style: TextStyle(
                  color: Colors.blueGrey,
                )),
            onTap: () {},
          ),
        ),
        RadioListTile<OptionLogin>(
          value: OptionLogin.administracao,
          groupValue: widget._optionLogin,
          onChanged: (value) {
            _optionLoginChange(value!);
          },
          title: const Text(
            "Administração",
          ),
          contentPadding: EdgeInsets.zero,
        ),
        RadioListTile<OptionLogin>(
          value: OptionLogin.fatutracao,
          groupValue: widget._optionLogin,
          onChanged: (value) {
            _optionLoginChange(value!);
          },
          title: const Text("Faturação"),
          contentPadding: EdgeInsets.zero,
        ),
        widget.padding,
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                Form.of(context)!.validate() ? print("Simmm") : print("Naooo");
              },
              child: const Text("Entrar")),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
          ElevatedButton(
              onPressed: () {},
              child: const Text("Cadastrar"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.blueGrey))),
        ]),
      ],
    );
  }

  void _optionLoginChange(OptionLogin value) {
    setState(() {
      widget._optionLogin = value;
    });
  }
}
