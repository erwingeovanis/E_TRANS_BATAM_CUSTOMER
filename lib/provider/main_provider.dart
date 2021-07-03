import 'package:e_trans/data/models/halte.dart';
import 'package:e_trans/data/models/jurusan.dart';
import 'package:e_trans/data/models/news.dart';
import 'package:e_trans/data/service/network_service.dart';
import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  MainProvider._internal();
  static final _singleton = MainProvider._internal();
  factory MainProvider() => _singleton;

  final NetworkService networkService = NetworkService();
  List<Halte> _halte = [];
  List<Halte> get halte => _halte;
  List<News> _news = [];
  List<News> get news => _news;
  List<Jurusan>? _jurusan;
  List<Jurusan>? get jurusan => _jurusan;
  Map<String, List<Halte>> get halteByArea => _halteByArea();
  loadAllData() async {
    await loadhalte();
    await loadnews();
    await loadJurusan();
  }

  loadhalte() async {
    var result = await networkService.getHalte();
    _halte = result;
    notifyListeners();
  }

  loadJurusan() async {
    var jurList = await networkService.getJurusan();
    _jurusan = jurList;
    notifyListeners();
  }

  loadnews() async {
    var itemList = await networkService.getNews();
    _news = itemList;
    notifyListeners();
  }

  _halteByArea() {
    Map<String, List<Halte>> map = {};
    Set<String> areas = _halte.map<String>((e) => e.daerah ?? "").toSet();
    areas.forEach((element) =>
        map[element] = _halte.where((e) => e.daerah == element).toList());
    return map;
  }
}
