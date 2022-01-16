//singleton

enum PlayerType {
  Player,
  Computer,
}

class BoardService {
  late Board playerBoard;
  late Board computerBoard;

  void start(boardWidth, boardHeight) {
    this.playerBoard = createBoard(boardWidth, boardHeight);
    this.computerBoard = createBoard(boardWidth, boardHeight);
  }

  Board createBoard(int width, int height) {
    return Board(width: width, height: height);
  }

  // Board insertShip(Ship ship, BoardPoint point, Orientation orientation, PlayerType playerType) {
  //   if(playerBoard == PlayerType.Player) {
  //     computerBoard.
  //   }
  // }

}

class Board {
  late int width;
  late int height;
  late List<List<int>> _board;

  Board({required this.width, required this.height}) {
    _board = _populatedBoard(width, height);
  }

  List<List<int>> _populatedBoard(int width, int height) {
    final List<List<int>> board = [];

    for (int i = 0; i < width; i++) {
      board.add(List.generate(height, (index) => 0));
    }

    return board;
  }
}



// class Board {
//   late int linesAmount;
//   late int tilesByLineAmount;
//   late List<List<int>> _board;

//   Board({required this.linesAmount, required this.tilesByLineAmount}) {
//     _board = _populatedBoard(linesAmount, tilesByLineAmount);
//   }

//   List<List<int>> _populatedBoard(int linesAmount, int tilesByLineAmount) {
//     final List<List<int>> board = [];

//     for (int i = 0; i < linesAmount; i++) {
//       board.add(List.generate(tilesByLineAmount, (index) => 0));
//     }

//     return board;
//   }

//   void printBoard() {
//     for (int i = 0; i < linesAmount; i++) {
//       print(_board[i]);
//     }
//     print("\n");
//   }

//   void insertShip(Ship ship, BoardPoint point, Orientation orientation) {
//     ship.pointsFrom(point.x, point.y, orientation).forEach((point) {
//       //print(point.x);
//       //print(point.y);
//       _board[point.x][point.y] = 1;
//     });
//   }
// }
