import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:poryecto_final/constants/colores_const.dart';
import 'package:poryecto_final/pages/ingresar_evento.dart';
import 'package:poryecto_final/pages/listado.dart';
import 'package:poryecto_final/services/firebase_service.dart';
import 'package:poryecto_final/utils/msg_scaffold_util.dart';
import 'package:poryecto_final/widgets/drawer_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //variables
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
        padding: EdgeInsets.only(left: 5, top: 5, right: 5),
        child: Column(
          children: [
            //titulo
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 10, top: 5),
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
            ),
            //eventos
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colores.getFondo(),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.green,
                    width: 1.5,
                  ),
                ),
                child: Listado(),
              ),
            ),
          ],
        ),
      ),
      //drawer
      endDrawer: Drawer(
        backgroundColor: Colores.getGris(),
        child: DrawerWidget(homeContext: context),
      ),
      //boton de agregado flotante
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(
          MdiIcons.plus,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () {
          bool user = FirebaseService().userEstaLogeado();
          //el user es admin?
          if (user) {
            //si lo es, ir a la página de agregado
            MaterialPageRoute ruta =
                MaterialPageRoute(builder: (context) => IngresarEvento());
            Navigator.push(context, ruta);
          }
          //no es admin
          else {
            UtilMensaje.mostrarSnackbar(
                context, MdiIcons.alertOutline, 'Error, no es administrador');
          }
        },
      ),
    );
  }
}
