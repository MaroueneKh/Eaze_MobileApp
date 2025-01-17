import 'dart:async';

import 'package:eaze/controllers/user/produit_controller.dart';
import 'package:eaze/models/user/produit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:eaze/views/user/components/details_produits.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MainInterface extends StatefulWidget {
  MainInterface({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _MainInterfaceState createState() => _MainInterfaceState();
}
class _MainInterfaceState extends State<MainInterface> {
  Color mainColor = Color.fromRGBO(236, 236, 236, 1.0);
  Color secondColor = Color.fromRGBO(19, 117, 71, 1.0);
  List<Produit> a = List<Produit>() ;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  @override
  PageController _controller = PageController(
    initialPage: 0,
  );
  ProduitController ctrl = new ProduitController() ;
  int _currentPage = 0;
  //Retourner les produits personnalises pour ce client



  Future _showNotificationWithSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'id', 'channel', 'description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Post',
      'How to Show Notification in Flutter',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }
  Future<void> scheduleNotification() async {
    var scheduledNotificationDateTime =
    DateTime.now().add(Duration(seconds: 5));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'id',
      'channel',
      'description',
      icon: '@mipmap/ic_launcher',
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  @override
  Future<void> initState() {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings);

    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 1000),
        curve: Curves.ease

      );
    });



  }
  Widget build(BuildContext context) {
    return (Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Row(
              children: [
                Divider(
                  height: Get.height*0.08,
                ),
                Container(
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
                SizedBox(
                  width: Get.width*0.05,
                ),
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    //   _select(choices[1]);
                  },
                  color: secondColor,
                )
              ],
            ),
            centerTitle: true,
        ),
      ),
      backgroundColor: mainColor,
      body: Column(
        children: [
          Container(
            child: ListView(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                FlatButton(
                  color: mainColor,
                  splashColor: secondColor,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          children: [
                            Text(
                              'Tout',
                              maxLines: 1,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                            ),
                            Divider(
                              height: 5,
                              color: secondColor,
                              thickness: 10,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  onPressed: () async {},
                ),
                FlatButton(
                  color: mainColor,
                  splashColor: secondColor,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Vetements',
                          maxLines: 1,
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  onPressed: () async {
                    print('vetements');
                    scheduleNotification()  ;
                  },
                ),
                FlatButton(
                  color: mainColor,
                  splashColor: secondColor,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Boissons',
                          maxLines: 1,
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  onPressed: () async {},
                ),
                FlatButton(
                  color: mainColor,
                  splashColor: secondColor,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Viandes',
                          maxLines: 1,
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  onPressed: () async {},
                ),
                FlatButton(
                  color: mainColor,
                  splashColor: secondColor,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Electroménagers',
                          maxLines: 1,
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  onPressed: () async {},
                ),
                FlatButton(
                  color: mainColor,
                  splashColor: secondColor,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Pates',
                          maxLines: 1,
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  onPressed: () async {},
                )
              ],
            ),
            height: Get.height / 17,
          ),
          Container(
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              children: [
                ImageOne(),
                ImageTwo(),
                ImageThree(),
              ],
            ),
            height: Get.height * 0.20,
          ),
          Divider(
            height: Get.height * 0.02,
            color: mainColor,
          ),
          SmoothPageIndicator(
              controller: _controller, // PageController
              count: 3,
              effect: WormEffect(
                  dotColor: secondColor,
                  activeDotColor: secondColor,
                  paintStyle: PaintingStyle.stroke,
                  spacing: Get.width * 0.05,
                  radius: Get.width * 0.02), // your preferred effect
              onDotClicked: (index) {
                _controller.jumpToPage(index);
              }),
          Divider(
            color: mainColor,
            height: Get.height * 0.02,
          ),
          Container(
            child: Row(
              // This next line does the trick.
              children: <Widget>[
                RawMaterialButton(
                  autofocus: true,
                  fillColor: secondColor,
                  splashColor: mainColor,
                  child: Padding(
                    padding: EdgeInsets.all(9.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          'Personnalisé',
                          maxLines: 1,
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        SizedBox(
                          width: 15.0,
                        )
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  onPressed: () async {},
                ),
                RawMaterialButton(
                  fillColor: secondColor,
                  splashColor: mainColor,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          'Meilleures affaires',
                          maxLines: 1,
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        SizedBox(
                          width: 15.0,
                        )
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  onPressed: () async {},
                ),
                RawMaterialButton(
                  fillColor: secondColor,
                  splashColor: mainColor,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          'Bas prix',
                          maxLines: 2,
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        SizedBox(
                          width: 15.0,
                        )
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  onPressed: () async {},
                ),
              ],
            ),
            height: Get.height / 17,
          ),
          Produits()
        ],
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
class ImageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/banner.png',
        width: Get.width,
        height: Get.height * 0.15,
      ),
    );
  }
}

class ImageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/banner.png',
        width: Get.width,
        height: Get.height * 0.15,
      ),
    );
  }
}
class ImageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/banner.png',
        width: Get.width,
        height: Get.height * 0.15,
      ),
    );
  }
}
class Produits extends StatefulWidget {
  @override
  _ProduitsState createState() => _ProduitsState();
}
class _ProduitsState extends State<Produits> {
  Color mainColor = Color.fromRGBO(236, 236, 236, 1.0);
  Color secondColor = Color.fromRGBO(19, 117, 71, 1.0);
  @override
  void initState() {
    super.initState();
  }
  ProduitController ctrl = new ProduitController() ;
Future<void> toDetails(String nom ,String desc ,String price ,String image,String category,String barcode)
async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('nomP',nom) ;
  prefs.setString('desc',desc) ;
  prefs.setString('price',price) ;
  prefs.setString('image',image) ;
  prefs.setString('category',category) ;
  prefs.setString('barcode',barcode) ;


  Get.to(DetailsProduit(),transition: Transition.fade);
}
  @override
  Widget build(BuildContext context) => FutureBuilder(
    future:  ctrl.ProduitPersonnalise(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<Produit> data = snapshot.data;
        print('haw l produiiitttt');
        // Build the widget with data.
        return Container(
          child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(12.0),
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
              scrollDirection:Axis.vertical,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(data.length, (index) {
              return Center(
                child: Container(
                  height: Get.height*0.40,
                  width: Get.width*0.47,
                  child: Card(
                    margin: EdgeInsets.all(3),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: mainColor,
                        )),
                    shadowColor: mainColor,
                    borderOnForeground: true,
                    elevation: 10.0,
                    color: mainColor,
                    child: InkWell(
                      onTap: ()=>toDetails(data[index].nom,data[index].description,data[index].price,data[index].image,data[index].category,data[index].codeaBarres),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data[index].nom,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                          Image.asset(
                            'assets/images/'+data[index].image,
                            width: Get.width * 0.30,
                            height: Get.height * 0.13,
                          ),
                          Text(
                            data[index].description,
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width / 6.56,
                              ),
                              Text(
                                data[index].price+' DT',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: secondColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: Get.width /15,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          height: Get.height * 0.45,
        );
      } else {
        // We can show the loading view until the data comes back.
        return CircularProgressIndicator();
      }
    },
  );

}
class ProduitsTwo extends StatefulWidget {
  @override
  _ProduitsTwoState createState() => _ProduitsTwoState();
}
class _ProduitsTwoState extends State<ProduitsTwo> {
  Color mainColor = Color.fromRGBO(236, 236, 236, 1.0);
  Color secondColor = Color.fromRGBO(19, 117, 71, 1.0);
  List<Produit> a = List<Produit>() ;
  ProduitController ctrl = new ProduitController() ;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: ctrl.ProduitSimilaire(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        print(snapshot.data);
        // Build the widget with data.
        List<Produit> data = snapshot.data;
        print("fil deglaaa");
        print(data.length) ;
        return Container(
          child: ListView(
            padding: EdgeInsets.all(12.0),
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            scrollDirection:Axis.horizontal,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(data.length, (index) {
              return Center(
                child: Container(
                  height: Get.height*0.40,
                  width: Get.width*0.47,
                  child: Card(
                    margin: EdgeInsets.all(3),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: mainColor,
                        )),
                    shadowColor: mainColor,
                    borderOnForeground: true,
                    elevation: 10.0,
                    color: mainColor,
                    child: InkWell(
                      onTap: ()=> showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0)), //this right here
                              child:DetailsProduit(),
                            );
                          }),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data[index].nom,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                          Image.asset(
                            'assets/images/'+data[index].image,
                            width: Get.width * 0.30,
                            height: Get.height * 0.13,
                          ),
                          Text(
                            data[index].description.substring(0,3),
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: Get.width / 6.56,
                              ),
                              Text(
                                data[index].price+' DT',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: secondColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: Get.width /15,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          height: Get.height * 0.40,
        );
      } else {
        // We can show the loading view until the data comes back.
        return CircularProgressIndicator();
      }
    },
  );

}
