import 'package:flutter/material.dart';
class ContainerButtonWidget extends StatelessWidget {
  final Color color;
  final String  texto;

  const ContainerButtonWidget({Key? key, required this.color, required this.texto, }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Container(

      height: 45,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),

      child: Text(
        texto,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}
