void main() {
  final board = Board(
    linesAmount: 8,
    tilesByLineAmount: 16,
  );

  board.printBoard();

  board.insertShip(AircraftCarrier(), BoardPoint.fromBoardCoordinate("A", 1), Orientation.Horizontal);

  board.printBoard();

  //print(BoardPoint(0, 1).convertFromGridStyle("A"));
}

class Board {
  late int linesAmount;
  late int tilesByLineAmount;
  late List<List<int>> _board;

  Board({required this.linesAmount, required this.tilesByLineAmount}) {
    _board = _populatedBoard(linesAmount, tilesByLineAmount);
  }

  List<List<int>> _populatedBoard(int linesAmount, int tilesByLineAmount) {
    final List<List<int>> board = [];

    for (int i = 0; i < linesAmount; i++) {
      board.add(List.generate(tilesByLineAmount, (index) => 0));
    }

    return board;
  }

  void printBoard() {
    for (int i = 0; i < linesAmount; i++) {
      print(_board[i]);
    }
    print("\n");
  }

  void insertShip(Ship ship, BoardPoint point, Orientation orientation) {
    ship.pointsFrom(point.x, point.y, orientation).forEach((point) {
      _board[point.x][point.y] = 1;
    });
  }
}

class BoardPoint {
  late int x;
  late int y;

  BoardPoint(this.x, y) {
    this.y = y;
  }

  factory BoardPoint.fromBoardCoordinate(String x, int y) {
    return BoardPoint(convertFromBoardStyle(x), y - 1);
  }

  static int convertFromBoardStyle(String value) {
    return value.codeUnitAt(0) - "A".codeUnitAt(0);
  }
}

enum Orientation { Vertical, Horizontal }

abstract class Ship {
  //late String name;
  //late Orientation orientation;

  // Ship(
  //   this.name,
  //   //this.orientation,
  // );

  List<BoardPoint> pointsFrom(int x, int y, Orientation orientation);
}

class AircraftCarrier extends Ship {
  // AircraftCarrier({
  //   required String name,
  //   required Orientation orientation,
  // }) : super(
  //         name, /* orientation */
  //       );

  @override
  List<BoardPoint> pointsFrom(int x, int y, Orientation orientation) {
    if (orientation == Orientation.Horizontal) {
      return [
        BoardPoint(x, y),
        BoardPoint(x + 1, y),
        BoardPoint(x, y + 1),
        BoardPoint(x + 1, y + 1),
      ];
    }

    return [
      // BoardPoint(x, y),
      // BoardPoint(x + 1, y),
      // BoardPoint(x, y + 1),
      // BoardPoint(x + 1, y + 1),
    ];
  }
}
