import 'package:batalha_naval/base/base_view.dart';
import 'package:batalha_naval/componentes/batalha_board.dart';
import 'package:batalha_naval/componentes/batalha_drop_down.dart';
import 'package:batalha_naval/view_models/insercao_navios_view_model.dart';
import 'package:flutter/material.dart';

class InsercaoNaviosPage extends StatelessWidget {
  const InsercaoNaviosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<InsercaoNaviosViewModel>(
      builder: (context, viewModel) {
        return Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Color(0xFF222623),
                width: MediaQuery.of(context).size.width * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //mainAxisAlignment: Main,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Selecione o Navio",
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
                        opcoes: ["Submarino", "Porta Aviões"],
                        opcaoSelecionada: "Submarino",
                        onChanged: (opcao) {
                          print(opcao);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Eixo",
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
                        opcoes: ["Horizontal", "Vertical"],
                        opcaoSelecionada: "Horizontal",
                        onChanged: (opcao) {
                          print(opcao);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: BatalhaBoard(
                  x: 10,
                  y: 10,
                ),
              ),
              Expanded(
                child: BatalhaBoard(
                  x: 10,
                  y: 10,
                ),
              ),
              // Inserir Board
            ],
          ),
        );
      },
    );
  }
}
