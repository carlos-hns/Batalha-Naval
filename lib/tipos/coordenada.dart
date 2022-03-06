class Coordenada {
  int x, y;
  Coordenada({required this.x, required this.y});

  @override
  bool operator ==(o) => o is Coordenada && this.x == o.x && this.y == o.y;
}
