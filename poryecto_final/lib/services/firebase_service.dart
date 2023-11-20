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

  //login 
  Future<bool> iniciarSesion() async {
    int loged = 0;
    //intento iniciar sesión
    try{
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn(); 
      //hay user?
      if(googleUser == null) {
        //NO hay user logeado
        loged = 0;
      }
      //hay user logeado
      else{
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final credencial = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credencial);
        loged = 1;
      }
    }
    //error
    catch(e){
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
    int loged = 0;
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      //hay un user logeado?
      if (user == null) {
        //no hay
        loged = 0;
      }
      //si hay
      else {
        loged = 1;
      }
    });
    //retorna TRUE si loged == 1
    return loged == 1;
  }
}


