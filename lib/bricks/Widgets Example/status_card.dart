import 'package:flutter/material.dart';
import 'package:kebun_app/bricks/Widgets%20Example/dialog.dart';

class StatusCard extends StatelessWidget {
  final String text;
  final Color color_status;
  final String subtitle;
  final Function() onPressed;

  var data;
  bool isButtonEnabled = true;
  Function update;

  StatusCard(
      {required this.text,
      required this.data,
      required this.color_status,
      required this.subtitle,
      required this.onPressed,
      required this.update,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data[text[text.length - 1]]['accuracy'] == 0) {
      isButtonEnabled = false;
    }
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 200,
        height: 200,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(12.5),
        ),
        child: Column(
          children: [
            Text(text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
            SizedBox(
              height: 10,
            ),
            // test git
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: color_status,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 20),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 20, 20, 20),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: isButtonEnabled
                  ? () {
                      showDialog<Dialog>(
                        context: context,
                        builder: (BuildContext context) => DialogFb1(
                          text: this.text,
                          data: this.data,
                          update: this.update,
                        ),
                      );
                    }
                  : null, // Set onPressed to null when the button should be disabled
              child: Text(
                'Update',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
