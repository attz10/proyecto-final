import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:poryecto_final/constants/colores_const.dart';
import 'package:poryecto_final/services/firebase_service.dart';
import 'package:poryecto_final/widgets/btns_inicio_cerrado.dart';
import 'package:poryecto_final/widgets/drawer_tile_widget.dart';

//poner imagen al user
String imgUser() {
  bool user = FirebaseService().userEstaLogeado();
  if(user) {
    //el user es está logeado
    return 'admin_user.jpg';
  }
  //el user NO está logeado
  return 'user_image.png';
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60, right: 12, left: 12, bottom: 12),
      child: Column(
        children: [
          //seccion del user
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Color(0xFF787878),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                //imagen user
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colores.getAmarillo(), width: 4),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('images/'+imgUser()),
                    ),
                  ),
                ),
                //nombre user
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text('@'+'{Nombre del usuario}', style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  )),
                ),
              ],
            ),
          ),
          //divisor
          Divider(color: Colors.transparent),
          //opciones del user
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF787878),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                children: [
                  //administrar cuenta
                  DrawerTileWidget(
                    icono: MdiIcons.cogBox,
                    titulo: 'Administrar cuenta',
                  ),
                ],
              ),
            ),
          ),
          //btn cerrar y inciar sesion
          Container(
            margin: EdgeInsets.only(top: 25, bottom: 10),
            child: BtnsInicioCerradoSesion(drawerContext: context),
          ),
        ],
      ),
    );
  }
}