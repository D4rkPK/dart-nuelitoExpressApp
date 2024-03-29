import 'package:fluttertoast/fluttertoast.dart';
import 'package:nuelitoexpress/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuelitoexpress/Login_SignUp/login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String sEmail, sPassword, sNombre, sTelefono;
  GlobalKey<FormState> formkey = GlobalKey();
  final firestoreInstance = Firestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.orange[800],
                  Colors.orange[600],
                  Colors.orange[400]
                ]
            )
        ),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 35,),
              Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FadeAnimation(1, Image.asset('assets/logoNuelitoExpress.png', width: 180.0,))
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(1.3, Text("Registrate", style: TextStyle(color: Colors.white, fontSize: 40),)),
                    SizedBox(height: 10,),
                    FadeAnimation(1.6, Text("Bienvenido", style: TextStyle(color: Colors.white, fontSize: 18),)),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(38), topRight: Radius.circular(38))
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20,),
                          FadeAnimation(1.4, Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(
                                    color: Color.fromRGBO(225, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10)
                                )]
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Correo Electrónico',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                        // hintText: 'EMAIL',
                                        // hintStyle: ,
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.orange))),
                                    validator: (value) => value.isEmpty ? '*Campo Obligatorio' : null,
                                    onSaved: (value)=> sEmail = value,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                  ),
                                  child:  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Contraseña',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.orange))),
                                    obscureText: true,
                                    validator: (value) => value.isEmpty ? '*Campo Obligatorio' : null,
                                    onSaved: (value)=> sPassword = value,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                  ),
                                  child:  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: '¿Cómo te llamas?',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                        // hintText: 'EMAIL',
                                        // hintStyle: ,
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.orange))),
                                    validator: (value) => value.isEmpty ? '*Campo Obligatorio' : null,
                                    onSaved: (value)=> sNombre = value,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                  ),
                                  child:  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Número de teléfono',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                        // hintText: 'EMAIL',
                                        // hintStyle: ,
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.orange))),
                                    validator: (value) => value.isEmpty ? '*Campo Obligatorio' : null,
                                    onSaved: (value)=> sTelefono = value,
                                  ),
                                ),
                              ],
                            ),
                          )),

                          SizedBox(height: 50.0),
                          FadeAnimation(1.6, Container(
                              height: 40.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(50.0),
                                shadowColor: Colors.orangeAccent,
                                color: Colors.orange[900],
                                elevation: 7.0,
                                  child: InkWell(
                                    onTap: () {
                                      signUp();
                                  },
                                  child: Center(
                                    child: Text(
                                      'REGISTRARSE',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                ),
                              ))),

                          SizedBox(height: 20.0),
                          FadeAnimation(1.9, Container(
                            height: 40.0,
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1.0),
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Center(
                                  child: Text('Regresar',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat')),
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void signUp(){
    if(formkey.currentState.validate()){
      formkey.currentState.save();
      try{
        firebaseAuth.createUserWithEmailAndPassword(
            email: sEmail, password: sPassword)
            .then((result) {
          firestoreInstance.collection('Usuarios')
              .document(result.user.uid)
              .setData(
              {'Email': sEmail,
                'Nombre': sNombre,
                'Telefono': sTelefono,
                'uid': result.user.uid
              });
          result.user.sendEmailVerification();
        });
        Fluttertoast.showToast(
            msg: "Hemos enviado un correo de confirmación a tu cuenta.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green[700],
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }catch(e){
        print(e.message);
      }
    }
  }
}





