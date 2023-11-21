import 'package:flutter/material.dart';
import 'package:poryecto_final/constants/colores_const.dart';
import 'package:poryecto_final/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListadoAdmin extends StatelessWidget {
  const ListadoAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 50,
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colores.getGris(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text('Apartado de Administrador',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Text('estoy en admin'),
          Expanded(
            child: StreamBuilder(
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
          ),
        ],
      ),
    );
  }
}
