import 'package:flutter/material.dart';
import 'package:poryecto_final/constants/colores_const.dart';

class UtilMensaje {
  static void mostrarSnackbar(BuildContext context, IconData icono, String texto, {int duracion = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icono, color: Colores.getAmarillo(), size: 30),
          Text(' ' + texto, style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          )),
        ],
      ),
      duration: Duration(seconds: duracion),
    ));
  }
}