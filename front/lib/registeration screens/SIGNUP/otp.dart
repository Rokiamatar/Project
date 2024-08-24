
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';

import '../SIGNIN/loginpage.dart';
import '../authentication.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  Future<void> _handleSignIn() async {
    bool _isSigningIn = false;
    setState(() {
      _isSigningIn = true;

    });
    try{
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser==null){
        setState(() {
          _isSigningIn = false;
        });

        return ;
      }
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.of(context).pushNamedAndRemoveUntil("MyMapss",(route) => false);
    }

    catch (error){
      setState(() {
        _isSigningIn=false ;
      });
    }
  }
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;
  double bottom = 0;

  String otpPin = " ";
  String countryDial = "+1";
  String verID = " ";

  int screenState = 0;




  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    bottom = MediaQuery.of(context).viewInsets.bottom;

    return WillPopScope(
      onWillPop: () {
        setState(() {
          screenState = 0;
        });
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor:  HexColor('#00008b'),
        body: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Stack(

            children: [

              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.all(.8),
                  child: Column(

                    children: [

                      Padding(
                        padding: EdgeInsets.only(top:screenHeight / 8 , right: screenWidth / 8 ,left: screenWidth / 8),
                        child: Center(
                          child: Text(
                            'P a r k o',
                            style: GoogleFonts.lobster(

                              textStyle:TextStyle(color:  Colors.white,
                                fontSize: 65,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text('Find your parking place easily and faster',
                      style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: circle(7),
              ),
              Transform.translate(
                offset: const Offset(30, -30),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: circle(4.5),
                ),
              ),
              Center(
                child: circle(4),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  height: bottom > 0 ? screenHeight : screenHeight / 2,
                  width: screenWidth,
                  color: Colors.white,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth / 12,
                      right: screenWidth / 12,
                      top: bottom > 0 ? screenHeight / 12 : 0,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center (
                                    child: Text(
                                      'Sign Up',
                                        style: GoogleFonts.asap(

                                          textStyle:TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold,
                                           //fontStyle: FontStyle.italic,

                                        color: HexColor('#00008b'),
                                      ),
                                    ),
                                  ),
                                  ),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  TextFormField(
                                    cursorColor: HexColor('#800000'),
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (String value) {
                                      print(value);
                                    },
                                    onChanged: (String value) {
                                      print(value);
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Parko@gmail.com',
                                      labelText: 'Email Address',
                                      prefixIcon: Icon(
                                        Icons.email,
                                      ),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    controller: passwordController,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    onFieldSubmitted: (String value) {
                                      print(value);
                                    },
                                    onChanged: (String value) {
                                      print(value);
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      hintText: 'Create Password',
                                      prefixIcon: Icon(
                                        Icons.lock,
                                      ),
                                      suffixIcon: Icon(
                                          Icons.remove_red_eye ,color:  Colors.grey),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(child: MaterialButton(

                                    color:  HexColor('#00008b'),
                                    shape: RoundedRectangleBorder
                                      (
                                        borderRadius: BorderRadius.circular(40)
                                    ),
                                    minWidth: double.infinity,
                                    height:50,
                                    onPressed: ()
                                    {
                                      AuthController.instance.register(
                                          emailController.text.trim(), passwordController.text.trim());
                                    },
                                    child: Text("Sign Up",
                                      style: GoogleFonts.asap(

                                        textStyle:TextStyle(
                                         // fontSize: 30.0,
                                          //fontWeight: FontWeight.bold,
                                          fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.white,
                                     // fontStyle: FontStyle.italic,
                                    ),),),
                                  ),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have an account?',
                                    style: GoogleFonts.asap(),
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                                              builder: (context)=>Login()));

                                        },
                                        child: Text('Login',
                                          style: GoogleFonts.asap(
                                            fontWeight: FontWeight.bold,
                                            textStyle:TextStyle(
                                            color: HexColor('#00008b'),
                                            //fontStyle: FontStyle.italic,
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(200),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          MaterialButton(

                                            onPressed:()async{
                                              await _handleSignIn();

                                            },

                                            child: Text("Sign Up with Google",
                                              style: GoogleFonts.asap(

                                                textStyle:TextStyle(
                                                  //fontSize: 30.0,
                                                 // fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: HexColor('#8b0000'),
                                              //fontStyle: FontStyle.italic,
                                            ),),),
                                          ),
                                          Container(

                                            height: 40.0,
                                            width: 40.0,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(image:AssetImage('assets/google.png'),
                                                  fit: BoxFit.cover),
                                              shape: BoxShape.circle,
                                           // color: Colors.black
                                              ),
                                          ),


                                        ],
                                      ),





                                    ),
                                  ),


                                ], ),
                            ),




                          ]
                      ),
                    ),
                    ),

                  ),
                ),

            ],
          ),



        ),

      ),
    );
  }


  Widget circle(double size) {
    return Container(
      height: screenHeight / size,
      width: screenHeight / size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }
}