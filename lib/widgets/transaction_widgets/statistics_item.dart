import 'package:flutter/material.dart';

class StatisticsItem extends StatelessWidget {
  final double finalTakenMoney;
  final double finalGavenMoney;
  final double finalBalance;
  const StatisticsItem(
      {super.key,
      required this.finalTakenMoney,
      required this.finalGavenMoney,
      required this.finalBalance});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      if (finalGavenMoney > finalTakenMoney)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 150,
            width: 250,
            child: Card(
              color: Theme.of(context).primaryColor,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "عليك",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      finalBalance.toStringAsFixed(2),
                      style: const TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ]),
            ),
          ),
        ),
      if (finalGavenMoney < finalTakenMoney)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 150,
            width: 250,
            child: Card(
              color: Theme.of(context).primaryColor,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "لك",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      finalBalance.toStringAsFixed(2),
                      style: const TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ]),
            ),
          ),
        ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 150,
          width: 250,
          child: Card(
            color: Theme.of(context).primaryColor,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "إجمالي المعطى",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                finalGavenMoney.toStringAsFixed(2),
                style: const TextStyle(color: Colors.white, fontSize: 35),
              ),
            ]),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 150,
          width: 250,
          child: Card(
            color: Theme.of(context).primaryColor,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "إجمالي المأخوذ",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                finalTakenMoney.toStringAsFixed(2),
                style: const TextStyle(color: Colors.white, fontSize: 35),
              ),
            ]),
          ),
        ),
      ),
    ]);
  }
}
