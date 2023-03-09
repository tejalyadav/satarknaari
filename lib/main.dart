//import 'dart:io';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:satark_naari/add_contact.dart';
import 'package:satark_naari/main.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
//import 'package:camera/camera.dart';
//import 'package:video_player/video_player.dart';
import 'LocaleString.dart';
//import 'package:image_picker/image_picker.dart';

import 'package:satark_naari/camera_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:permission_handler/permission_handler.dart';

import 'camera_page.dart' as first;
import 'add_contact.dart' as second;

//DocumentSnapshot snapshot ;



  void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    translations: LocalString(),
    locale: Locale('en','US'),
    initialRoute: '/',
    routes: {
      '/': (context) => FirstScreen(),
      '/HomeRoute': (context) => HomeRoute(),
      '/Addcontacts': (context) => second.AddPage(),
      '/CameraApp': (context) => first.CameraPage(),
    },
  ));
}

class FirstScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home:  Scaffold(
        body: SafeArea(
          child:Center(
            child: Column(
        children: [
          FlowerImageAsset(),
          Text("Satark Naari",style: TextStyle(fontFamily: 'Tangerine', color: Colors.black,fontSize: 80)),
          SizedBox(
            width: 300,
          child:ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                side: BorderSide(color: Colors.black),
                primary: Colors.orange,
                minimumSize: const Size.fromHeight(55), // NEW
              ),
            child:Text("Let's Start"),
            onPressed: (){
              Navigator.push(context, new MaterialPageRoute(
                builder: (context) =>
                new HomeRoute(),
              ));
            }
          ),
        ),
      ]
    ),
    ),
        ),
      ),
    );

  }
}

class HomeRoute extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'satark_naari',
      home:  MyHomePage(title:'Satark Naari'.tr ),
      theme: ThemeData(
        primarySwatch: Colors.orange,

      ),
    );

  }
}
class MyHomePage  extends StatelessWidget{
  MyHomePage( {Key ? key,required this.title} ): super(key: key);
  final CollectionReference _contacts = FirebaseFirestore.instance.collection('Contact');




  final String title;
  final List locale =[
    {'name':'English','locale':Locale('en','US')},
    {'name':'हिन्दी','locale':Locale('hi','IN')},
    {'name':'ગુજરાતી','locale':Locale('gu','IN')},
  ];

  updatelanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }
  builddialog(BuildContext context){
    showDialog(
      context: context,
      builder: (builder){
        return AlertDialog(
          title:Text('Choose'.tr),
          content: Container(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
                itemBuilder: (context,index){
                  return Padding(
                     padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: (){
                            updatelanguage(locale[index]['locale']);
                          },
                          child: Text(locale[index]['name']))
                  );
                },
                separatorBuilder: (context, index){
                  return Divider(
                    color: Colors.deepOrangeAccent,
                  );
                },
                itemCount: locale.length)
          )
        );
      }
    );
  }
 Future<void> getData() async{


 }
  @override
  Widget build(BuildContext context){
    //getData();
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontFamily: 'Tangerine', color: Colors.white)),
      ),
      body: Center(

        child: Column(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          WomenImageAsset(),

           SizedBox(
             width: 300,
          child:ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              side: BorderSide(color: Colors.black),
              primary: Colors.orange,
              minimumSize: const Size.fromHeight(55), // NEW
            ),


        onPressed: (){
          int number=8104939905;
          getData();



          launch('tel:${number}');
          },label: Text('Call'.tr),
            icon: Icon(Icons.call)
    ),),
        SizedBox(
          width: 300,
          child:ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              side: BorderSide(color: Colors.black),
              primary: Colors.orange,
              minimumSize: const Size.fromHeight(55), // NEW

            ),
            onPressed: ()async{
               Position _currentPosition;
              _currentPosition= await _determinePosition();

              var url1="https://maps.google.com/?q=${_currentPosition.latitude},${_currentPosition.longitude}";
              launch('sms:+91 8104939905?body=I am not safe.Please help me. My Location= $url1');
            },label: Text('SMS'.tr),
              icon: Icon(Icons.message),
          ),),
        SizedBox(
          width: 300,
          child:ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              side: BorderSide(color: Colors.black),
              primary: Colors.orange,
              minimumSize: const Size.fromHeight(55), // NEW
            ),
            onPressed: (){
              //_askCameraPermission();
              Navigator.push(context, new MaterialPageRoute(
                builder: (context) =>
                    new CameraPage(),
              ));
  },label: Text('Recording'.tr),
              icon: Icon(Icons.camera),
          ),),
          SizedBox(
            width: 300,
            child:ElevatedButton.icon(
              style: ElevatedButton.styleFrom(

                shape: StadiumBorder(),
                side: BorderSide(color: Colors.black),
                primary: Colors.orange,
                minimumSize: const Size.fromHeight(55), // NEW
              ),
              onPressed: (){
                //_askCameraPermission();
                Navigator.push(context,new MaterialPageRoute(
                  builder: (context) =>
                  new AddPage(),
                ));
              },label: Text('Add Contact'.tr),
                icon: Icon(Icons.add),
            ),),
          SizedBox(
          width: 300,

          child:ElevatedButton(


            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              side: BorderSide(color: Colors.black),
              primary: Colors.orange,
              minimumSize: const Size.fromHeight(55), // NEW

            ),




            onPressed: (){
             builddialog(context);
            },child: Text('Language'.tr),
          ),),
          ] ,


    ),
      ),
      backgroundColor: Colors.white,
    );


  }


}


class WomenImageAsset extends StatelessWidget{
  Widget build(BuildContext context) {

    AssetImage assetImage = AssetImage('assets/images/women.jpg');
    Image image = Image(image: assetImage,height: 350,
    width: 800,
    color: Colors.white,
    colorBlendMode: BlendMode.darken,
    fit: BoxFit.fitWidth,);
    return Container(child: image);

  }
}

class FlowerImageAsset extends StatelessWidget{
  Widget build(BuildContext context) {

    AssetImage assetImage = AssetImage('assets/images/flower.jpg');
    Image image = Image(image: assetImage,height: 650,
      width: 500,
      color: Colors.white,
      colorBlendMode: BlendMode.darken,
      fit: BoxFit.fitWidth,);
    return Container(child: image);

  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

//class Addcontacts extends StatefulWidget{
 // _AddcontactsState createState() => _AddcontactsState();
//}

//class _AddcontactsState extends State<Addcontacts>{
  //final db= Firestore.instance;

  //oid Addcontacts(){

  //}




