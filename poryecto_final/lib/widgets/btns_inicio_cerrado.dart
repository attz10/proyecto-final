import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:poryecto_final/constants/colores_const.dart';
import 'package:poryecto_final/services/firebase_service.dart';

Widget btnInicioCerrado(BuildContext drawerContext) {
  bool user = FirebaseService().userEstaLogeado();
  //hay user?
  if(user){
    //hay user
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.red,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(MdiIcons.logout, 
            color: Colores.getAmarillo(),
            size: 35,
          ),
          Text(' Cerrar sesión', style: TextStyle(
            color: Colores.getGris(),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )),
        ],
      ),
      onPressed: () => FirebaseService().cerrarSesion().then((cerradoOK) => Navigator.pop(drawerContext)),
    );
  }
  //no hay user
  return FilledButton(
    style: FilledButton.styleFrom(
      backgroundColor: Colors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(MdiIcons.account, 
          color: Colores.getAmarillo(),
          size: 35,
        ),
        Text(' Iniciar sesión', style: TextStyle(
          color: Colores.getGris(),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        )),
      ],
    ),
    onPressed: () => FirebaseService().iniciarSesion().then((inicioOK) => Navigator.pop(drawerContext)),
  );
}

class BtnsInicioCerradoSesion extends StatelessWidget {
  const BtnsInicioCerradoSesion({super.key,
    required this.drawerContext,
  });

  final BuildContext drawerContext;

  @override
  Widget build(BuildContext context) {
    return btnInicioCerrado(drawerContext);
  }
}