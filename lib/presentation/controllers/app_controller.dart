import 'package:get/get.dart';
import '../../data/models/wine_by_model.dart';
import '../../data/models/wine_model.dart';
import '../../data/repository/wine_repository_impl.dart';


class AppController extends GetxController {
  RxList<WineModel> wineList = <WineModel>[].obs;
  RxList<WinesByModel> winesByList = <WinesByModel>[].obs; // Lista pentru `wines_by`

  // Instanțiem WineRepositoryImpl
  final WineRepositoryImpl _wineRepository = WineRepositoryImpl();

  @override
  void onInit() {
    super.onInit();
    loadWinesFromRepository();
  }

  // Modificăm funcția pentru a utiliza repository-ul
  Future<void> loadWinesFromRepository() async {
    try {
      // Încarcă datele pentru `wines_by` folosind repository-ul
      List<WinesByModel> winesByData = await _wineRepository.getWinesByModelFromJson();
      winesByList.value = winesByData;

      // Încarcă datele pentru `carousel` (WineModel) folosind repository-ul
      List<WineModel> wineData = await _wineRepository.getWinesFromJson();
      wineList.value = wineData;

      // Afișează datele pentru `wines_by` în consolă
      for (var item in winesByList.value) {
        print('Tag: ${item.tag}, Name: ${item.name}');
      }

      // Afișează datele pentru `carousel` în consolă
      for (var wine in wineList.value) {
        print('Wine: ${wine.name}, Type: ${wine.type}, Country: ${wine.country}, Price: ${wine.price}');
      }
    } catch (e) {
      print('Error loading wines: $e');
    }
  }
}
