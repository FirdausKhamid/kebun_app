import 'package:flutter/material.dart';
import 'package:kebun_app/bricks/Widgets%20Example/promo_card.dart';
import 'package:kebun_app/screens/googlemap/MapGrid.dart';
import 'package:kebun_app/screens/activity/harvest.dart';
import '../../bricks/Widgets Example/horizontal_card.dart';

class Activity extends StatelessWidget {
  const Activity({super.key});

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
                    'Activity',
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: ListView(
          children: [
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ImageCard(
                  text: 'Harvest',
                  imageUrl: 'assets/harvest_activity.png',
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Harvest()),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ImageCard(
                text: 'Fertilization',
                imageUrl: 'assets/activity_fertilize.jpeg',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ImageCard(
                text: 'Herbicide',
                imageUrl: 'assets/herbicide_activity.jpeg',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ImageCard(
                text: 'Pruning',
                imageUrl: 'assets/pruning_activity.jpeg',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapGrid()),
                  );
                },
                child: ImageCard(
                  text: 'Road Maintenance',
                  imageUrl: 'assets/roadfix_activity.png',
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
