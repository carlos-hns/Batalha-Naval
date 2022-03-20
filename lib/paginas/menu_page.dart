import 'package:batalha_naval/app_colors.dart';
import 'package:batalha_naval/paginas/insercao_navios_page.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xFF222623),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              this._menuButton("Iniciar Partida", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InsercaoNaviosPage(),
                  ),
                );
              }),
              SizedBox(
                height: 15.0,
              ),
              this._menuButton("Ranking", () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuButton(String title, Function() onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: PrimaryColor,
      ),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
