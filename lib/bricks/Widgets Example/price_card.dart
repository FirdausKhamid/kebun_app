import 'package:flutter/material.dart';

class PriceCard extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String subtitle;
  final Function() onPressed;

  const PriceCard(
      {required this.text,
      required this.imageUrl,
      required this.subtitle,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 150,
        height: 150,
        padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
        decoration: BoxDecoration(
          color: Color.fromARGB(31, 255, 251, 251),
          borderRadius: BorderRadius.circular(12.5),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Image.asset(imageUrl, height: 59, fit: BoxFit.cover),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
