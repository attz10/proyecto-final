import 'package:flutter/material.dart';
import 'package:poryecto_final/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Listado extends StatefulWidget {
  const Listado({super.key});

  @override
  State<Listado> createState() => _ListadoState();
}

class _ListadoState extends State<Listado> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseService().eventos(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var evento = snapshot.data!.docs[index];
                return Center(
                  child: Text(evento['nombre']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
