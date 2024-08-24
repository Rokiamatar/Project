import 'package:flutter/material.dart';
import 'package:parko2/Screens/showcamera.dart';
import 'package:parko2/Tools/cachehelper.dart';

class CameraOpen extends StatefulWidget {
  const CameraOpen({Key? key}) : super(key: key);
  @override
  State<CameraOpen> createState() => _CameraOpenState();
}
class _CameraOpenState extends State<CameraOpen> {
  var _passcodeController = TextEditingController();
  String Correctpass ='27400';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("CAMERA"),
        centerTitle: true,
      ),
      body: Center(
        child: Column( mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter The Passcode please !",
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(

                  controller:  _passcodeController ,
                  decoration: InputDecoration(
                    labelText: 'Enter passcode ',
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            MaterialButton(
              child: Text('Submit',style: TextStyle(color:Colors.white),),
              color: Colors.black,
              onPressed:(){
               String passcode =_passcodeController.text;
             if (passcode ==Correctpass){
               CacheHelper.saveData(
                 key: 'token',
                 value: passcode,
               ).then((value) {
                 print(passcode);
                 Navigator.of(context).pushReplacement(
                     MaterialPageRoute(builder: (context) => ShowCamera()));
               });
             }
             else {
               print(passcode);
             showSnackBar(context);

                 }
               }
             ),
          ],
        ),
      ),
    );
  }
}
showSnackBar(BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('This Passcode is incorrect', style: TextStyle(color: Colors.white),),
    backgroundColor: Colors.grey,
    //position : SnackBarPosition.TOP,
  ));
}