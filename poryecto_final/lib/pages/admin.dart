import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:poryecto_final/constants/colores_const.dart';
//import 'package:poryecto_final/pages/listado.dart';
import 'package:poryecto_final/pages/listado_admin.dart';
import 'package:poryecto_final/widgets/drawer_widget.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key
      key: scaffoldKey,
      //appbar
      appBar: AppBar(
        backgroundColor: Colores.getGris(),
        iconTheme: IconThemeData(color: Colores.getAmarillo()),
        leading: Icon(MdiIcons.partyPopper),
        title: Row(
          children: [
            Text('  App de eventos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                )),
            Text(' TE',
                style: TextStyle(
                  color: Colores.getAmarillo(),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
      //body
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            //titulo
            /*Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 20, top: 5),
              decoration: BoxDecoration(
                color: Colores.getGris(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('Listado de eventos disponibles',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
            ),*/
            //eventos
            Expanded(
              child: ListadoAdmin(),
            ),
          ],
        ),
      ),
      //drawer
      endDrawer: Drawer(
        backgroundColor: Colores.getGris(),
        child: DrawerWidget(homeContext: context),
      ),
    );
  }
}
