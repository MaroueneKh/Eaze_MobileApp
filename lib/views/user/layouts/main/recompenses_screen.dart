import 'dart:ui';

import 'package:eaze/controllers/user/liste_controller.dart';
import 'package:eaze/controllers/user/produit_controller.dart';
import 'package:eaze/controllers/user/user_controller.dart';
import 'package:eaze/models/user/user_model.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main_tab.dart';


class RecompenseScreen extends StatefulWidget {
  RecompenseScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _RecompenseScreenState createState() => _RecompenseScreenState();
}

class _RecompenseScreenState extends State<RecompenseScreen> {
  Color mainColor = Color.fromRGBO(236, 236, 236, 1.0);
  Color secondColor = Color.fromRGBO(19, 117, 71, 1.0);
  Color listColor1 = Color.fromRGBO(27, 32, 41, 1.0);
  Color listColor2 = Color.fromRGBO(238, 191, 54, 1.0);
  bool inReorder = false;
  ScrollController scrollController;
  TextEditingController passwordController = TextEditingController();
  ListeController ctrl = new ListeController() ;
  ProduitController ctrl2 = new ProduitController() ;
  bool show = false;
  RandomColor _randomColor = RandomColor();
  Color _color;
  bool showText = true;
  String idListe ;
  @override
  void initState() {
    _color = _randomColor.randomColor(
        colorHue: ColorHue.multiple(colorHues: [ColorHue.green,ColorHue.yellow])
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Color mainColor = Color.fromRGBO(	211, 232, 213,1.0);
    Color secondColor = Color.fromRGBO(19, 117, 71,1.0);
    return ChangeNotifierProvider<UserModel>(
      create: (context) => UserModel.instance(),
      child: Consumer<UserModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
              resizeToAvoidBottomPadding: true,
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body:SingleChildScrollView(
                child:  Column(
                  children: [
                    Divider(
                      color: Colors.white,
                      height: Get.height/4.5,
                    ),
                    Text("Paiement",style: TextStyle(fontSize:24.0,color: secondColor,fontWeight: FontWeight.bold)),
                    MyCustomForm(),
                  ],
                ),
              )
          );//TODO Add layout or component here
        },
      ),
    );
  }



}
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}
// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserController viewController = Get.put(UserController());
  AnimationController controller;
  bool _mail = false ;
  bool pwd = false ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Color mainColor =  Color.fromRGBO(213, 240, 227,1.0);
    Color secondColor = Color.fromRGBO(19,117,71,1.0);
    void _toggle(bool visbility) {
      setState(() {
        _mail = !visbility;
      });
      if (_mail == false)
      {
        Get.off(MainTab(), transition: Transition.fade  ) ;
      }
    }
    return
      Form(
          key: _formKey,
          child: Container(
            height: Get.height*(3/4),
            width: Get.width*(0.90),
            child:Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
              ),
              borderOnForeground: false,
              color: Colors.white,
              child: Column(
                  children: <Widget>[
                    Divider(
                      height: Get.height/11,
                    ),
                    ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 300,
                          maxWidth: 300,
                        ),
                        child :Row(
                          children: [
                            Text('Total',style:TextStyle(fontSize:20.0,color: secondColor,fontWeight: FontWeight.bold,)),Padding(
                              padding:  EdgeInsets.only(left: Get.width*0.3),
                              child: Text('85 dinars',style: TextStyle(fontSize:20.0,color: Colors.black,fontWeight: FontWeight.bold,),),
                            )
                          ],
                        )                    ),
                    Center(

                    ),
                    Divider(
                      color: Colors.white,
                      height: Get.height/20,
                    ),
                    ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 300,
                          maxWidth: 300,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          cursorColor:  secondColor,
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: mainColor,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: mainColor,
                              ),
                              borderRadius: BorderRadius.circular(33.0),
                            ),
                            prefixIcon: Icon(Icons.lock,
                                color: secondColor),
                            alignLabelWithHint: true,
                            hintText: "numéro de carte",
                            hintStyle: TextStyle(
                              color: secondColor,
                            ),
                            //    labelText: 'Mail',
                            //  labelStyle: TextStyle(color: secondColor
                            //  ,fontSize: 20),
                          ),
                          validator: (value) {
                            if (value.isEmpty||value.length<4) {
                              return 'Veuillez insérer votre mot de passe';
                            }
                            return null;
                          },
                        )
                    ),
                    Visibility(
                      visible: _mail,
                      child:  Text('Veuillez verifier vos informations',style: TextStyle(
                        color: secondColor,
                      ),
                      ) ,
                    ),
                    Divider(
                      color: Colors.white,
                      height: Get.height/12,
                    ),
                    Divider(
                      color: Colors.white,
                      height: Get.height/12,
                    ),
                    RawMaterialButton(
                      fillColor: secondColor,
                      splashColor: mainColor,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "Confirmer",
                              maxLines: 1,
                              style: TextStyle(color: Colors.white,fontSize: 20),
                            ),
                          ],
                        ),
                      ),

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)
                      ),
                      onPressed: () async {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          await viewController.Login(mailController.text, passwordController.text).then((value) =>
                              _toggle(value)
                          );
                        }
                      },
                    ),
                    Divider(
                      color: Colors.white,
                      height: Get.height/14,
                    ),
                    // Add TextFormFields and RaisedButton here.
                  ]
              ),
            ) ,

          )
      );
  }
}
