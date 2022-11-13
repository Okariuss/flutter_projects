import 'package:flutter/widgets.dart';

class CalculateBMIProvider extends ChangeNotifier {
  double result = 0;
  String text = "";

  void calculateResult(double height, double mass) {
    result = mass / (height * height);
    notifyListeners();
  }

  double getResult() {
    return result;
  }

  void textResult(double value) {
    if (value > 25) {
      text = "You're over weight";
    } else if (value > 18.5) {
      text = "You're normal weight";
    } else {
      text = "You're under weight";
    }

    notifyListeners();
  }

  String getTextResult() {
    return text;
  }
}
