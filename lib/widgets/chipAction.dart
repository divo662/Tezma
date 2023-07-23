import 'package:flutter/material.dart';

class ChipAction extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const ChipAction({Key? key, required this.text, this.onTap}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(6),
        child: Chip(
          backgroundColor: Colors.grey.shade800,
            label: Text(text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),)
        ),
      ),
    );
  }
}
