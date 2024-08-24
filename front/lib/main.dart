import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:parko2/registeration%20screens/SIGNIN/loginpage.dart';
import 'package:parko2/registeration%20screens/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'Map/map.dart';
import 'Screens/onboardind.dart';
import 'Tools/cachehelper.dart';
import 'package:socket_io_client/socket_io_client.dart';

Future <void>main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp().then((value)=>Get.put(AuthController())) ;

  final prefs = await SharedPreferences.getInstance();
  final showHome =prefs.getBool('showHome')??false;

  Widget widget;
  await CacheHelper.init();
  String? token = CacheHelper.getData(key: 'token');
  if (token != null){
    widget=MyMapss();
  }else {
    widget=Login();
  }

  runApp(
      MyApp(
        startWidget: widget,
          showHome :showHome,
      ));
}
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Container(
            child:Icon(Icons.location_on_outlined,
                size: 50,
                color: Colors.white),


          ),
           Text(
            'P a r k o',
        style: GoogleFonts.lobster(
          textStyle:TextStyle(color:Colors.white,
            fontSize: 65,),
            ),
           ),
          SizedBox(height: 20,),
          Text(
            'Navigarion Parking System',
            style: GoogleFonts.lobster(

              textStyle:TextStyle(color:Colors.white),
                fontSize: 20,),
            ),

        ],
      ),
      backgroundColor: HexColor('#00008b'),
      nextScreen:  MyMapss() ,
    splashIconSize: 350,
      duration: 10000,
      splashTransition: SplashTransition.slideTransition,

     // pageTransitionType: PageTransitionsType.,
    );
  }
}

class MyApp extends StatelessWidget {
final Widget? startWidget;
final bool showHome ;

  const MyApp({
  Key ? key,this.startWidget, required this.showHome }):super(key :key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // var initScreen;
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,

          home: showHome ?   startWidget: Onboarding() ,
          routes: {
          "MyMapss" : (context)=> const MyMapss(),
          },
    );
  }
}

// import 'dart:convert';

// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:http/http.dart' as http;



// main(){


// Map<String,dynamic> options={'transports':['websocket'],'autoConnect':false};

//  var socket=IO.io("http://127.0.0.1:3000/",options);

//  socket.connect();

// socket.onConnect((data) => print("client connected !"));





// predict(){
//   socket.on("predict", (data) => print(data));
// }


// disconnect(){
//   socket.onDisconnect((data) => print("client disconnected !"));
// }


// getPrediction()async
 
// {
//    Map<String,dynamic>? jsondata;
//   http.Response response =await http.post(  Uri.parse('http://127.0.0.1:3000/parking'));


// if( response.statusCode==200){
//  jsondata=jsonDecode(response.body);
// }else{
//  jsondata={};
// }

//  return jsondata;
// }




// }