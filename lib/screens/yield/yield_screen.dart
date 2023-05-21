import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kebun_app/bricks/Widgets Example/cardwidget.dart';
import 'package:kebun_app/bricks/Widgets Example/price_card.dart';
import 'package:kebun_app/bricks/Widgets Example/delivery_record.dart';
import 'package:kebun_app/screens/yield/bar_graph.dart';

class Yield extends StatefulWidget {
  const Yield({super.key});

  @override
  State<Yield> createState() => _YieldState();
}

class _YieldState extends State<Yield> {
  final List<double> monthlySummary = [
    10.0,
    20.3,
    30.0,
    20.1,
    25.9,
    10.1,
    20.1,
    30.0,
    20.5,
    25.5,
    30.1,
    10.0,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 47, 47, 47),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 47, 47, 47),
            elevation: 0,
            centerTitle: false,
            title: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Yield',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: Center(
          child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyBarGraph(
                monthlySummary: monthlySummary,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeliveryRecord()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: BalanceCard(
                title: "Total Delivery",
                body: "Your current balance is",
                subInfoText: " 9.3 Tan",
                subInfoTitle: "Up until 13 Apr 2023",
                onMoreTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(31, 255, 251, 251),
              ),
              height: 120,
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(
                      value: 0.372,
                      backgroundColor: Colors.grey,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                      strokeWidth: 15,
                    ),
                  ),
                  const SizedBox(width: 50),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Monthly Goals | APRIL ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '15.7 Tan left to collect',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '17 Days Remaining ',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: GridView(
              // Make a 2 column grid
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              // Generate 100 widgets that display their index in the List
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 70),
                  child: PriceCard(
                      text: "Suggestion",
                      imageUrl: "assets/suggestion.png",
                      subtitle: "",
                      onPressed: () {}),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 30, 70),
                  child: PriceCard(
                      text: "Cheque Record",
                      imageUrl: "assets/check.png",
                      subtitle: "",
                      onPressed: () {}),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
