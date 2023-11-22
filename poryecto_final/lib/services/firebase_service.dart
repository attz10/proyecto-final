import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  //atributos
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //listar eventos
  Stream<QuerySnapshot> eventos() {
    return FirebaseFirestore.instance.collection('eventos').snapshots();
  }

  //agregar evento
  Future<void> eventoAgregar(
      String nombre, String descripcion, String lugar) async {
    return FirebaseFirestore.instance.collection('eventos').doc().set({
      'nombre': nombre,
      'descripcion': descripcion,
      'lugar': lugar,
      'likes': 0,
      'megusta': false,
    });
  }

  //editar likes
  Future<void> editarLikes(String id, int likes) async {
    return FirebaseFirestore.instance.collection('eventos').doc(id).update({
      'likes': likes + 1,
      'megusta': true,
    });
  }

  //borrar evento
  Future<void> borrarEvento(String id) async {
    return FirebaseFirestore.instance.collection('eventos').doc(id).delete();
  }

  //login
  Future<bool> iniciarSesion() async {
    int loged = 0;
    //intento iniciar sesión
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      //hay user?
      if (googleUser == null) {
        //NO hay user logeado
        loged = 0;
      }
      //hay user logeado
      else {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credencial = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credencial);
        loged = 1;
      }
    }
    //error
    catch (e) {
      print(e);
    }
    //retorna TRUE si loged == 1
    return loged == 1;
  }

  //logout
  Future<void> cerrarSesion() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  //saber si el user está logeado
  bool userEstaLogeado() {
    //hay user?
    if (_auth.currentUser != null) {
      //si, hay un user logeado
      return true;
    }
    //no hay user logeado
    return false;
  }

  //retornar objeto user tipo stream
  Stream<User?> get usuario {
    return _auth.authStateChanges();
  }
}
