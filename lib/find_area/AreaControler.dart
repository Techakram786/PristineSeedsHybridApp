import 'package:get/get.dart';
import 'package:flutter/material.dart';
class AreaCalculator {

  double calculatePolygonArea(List<Offset> coordinates) {
    int numPoints = coordinates.length;
    double area = 0.0;

    for (int i = 0; i < numPoints; i++) {
      Offset currentPoint = coordinates[i];
      Offset nextPoint = coordinates[(i + 1) % numPoints]; // Wrap around for the last point

      area += (currentPoint.dx * nextPoint.dy) - (nextPoint.dx * currentPoint.dy);
    }

    // Take the absolute value and divide by 2 to get the area
    area = 0.5 * (area.abs());

    return area;
  }



}
