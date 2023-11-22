import 'package:flutter/material.dart';
import 'package:poryecto_final/services/firebase_service.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agregue un evento',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Form(
          key: formKey,
          child: Container(
            child: Column(
              children: [
                //nombre de evento
                TextFormField(
                  controller: ctrlNombre,
                  decoration: InputDecoration(
                    label: Text('Nombre de evento'),
                  ),
                ),
                //descripcion
                TextFormField(
                  controller: ctrlDescripcion,
                  decoration: InputDecoration(
                    label: Text('Describa el evento'),
                  ),
                ),
                //lugar
                TextFormField(
                  controller: ctrlLugar,
                  decoration:
                      InputDecoration(label: Text('Lugar a desarrolar evento')),
                ),
                Spacer(),
                TextButton(
                    onPressed: () {
                      FirebaseService()
                          .eventoAgregar(ctrlNombre.text, ctrlDescripcion.text,
                              ctrlLugar.text)
                          .then((value) => Navigator.pop(context));
                    },
                    child: Text('agregar')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'))
              ],
            ),
          )),
    );
  }
}
