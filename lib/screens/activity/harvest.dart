import 'package:flutter/material.dart';
import 'package:kebun_app/bricks/Widgets Example/price_card.dart';
import 'package:kebun_app/bricks/Widgets Example/status_card.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

class Harvest extends StatefulWidget {
  const Harvest({super.key});

  @override
  State<Harvest> createState() => _HarvestState();
}

class _HarvestState extends State<Harvest> {
  Future<String> fetchData() async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('Grading').get();

      if (snapshot.exists) {
        return (json.encode(snapshot.value));
      } else {
        return '';
      }
    } catch (error) {
      return ('Error: $error');
    }
  }

  Color getColorStatus(int accuracy) {
    if (accuracy == 0) {
      return Colors.grey;
    } else if (accuracy < 100) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the future to complete, show a loading indicator
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // If an error occurs, display an error message
          return Text('Error: ${snapshot.error}');
        } else {
          // If the future completes successfully, display the fetched data
          var data = json.decode(snapshot.data!);
          print(data);

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
                        Padding(
                          padding: EdgeInsets.only(right: 57),
                          child: Text(
                            'Harvest  Activity',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            body: Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Block Harvest Status",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: GridView(
                      // Make a 2 column grid
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      // Generate 100 widgets that display their index in the List
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: StatusCard(
                              text: "Block A",
                              color_status:
                                  getColorStatus(data['A']['accuracy']),
                              subtitle:
                                  data['A']['accuracy'].toStringAsFixed(0) +
                                      '%',
                              onPressed: () {}),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: StatusCard(
                              text: "Block B",
                              color_status:
                                  getColorStatus(data['B']['accuracy']),
                              subtitle:
                                  data['B']['accuracy'].toStringAsFixed(0) +
                                      '%',
                              onPressed: () {}),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: StatusCard(
                              text: "Block C",
                              color_status:
                                  getColorStatus(data['C']['accuracy']),
                              subtitle:
                                  data['C']['accuracy'].toStringAsFixed(0) +
                                      '%',
                              onPressed: () {}),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: StatusCard(
                              text: "Block D",
                              color_status:
                                  getColorStatus(data['D']['accuracy']),
                              subtitle:
                                  data['D']['accuracy'].toStringAsFixed(0) +
                                      '%',
                              onPressed: () {}),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
