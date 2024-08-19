import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Color corBgd;
  final Color corText;
  final String nameBtn;
  final VoidCallback myFunction;
  final Icon myIcon;

  ActionButton({
    required this.corBgd,
    required this.corText,
    required this.nameBtn,
    required this.myFunction,
    required this.myIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: corBgd,
        foregroundColor: corText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        minimumSize: const Size(130, 50),
        maximumSize: const Size(130, 50),
      ),
      onPressed: myFunction,
      label: Text(nameBtn),
      icon: myIcon,
    );
  }
}
