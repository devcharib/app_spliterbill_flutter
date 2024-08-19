import 'package:flutter/material.dart';
import '../models/colors.dart';

class FieldtextButton extends StatelessWidget {
  final String nameFild;
  final String nameButton;
  final TextEditingController controller;
  final VoidCallback myFunction;
  final TextInputType keyBoard;
  final Icon myIcon;
  Cores _cores = Cores();

  FieldtextButton({
    required this.nameFild,
    required this.nameButton,
    required this.myFunction,
    required this.controller,
    required this.keyBoard,
    required this.myIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //aqui tinha um expanded
        SizedBox(
          width: 233,
          child: TextField(
            keyboardType: keyBoard,
            controller: controller,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: nameFild,
              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        //aqui
        SizedBox(width: 8),
        Expanded(
          // controla a largura do botao
          child: ElevatedButton.icon(
            icon: myIcon,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              minimumSize: Size(100, 50),
            ),
            onPressed: myFunction,
            label: Text(
              nameButton,
              style: TextStyle(color: _cores.cor5),
            ),
          ),
        ),
      ],
    );
  }
}
