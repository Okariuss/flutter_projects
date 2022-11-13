import 'package:bmi_calculator/constants/app_constants.dart';
import 'package:bmi_calculator/providers/calculate_bmi_provider.dart';
import 'package:bmi_calculator/widgets/left_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/right_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMI Calculator",
          style: TextStyle(color: accentHexColor, fontWeight: FontWeight.w300),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: mainHexColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                inputText(_heightController, "Height"),
                inputText(_widthController, "Mass"),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Consumer<CalculateBMIProvider>(
              builder: (context, resultModelNesne, child) {
                return GestureDetector(
                  onTap: () {
                    double h = double.parse(_heightController.text) / 100;
                    double w = double.parse(_widthController.text);
                    resultModelNesne.calculateResult(h, w);
                    resultModelNesne.textResult(resultModelNesne.getResult());
                  },
                  child: Text(
                    "Calculate",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: accentHexColor),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Consumer<CalculateBMIProvider>(
              builder: (context, resultModelNesne, child) {
                return Text(resultModelNesne.getResult().toStringAsFixed(2),
                    style: TextStyle(fontSize: 90, color: accentHexColor));
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Consumer<CalculateBMIProvider>(
              builder: (context, resultModelNesne, child) {
                return Visibility(
                  visible: resultModelNesne.getTextResult().isNotEmpty,
                  child: Text(
                    resultModelNesne.getTextResult(),
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                        color: accentHexColor),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const LeftBar(barWidth: 40),
            const SizedBox(
              height: 20,
            ),
            const LeftBar(barWidth: 70),
            const SizedBox(
              height: 20,
            ),
            const LeftBar(
              barWidth: 40,
            ),
            const SizedBox(
              height: 20,
            ),
            const RightBar(barWidth: 70),
            const SizedBox(
              height: 50,
            ),
            const RightBar(barWidth: 70),
          ],
        ),
      ),
    );
  }

  SizedBox inputText(TextEditingController controller, String name) {
    return SizedBox(
      width: 130,
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w300,
          color: accentHexColor,
        ),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: name,
            hintStyle: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w300,
              color: Colors.white.withOpacity(.8),
            )),
      ),
    );
  }
}
