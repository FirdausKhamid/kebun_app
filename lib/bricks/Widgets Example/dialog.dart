import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DialogFb1 extends StatelessWidget {
  final String text;
  Function update;
  var data;

  Future<void> updateData(block) async {
    final ref = FirebaseDatabase.instance.ref();
    await ref.child('Grading/' + block).update({'accuracy': 0});
  }

  DialogFb1(
      {Key? key, required this.text, required this.data, required this.update})
      : super(key: key);
  final primaryColor = Colors.green[900];
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80, child: Image.asset("assets/fruit.png")),
            const SizedBox(
              height: 15,
            ),
            const Text("Is the block fully harvested?",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 3.5,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimpleBtn1(
                    text: "Yes",
                    onPressed: () {
                      var block = (text[text.length - 1]);
                      this.data[block]['accuracy'] = 0;
                      this.update(data);
                      updateData(block);
                      Navigator.pop(context); // Close the dialog
                    }),
                SimpleBtn1(
                  text: "No",
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  invertedColors: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SimpleBtn1 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool invertedColors;
  SimpleBtn1(
      {required this.text,
      required this.onPressed,
      this.invertedColors = false,
      Key? key})
      : super(key: key);
  final primaryColor = Colors.green[900];
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            alignment: Alignment.center,
            side: MaterialStateProperty.all(
                BorderSide(width: 1, color: Colors.green[900]!)),
            padding: MaterialStateProperty.all(
                const EdgeInsets.only(right: 25, left: 25, top: 0, bottom: 0)),
            backgroundColor: MaterialStateProperty.all(
                invertedColors ? accentColor : primaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            )),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: invertedColors ? primaryColor : accentColor, fontSize: 16),
        ));
  }
}
