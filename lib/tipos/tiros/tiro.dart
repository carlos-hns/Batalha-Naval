abstract class Tiro {
  late String caracterRepresentador;
  late int raioDeTiro;

  @override
  bool operator ==(o) => o is Tiro && this.caracterRepresentador == o.caracterRepresentador;

  Tiro({
    required this.caracterRepresentador,
    required this.raioDeTiro,
  });
}
