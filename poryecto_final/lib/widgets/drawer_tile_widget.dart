import 'package:flutter/material.dart';
import 'package:poryecto_final/constants/colores_const.dart';

class DrawerTileWidget extends StatelessWidget {
  const DrawerTileWidget({
    super.key,
    required this.icono,
    required this.titulo,
  });

  final IconData icono;
  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(this.icono, 
          color: Colores.getAmarillo(),
          size: 32,
        ),
        title: Text(this.titulo, style: TextStyle(
          color: Colores.getGris(),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        )),
        onTap: () {},
      ),
    );
  }
}