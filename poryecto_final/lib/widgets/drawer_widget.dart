import 'package:flutter/material.dart';
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

//poner nombre al user
String nombreUser() {
  bool user = FirebaseService().userEstaLogeado();
  if(user) {
    return 'Administrador';
  }
  return 'inicie sesión';
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key,
    required this.homeContext,
  });

  //la scaffoldKey del home
  final BuildContext homeContext;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60, right: 12, left: 12, bottom: 12),
      child: StreamBuilder(
        stream: FirebaseService().usuario,
        builder: (context, User) {
          return Column(
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
                      child: Text(nombreUser(), style: TextStyle(
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
                  child: DrawerTileWidget(),
                ),
              ),
              //btn cerrar y inciar sesion
              Container(
                margin: EdgeInsets.only(top: 25, bottom: 10),
                child: BtnsInicioCerradoSesion(drawerContext: context, homeContext: homeContext),
              ),
            ],
        );
        },
      ),
    );
  }
}