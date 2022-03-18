import 'package:flutter/material.dart';

class BatalhaDropDown extends StatefulWidget {
  late List<String> opcoes;
  late String opcaoSelecionada;
  late Function(String opcao) onChanged;

  BatalhaDropDown({
    required this.opcoes,
    required this.opcaoSelecionada,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<BatalhaDropDown> createState() => _BatalhaDropDownState();
}

class _BatalhaDropDownState extends State<BatalhaDropDown> {
  late String _opcaoSelecionada;

  @override
  void initState() {
    super.initState();
    this._opcaoSelecionada = this.widget.opcaoSelecionada;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        underline: Container(),
        isExpanded: true,
        style: TextStyle(
          color: Colors.black,
        ),
        iconEnabledColor: Colors.black,
        value: this._opcaoSelecionada,
        items: this
            .widget
            .opcoes
            .map(
              (opcao) => DropdownMenuItem(
                value: opcao,
                child: Text(
                  opcao,
                ),
              ),
            )
            .toList(),
        onChanged: (novaOpcao) {
          setState(() {
            this._opcaoSelecionada = novaOpcao ?? "Empty";
            this.widget.onChanged(novaOpcao ?? "Empty");
          });
        },
      ),
    );
  }
}
