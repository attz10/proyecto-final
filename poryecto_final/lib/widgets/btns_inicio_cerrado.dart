import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:poryecto_final/constants/colores_const.dart';
import 'package:poryecto_final/services/firebase_service.dart';
import 'package:poryecto_final/utils/msg_scaffold_util.dart';

Widget btnInicioCerrado(BuildContext drawerContext, BuildContext homeContext) {
  bool user = FirebaseService().userEstaLogeado();
  //hay user?
  if (user) {
    //hay user
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.red,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            MdiIcons.logout,
            color: Colores.getAmarillo(),
            size: 35,
          ),
          Text(' Cerrar sesión',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
      onPressed: () => FirebaseService().cerrarSesion().then((cerradoOK) {
        //cierro drawer
        Navigator.pop(drawerContext);
        //mando mensaje en el home
        UtilMensaje.mostrarSnackbar(
            homeContext, MdiIcons.checkBold, 'Cerrado de sesión exitoso');
      }),
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
        Icon(
          MdiIcons.account,
          color: Colores.getAmarillo(),
          size: 35,
        ),
        Text(' Iniciar sesión',
            style: TextStyle(
              color: Colores.getGris(),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
      ],
    ),
    onPressed: () => FirebaseService().iniciarSesion().then((inicioOK) {
      //cierro drawer
      Navigator.pop(drawerContext);
      //mando mensaje en el home
      UtilMensaje.mostrarSnackbar(
          homeContext, MdiIcons.checkBold, 'Inicio de sesión exitoso');
    }),
  );
}

class BtnsInicioCerradoSesion extends StatelessWidget {
  const BtnsInicioCerradoSesion({
    super.key,
    required this.drawerContext,
    required this.homeContext,
  });

  //variables
  final BuildContext drawerContext;
  //scaffoldKey del home
  final BuildContext homeContext;

  @override
  Widget build(BuildContext context) {
    return btnInicioCerrado(drawerContext, homeContext);
  }
}
