import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:wine_shop/domain/repository/wine_repository.dart';
import '../models/wine_by_model.dart';
import '../models/wine_model.dart';

class WineRepositoryImpl implements WineRepository {
  @override
  Future<List<WinesByModel>> getWinesByModelFromJson() async {
    // Load JSON data from assets
    final String response = await rootBundle.loadString('assets/v3.json');

    // Decode JSON data
    final Map<String, dynamic> jsonData = json.decode(response);

    // Extract carousel data from the JSON
    final List<dynamic> carouselData = jsonData['wines_by'];

    // Convert the carousel data to WineModel objects
    List<WinesByModel> wineList = carouselData.map((wine) => WinesByModel.fromJson(wine)).toList();

    // Return the mapped list of WinesByModel
    return wineList;
  }

  @override
  Future<List<WineModel>> getWinesFromJson() async {
    // Load JSON data from assets
    final String response = await rootBundle.loadString('assets/v3.json');

    // Decode JSON data
    final Map<String, dynamic> jsonData = json.decode(response);

    // Extract wines data from the JSON (assuming 'wines' is another part of the JSON)
    final List<dynamic> winesData = jsonData['carousel'];

    // Convert the wines data to WineModel objects
    List<WineModel> wineList = winesData.map((wine) => WineModel.fromJson(wine)).toList();

    // Return the list of WineModel
    return wineList;
  }
}
