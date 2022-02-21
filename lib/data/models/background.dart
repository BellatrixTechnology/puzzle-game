import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/data/models/background_layer.dart';

class Background {
  static List<BackgroundLayerType> backgroundLayerTypes = [
    BackgroundLayerType.topRightPlanet,
    BackgroundLayerType.topLeftPlanet,
    BackgroundLayerType.topBgPlanet,
    BackgroundLayerType.bottomLeftPlanet,
    BackgroundLayerType.bottomBgPlanet,
    BackgroundLayerType.bottomRightPlanet,
  ];

  static List<BackgroundLayer> getLayers(BuildContext context) {
    return List.generate(
      backgroundLayerTypes.length,
      (i) => BackgroundLayer(context, type: backgroundLayerTypes[i]),
    );
  }
}