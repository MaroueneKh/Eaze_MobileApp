import 'package:eaze/models/user/produit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
// import model
import 'package:eaze/models/user/user_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
class ProduitController extends GetxController{
  ProduitController();
  String url='http://de21e22bd171.ngrok.io' ;
  int a = 0;
  void getter(BuildContext context) {
    UserModel viewModel = Provider.of<UserModel>(context, listen: false);
    //TODO Add code here for getter
    viewModel.getter();
  }
  void setter(BuildContext context) {
    UserModel viewModel = Provider.of<UserModel>(context, listen: false);
    //TODO Add code here for setter
    viewModel.setter();
  }

  void remove(BuildContext context) {
    UserModel viewModel = Provider.of<UserModel>(context, listen: false);
    //TODO Add code here for remove
    viewModel.remove();
  }
  Future<List<Produit>> ProduitPersonnalise () async {
    print('***********************************************************');

    final prefs = await SharedPreferences.getInstance();
    String mail =  prefs.get('email') ;
    print("mail from shared preferences");
    print(mail);
   final response =  await http.post(url+'/recommandations',body:{'email':mail}) ;
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(jsonResponse.length);
      return jsonResponse.map((job) => new Produit.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }

  }
  Future<List<Produit>> AjouterProduitListe (String nom,String id) async {
    print('kiko');
    print(nom);
    print(id);

      //Get.snackbar('Produit Ajouté ', '',colorText: Colors.white,icon: Icon(Icons.shopping_cart),duration: Duration(seconds: 3),backgroundColor: Colors.green) ;

    final response =  await http.post(url+'/ajouterProduitListe',body:{'nom':nom,'id_liste':id}) ;
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(jsonResponse.length);
      return jsonResponse.map((job) => new Produit.fromJson(job)).toList();

    } else {
      throw Exception('Failed to load jobs from API');
    }

  }
  Future<List<Produit>>ProduitbyListe (String id) async {
    final response =  await http.post(url+'/listeByProduit',body:{'idliste':id}) ;
    print('ahayaaa l a');
    print(a++) ;
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(jsonResponse.length);
      return jsonResponse.map((job) => new Produit.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
  Future<List<Produit>> ProduitSimilaire () async {

    final prefs = await SharedPreferences.getInstance();
    String category =  prefs.get('category') ;
    print('catégorie') ;
    print(category);
    final response =  await http.post(url+'/produitsByCategorie',body:{'category':category}) ;
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(jsonResponse.length);
      return jsonResponse.map((job) => new Produit.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }

  }
  Future<List<Produit>> ProduitsConsulter () async {
    final prefs = await SharedPreferences.getInstance();
    String mail =  prefs.get('email') ;

    final response =  await http.post(url+'/produitsConsultes',body:{'user':mail}) ;
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(jsonResponse.length);
      return jsonResponse.map((job) => new Produit.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }

  }

  Future<bool> Inscription  (String nom,String prenom,String civilite,String date,String gouvernorat,String chaine,String magasin,int codePostal,
      int tel,String email,String profession,String password,String cvilite) async {
    print('Login info');
    var response = await http.post(url+'/Inscription',body:{'nom':nom,'prenom':prenom,'date_naissance':date,'gouvernorat':gouvernorat,'chaine':chaine,'magasin':magasin
      ,'profession':profession,'codepostal':codePostal,'civilite':cvilite,'email':email,'tel':tel,'password':password});
    print(response.statusCode);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body.toString()}');
//check if mail is correct
    //if mail is correct check if password is correct


    //JSON DECODER
    //   });
    // LOGIN GET REQUEST IS HERE
  }
}