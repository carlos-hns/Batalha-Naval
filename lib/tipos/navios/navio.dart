import 'package:flutter/material.dart';

abstract class Navio {
  late String caracterRepresentador;
  late int tamanho;
  late Color color;

  Navio({
    required this.caracterRepresentador,
    required this.tamanho,
    required this.color,
  });
}
