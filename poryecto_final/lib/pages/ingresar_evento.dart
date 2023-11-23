import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:poryecto_final/constants/colores_const.dart';
import 'package:poryecto_final/services/firebase_service.dart';

//mostrar que no hay imagen
Widget noHayImagen() {
  return Image.asset('images/no_imagen.jpg');
}

//mostrar imagen
Widget mostrarImagen(File img) {
  return Image.file(img);
}

class IngresarEvento extends StatefulWidget {
  const IngresarEvento({super.key});

  @override
  State<IngresarEvento> createState() => _IngresarEventoState();
}

class _IngresarEventoState extends State<IngresarEvento> {
  TextEditingController ctrlNombre = TextEditingController();
  TextEditingController ctrlDescripcion = TextEditingController();
  TextEditingController ctrlLugar = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final formatoFecha = DateFormat('dd-MM-yyyy');
  DateTime fecha_hoy =  DateTime.now();
  final ImagePicker _img = ImagePicker();
  XFile? imagen = null;
  File? imagen_para_subir;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colores.getAmarillo()),
        backgroundColor: Colores.getGris(),
        title: Text(
          'Agregue un evento',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      //body
      body: Padding(
        padding: const EdgeInsets.all(5),
        //formulario
        child: Container(
          decoration: BoxDecoration(
            color: Colores.getFondo(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    //nombre de evento
                    TextFormField(
                      controller: ctrlNombre,
                      decoration: InputDecoration(
                        label: Text('Nombre de evento', style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                    ),
                    Divider(color: Colors.transparent),
                    //descripcion
                    TextFormField(
                      controller: ctrlDescripcion,
                      decoration: InputDecoration(
                        label: Text('Describa el evento (descripcion breve)', style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                    ),
                    Divider(color: Colors.transparent),
                    //lugar
                    TextFormField(
                      controller: ctrlLugar,
                      decoration:
                        InputDecoration(
                          label: Text('Lugar a desarrolar evento', style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),
                        ),
                    ),
                    Divider(color: Colors.transparent),
                    //fecha
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Text('Fecha de Evento: ', style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          )),
                          Text(formatoFecha.format(fecha_hoy), style: 
                          TextStyle(
                              fontWeight: FontWeight.bold, 
                              fontSize: 16,
                            )),
                          IconButton(
                            icon: Icon(MdiIcons.calendar),
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2024),
                                locale: Locale('es', 'ES'),
                              ).then((fecha) {
                                setState(() {
                                  fecha_hoy = fecha ?? fecha_hoy;
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.transparent),
                    //imagen
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(MdiIcons.imageArea, 
                              color: Colores.getAmarillo(),
                              size: 35,
                            ),
                            Text('Seleccione una imagen', style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            )),
                          ],
                        ),
                        onTap: () async {
                          imagen = await _img.pickImage(source: ImageSource.gallery);
                          setState(() {
                            //refrescar pagina
                            imagen_para_subir = File(imagen!.path);
                          });
                        },
                      ),
                    ),
                    Divider(color: Colors.transparent),
                    //mostrar imagen
                    Container(
                      child: Container(
                        height: 200,
                        child: imagen == null ? noHayImagen() : Image.file(imagen_para_subir!),
                      ),
                    ),
                    Spacer(),
                    //botones
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                        ),
                        onPressed: () {
                          FirebaseService()
                              .eventoAgregar(ctrlNombre.text, ctrlDescripcion.text,
                                  ctrlLugar.text, fecha_hoy, imagen_para_subir!)
                              .then((value) => Navigator.pop(context));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(MdiIcons.plus, 
                              color: Colores.getAmarillo(),
                              size: 40,
                            ),
                            Text('Agregar', style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            )),
                          ],
                        ),
                      ),
                    ),
                    Divider(color: Colors.transparent),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(MdiIcons.close, 
                              color: Colores.getAmarillo(),
                              size: 35,
                            ),
                            Text('Cancelar', style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
