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
  String data = '';

  void updateData(update_data) {
    setState(() {
      data = json.encode(update_data);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('Grading').get();

      if (snapshot.exists) {
        setState(() {
          data = json.encode(snapshot.value);
        });
      }
    } catch (error) {
      print('Error: $error');
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
    if (data == '') {
      // Show loading screen while data is null
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child:
              CircularProgressIndicator(), // You can customize the loading indicator as needed
        ),
      );
    } else {
      var j_data = json.decode(data);
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
                      padding: EdgeInsets.only(right: 65),
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  // Generate 100 widgets that display their index in the List
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: StatusCard(
                          update: updateData,
                          data: j_data,
                          text: "Block A",
                          color_status: getColorStatus(j_data['A']['accuracy']),
                          subtitle:
                              j_data['A']['accuracy'].toStringAsFixed(0) + '%',
                          onPressed: () {}),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: StatusCard(
                          update: updateData,
                          data: j_data,
                          text: "Block B",
                          color_status: getColorStatus(j_data['B']['accuracy']),
                          subtitle:
                              j_data['B']['accuracy'].toStringAsFixed(0) + '%',
                          onPressed: () {}),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: StatusCard(
                          update: updateData,
                          data: j_data,
                          text: "Block C",
                          color_status: getColorStatus(j_data['C']['accuracy']),
                          subtitle:
                              j_data['C']['accuracy'].toStringAsFixed(0) + '%',
                          onPressed: () {}),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: StatusCard(
                          update: updateData,
                          data: j_data,
                          text: "Block D",
                          color_status: getColorStatus(j_data['D']['accuracy']),
                          subtitle:
                              j_data['D']['accuracy'].toStringAsFixed(0) + '%',
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
  }
}
