import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../registeration screens/SIGNUP/otp.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);
  @override
  State<FirstPage> createState() => _FirstPageState();
}
class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
    backgroundColor: Colors.white,
        body: Container(

        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Padding(
            padding: const EdgeInsets.only(top:20),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      // margin: EdgeInsets.only(left: ),

                      height: 40.0,
                      width: 45.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(image:AssetImage('assets/download (1).jpg'),
                            fit: BoxFit.cover),
                        shape: BoxShape.rectangle,
                        // color: Colors.black
                      ),
                    ),
                    SizedBox(width: 8,),
                    Container(

                      height: 35.0,
                      width: 55.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(image:AssetImage('assets/download.jpg'),
                            fit: BoxFit.cover),
                        shape: BoxShape.rectangle,
                        // color: Colors.black
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Text(
                "Hello There!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: HexColor('#00008b'),
                ),
              ),
              SizedBox(height: 30,),
              Text(" Let\'s use Parko to find your parking place easily and faster",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15
                ),
              ),

           SizedBox(height: 60,),
             Container(
               child:Icon(Icons.location_on_outlined,
                 size: 50,
                 color: HexColor('#00008b')),


             ),

                 Container(

                    //margin: EdgeInsets.only(top: 30,),
                    child:
                    Text(
                      'P a r k o',
                      style: GoogleFonts.lobster(

                        textStyle:TextStyle(color:HexColor('#00008b'),
                          fontSize: 65,),
                      ),),
                  ),
              SizedBox(height: 80,),
              Container(
                //margin: EdgeInsets.only(left: 100),
                child: MaterialButton(

                  minWidth: double.minPositive,
                  height:60,
                  onPressed: (){

                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                     builder: (context)=> RegisterScreen()), (route) => false);
                  },
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(   
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(" Let\'s Start",style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                 ),
                ),
              ),
            ],
           ),
          ),
         ]
        ),
       ),
      );
  }
}

