import 'dart:async';

import 'package:eaze/controllers/user/produit_controller.dart';
import 'package:eaze/controllers/user/user_controller.dart';
import 'package:eaze/models/user/produit.dart';
import 'package:eaze/views/user/components/scan_barcode.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';
class Shopping extends StatefulWidget {
  Shopping({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _ShoppingState createState() => _ShoppingState();
}
class _ShoppingState extends State<Shopping> {
  Color mainColor = Color.fromRGBO(236, 236, 236, 1.0);
  Color secondColor = Color.fromRGBO(19, 117, 71, 1.0);
  List<Produit> a = List<Produit>() ;
  int _counter = 0;
  String _scanBarcode = 'Unknown';
  String _url = 'https://cf7d16d8e518.ngrok.io';
  ProduitController ctrl = new ProduitController() ;

  String _currentAddress;
 UserController ctrl2 = new UserController() ;


  @override
   initState() {

    super.initState();
  }
  void _onAddToCache(WebViewController controller, BuildContext context) async {
    await controller.evaluateJavascript(
        'caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";');
    Scaffold.of(context).showSnackBar(const SnackBar(
      content: Text('Added a test entry to cache.'),
    ));
  }


  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      //barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //  "#ff6666", "Cancel", true, ScanMode.QR);
      //print(barcodeScanRes);
      //if (barcodeScanRes == '0')
        //{
          //await ctrl2.verifierGel().then((value) => value? Get.snackbar('Attention ', 'Veuillez désinfecter vos mains !',colorText: Colors.white,icon: Icon(Icons.shopping_cart),duration: Duration(seconds: 5),backgroundColor: Colors.red):Get.off(Scan(),transition:Transition.fadeIn));
      //  }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
  Widget build(BuildContext context) {
    return (Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: 200,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Search",
                        icon: Icon(Icons.search),
                        border: InputBorder.none),
                  ),
                ),
              ],
            ),
            height: 35.00,
            width: 300,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 3.00),
                  color: Color(0xff000000).withOpacity(0.16),
                  blurRadius: 6,
                ),
              ],
              borderRadius: BorderRadius.circular(20.00),
            ),
          ),
          centerTitle: true,
        ),
      ),
      backgroundColor: mainColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(0.0,Get.height*0.1,0.0,0.0),
        child: Center(
          child: Column(
            children: [
              Text('Veuillez scanner le Qr Code sur le chariot ',style: TextStyle(color: secondColor,fontSize: 17),),
              RawMaterialButton(
                fillColor: secondColor,
                splashColor: mainColor,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Scanner ",
                        maxLines: 1,
                        style: TextStyle(color: Colors.white,fontSize: 15),
                      ),
                    ],
                  ),
                ),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)
                ),
                onPressed: () async {
                  scanQR();
                },
              ),

            ],
          ),
        ),
      ),
    ));

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
  }
}

