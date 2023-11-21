import 'package:flutter/material.dart';
import 'package:poryecto_final/constants/colores_const.dart';
import 'package:poryecto_final/constants/opciones_user_logeado.dart';

class DrawerTileWidget extends StatelessWidget {
  final List opciones = OpcionesUser().getOpcionesNormal();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      children: opciones.map((opcion) {
        return Container(
          margin: EdgeInsets.only(bottom: 15),
          height: 65,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            //icono
            leading: Icon(opcion['icono'], 
              color: Colores.getAmarillo(),
              size: 32,
            ),
            //titulo
            title: Text(opcion['titulo'].toString(), style: TextStyle(
              color: Colores.getGris(),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
            onTap: () {},
          ),
        );
      }).toList(),
    );
  }
}