import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:poryecto_final/constants/colores_const.dart';
import 'package:poryecto_final/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poryecto_final/utils/msg_scaffold_util.dart';

//cambiar icono del like
IconData setLikeImg(bool meGusta){
  IconData icono = meGusta == false ? MdiIcons.thumbUpOutline : MdiIcons.thumbUp;
  return icono;
}

//poner texto si el evento está inactivo 
Text setInactivo(bool activo){
  String texto = '';
  if(activo == false) {
    texto = '{NO DISPONIBLE}';
  }
  return Text('${texto}', style: TextStyle(color: Colors.redAccent, 
  fontWeight: FontWeight.bold,
  fontSize: 18,
  ));
}

//dar borde rojo si no esta disponible el evento
BoxBorder setBordeInactivo(bool activo) {
  //evento inactivo?
  if(activo == false) {
    //si, está inactivo
    return Border.all(color: Colors.red,width: 4,);
  }
  //no, est+a activo
  return Border.all(color: Colors.green, width: 2);
}

//ver fecha
DateTime getFechaEvento(Timestamp fecha) {
  return fecha.toDate();
}

class Listado extends StatelessWidget {
  final formatoFecha = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 15),
      child: StreamBuilder(
        stream: FirebaseService().eventos(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.transparent),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var evento = snapshot.data!.docs[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colores.getGris(),
                    border: setBordeInactivo(evento['activo']),
                  ),
                  //información del evento
                  child: Slidable(
                    //opciones a la izquierda
                    startActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        //cambiar estado
                        SlidableAction(
                          backgroundColor: Colors.orangeAccent,
                          foregroundColor: Colors.white,
                          icon: MdiIcons.cog,
                          label: 'Cambiar estado',
                          onPressed: (context) {
                            bool user = FirebaseService().userEstaLogeado();
                            //el user es admin?
                            if (user) {
                              //es admin
                              FirebaseService().estadoEvento(evento.id, evento['activo']);

                              UtilMensaje.mostrarSnackbar(context,
                                  MdiIcons.stateMachine, 'estado cambiado');
                            }
                            //no es admin
                            else {
                              UtilMensaje.mostrarSnackbar(
                                context,
                                MdiIcons.alertCircle,
                                'Error, usted no es administrador',
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    //opciones a la derecha
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        //borrar
                        SlidableAction(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: MdiIcons.trashCan,
                          label: 'Borrar',
                          onPressed: (context) {
                            bool user = FirebaseService().userEstaLogeado();
                            //el user es admin?
                            if (user) {
                              //es admin
                              FirebaseService().borrarEvento(evento.id);

                              UtilMensaje.mostrarSnackbar(context,
                                  MdiIcons.delete, 'borrado con exito');
                            }
                            //no es admin
                            else {
                              UtilMensaje.mostrarSnackbar(
                                  context,
                                  MdiIcons.alertCircle,
                                  'Error, usted no es administrador');
                            }
                          },
                        ),
                      ],
                    ),
                    //contenido
                    child: Column(
                      children: [
                        //imagen
                        Container(
                          color: Colors.white,
                          height: 200,
                        ),
                        //titulo
                        Container(
                          child: Text(evento['nombre'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        //like y fecha
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //likes
                              Row(
                                children: [
                                  InkWell(
                                    child: Icon(
                                      setLikeImg(evento['megusta']),
                                      color: Colors.white,
                                    ),
                                    onTap: () {
                                      //quiere deslikear?
                                      if(evento['megusta'] == true) {
                                        //restar like
                                        FirebaseService().eliminarLike(evento.id, evento['likes']);
                                        //mensaje
                                        UtilMensaje.mostrarSnackbar(
                                          context,
                                          MdiIcons.thumbDown,
                                          '${evento['nombre']}',
                                        );
                                      }
                                      //sumar like
                                      else {
                                        //sumar like
                                        FirebaseService().editarLikes(
                                            evento.id, evento['likes'], evento['megusta']);
                                        //mensaje
                                        UtilMensaje.mostrarSnackbar(
                                          context,
                                          MdiIcons.thumbUp,
                                          '${evento['nombre']}',
                                        );
                                      }
                                    },
                                  ),
                                  Text('  ${evento['likes']}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                              //fecha
                              Text('Fecha: '+formatoFecha.format(getFechaEvento(evento['fecha'])),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                        //descripcion del evento
                        Container(
                          padding: EdgeInsets.all(5),
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 80),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadiusDirectional.circular(15),
                          ),
                          child: InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(MdiIcons.informationOutline,
                                    color: Colors.white),
                                Text(' Descripción',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                            onTap: () {
                              //ver la descripción del evento
                              UtilMensaje.mostrarSnackbar(
                                context,
                                MdiIcons.information,
                                '${evento['descripcion']}',
                                duracion: 4,
                              );
                            },
                          ),
                        ),
                        //si está inactivo
                        Container(
                          child: setInactivo(evento['activo']),
                        ),
                        Divider(color: Colors.transparent, height: 4),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
