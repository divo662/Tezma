import 'package:flutter/material.dart';
class ToggleButton extends StatefulWidget {
  final String title;
  final String content;
   const ToggleButton({Key? key, required this.title, required this.content,}) : super(key: key);

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(widget.content,
                style:  TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        Switch(value: isSelected,
            onChanged: (bool value){
          setState(() {
            isSelected = value;
          });
            })
        ],
      ),
    );
  }
}
