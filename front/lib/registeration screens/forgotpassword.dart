import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey= GlobalKey<FormState>();
  final emailController =TextEditingController();
  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Reset Password',),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Receive an email to\nreset your password',
              textAlign : TextAlign.start,
                style: TextStyle(fontSize: 24,),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: ' Your Valid Email'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                //validator: (email)=> email != null && !EmailValidator.validate(email)
                //? 'Enter a Valid email'
                //  : null,
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Colors.black,
                shape: RoundedRectangleBorder
                  (
                    borderRadius: BorderRadius.circular(40)
                ),
                minWidth: double.infinity,
                height:50,
               // style: ElevatedButton.styleFrom(
                //  minimumSize: Size.fromHeight(50),


                  onPressed: verifyEmail,
                  child:Text('Reset Password',
                  style: TextStyle(fontSize: 20,color : Colors.white,),
              ),
              ),
            ],
          ),
        ),
      ),
    );

  }
  Future verifyEmail () async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)=> Center(child: CircularProgressIndicator(),)
    );
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim ());
      Get.snackbar("About User", "User message",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
          titleText: const Text(
            "Reset Link sent to your Email",
            style: TextStyle(
                color:  Colors.white
            ),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(
                color: Colors.white
            ),
          )
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e){
      print(e);
      Navigator.of(context).pop();
    }
  }
}
