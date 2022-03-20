import 'package:batalha_naval/componentes/batalha_drop_down.dart';
import 'package:flutter/material.dart';

class ConfigurationElement extends StatelessWidget {
  String label;
  List<String> options;
  String current;
  Function(String) onChange;

  ConfigurationElement({
    required this.label,
    required this.options,
    required this.current,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          this.label,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0),
          child: BatalhaDropDown(
            opcoes: this.options,
            opcaoSelecionada: this.current,
            onChanged: this.onChange,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
