import 'package:flutter_puzzle_hack/models/location.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';

class Puzzle {
  final int n;
  final List<Tile> tiles;

  Puzzle({
    required this.n,
    required this.tiles,
  }) : assert(n < 10);

  /// Get whitespace tile
  Tile get whiteSpaceTile => tiles.firstWhere((tile) => tile.tileIsWhiteSpace);

  Location get _whiteSpaceTileLocation => whiteSpaceTile.currentLocation;

  bool tileIsMovable(Tile tile) {
    if (tile.tileIsWhiteSpace) {
      return false;
    }
    Location _tileLocation = tile.currentLocation;
    return _tileLocation.isLocatedAround(_whiteSpaceTileLocation);
  }

  bool tileIsLeftOfWhiteSpace(Tile tile) {
    return tile.currentLocation.isLeftOf(_whiteSpaceTileLocation);
  }

  bool tileIsRightOfWhiteSpace(Tile tile) {
    return tile.currentLocation.isRightOf(_whiteSpaceTileLocation);
  }

  bool tileIsTopOfWhiteSpace(Tile tile) {
    return tile.currentLocation.isTopOf(_whiteSpaceTileLocation);
  }

  bool tileIsBottomOfWhiteSpace(Tile tile) {
    return tile.currentLocation.isBottomOf(_whiteSpaceTileLocation);
  }

  bool tileIsMovableOnXAxis(Tile tile) {
    return tileIsMovable(tile) && (tileIsRightOfWhiteSpace(tile) || tileIsLeftOfWhiteSpace(tile));
  }

  bool tileIsMovableOnYAxis(Tile tile) {
    return tileIsMovable(tile) && (tileIsTopOfWhiteSpace(tile) || tileIsBottomOfWhiteSpace(tile));
  }

  static List<Location> generateTileCorrectLocations(int _n) {
    List<Location> _tilesCorrectLocations = [];
    for (int i = 0; i < _n; i++) {
      for (int j = 0; j < _n; j++) {
        Location _location = Location(y: i + 1, x: j + 1);
        // print(_location.asString);
        _tilesCorrectLocations.add(_location);
      }
    }
    return _tilesCorrectLocations;
  }

  /// Determines if the two tiles are inverted.
  bool _isInversion(Tile a, Tile b) {
    if (!b.tileIsWhiteSpace && a.value != b.value) {
      if (b.value < a.value) {
        return b.currentLocation.compareTo(a.currentLocation) > 0;
      } else {
        return a.currentLocation.compareTo(b.currentLocation) > 0;
      }
    }
    return false;
  }

  /// Gives the number of inversions in a puzzle given its tile arrangement.
  ///
  /// An inversion is when a tile of a lower value is in a greater position than
  /// a tile of a higher value.
  int countInversions() {
    var count = 0;
    for (var a = 0; a < tiles.length; a++) {
      final tileA = tiles[a];
      if (tileA.tileIsWhiteSpace) {
        continue;
      }

      for (var b = a + 1; b < tiles.length; b++) {
        final tileB = tiles[b];
        if (_isInversion(tileA, tileB)) {
          count++;
        }
      }
    }
    return count;
  }

  /// Determines if the puzzle is solvable.
  bool isSolvable() {
    final height = tiles.length ~/ n;
    assert(
      n * height == tiles.length,
      'tiles must be equal to n * height',
    );
    final inversions = countInversions();

    if (n.isOdd) {
      return inversions.isEven;
    }

    final whitespace = tiles.singleWhere((tile) => tile.tileIsWhiteSpace);
    final whitespaceRow = whitespace.currentLocation.y;

    if (((height - whitespaceRow) + 1).isOdd) {
      return inversions.isEven;
    } else {
      return inversions.isOdd;
    }
  }
}
