import 'package:flutter/foundation.dart';

class AlphabetProvider with ChangeNotifier {
  int currentIndex = 0;

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
