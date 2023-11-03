import 'package:shared_preferences/shared_preferences.dart';

class StoreScore {
  Future<void> initialise() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('writing_score')) {
      await prefs.setDouble('writing_score', 0.0);
    }
    if (!prefs.containsKey('recognition_score')) {
      await prefs.setDouble('recognition_score', 0.0);
    }
  }

  Future<double> loadWritingScore() async {
    final prefs = await SharedPreferences.getInstance();
    final storedScore = prefs.getDouble('writing_score');
    print('scoreeeeeeeeeeeeeeeeeeeee:' + storedScore.toString());
    if (storedScore != null) {
      return storedScore;
    } else {
      return 0.0;
    }
  }

  Future<void> updateWritingScore(double newScore) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('writing_score', newScore);
  }

  Future<double> loadRecognitionScore() async {
    final prefs = await SharedPreferences.getInstance();
    final storedScore = prefs.getDouble('recognition_score');
    if (storedScore != null) {
      return storedScore;
    } else {
      return 0.0;
    }
  }

  Future<void> updateRecognitionScore(double newScore) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('recognition_score', newScore);
  }

  Future<List<Map<String, dynamic>?>> returnScore() async {
    final prefs = await SharedPreferences.getInstance();
    double? recognitionScore = prefs.getDouble('recognition_score');
    recognitionScore =
        double.parse(((recognitionScore! / 26) * 100).toStringAsFixed(2));
    double? writingScore = prefs.getDouble('writing_score');
    writingScore =
        double.parse(((writingScore! / 36) * 100).toStringAsFixed(2));
    return [
      {'label': 'Writing', 'value': writingScore},
      {'label': 'Recognition', 'value': recognitionScore},
    ];
  }
}
