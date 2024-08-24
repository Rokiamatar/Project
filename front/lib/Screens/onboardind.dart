import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../registeration screens/SIGNUP/otp.dart';

class Onboarding extends StatefulWidget {

  @override
  State<Onboarding> createState() => OnboardingState();
}

class OnboardingState extends State<Onboarding> {
final controller = PageController();
bool isLastPage =false;
@override
void dispose (){
  controller.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80) ,
        child: PageView(
          controller: controller,
          onPageChanged: (index){
            setState(()=>isLastPage = index ==2);
          },
          children: [
            Container(
             // height: 20,
              color: Colors.white,
              child: const Center(child:
              Image(image: AssetImage('assets/2.jpg'),
                  ),

              ),

            ),

            Container(
             //height: 80,
              color: Colors.white,
             // color: HexColor('#00bfff'),
              child: const Center(child:
              Image(image: AssetImage('assets/3.jpg'),
              ),
            ),
            ),
            Container(
              color: Colors.white,
              child: const Center(child:
              Image(image: AssetImage('assets/1.jpg'),
              ),),
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage ? TextButton(
        style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          foregroundColor: Colors.white,
          backgroundColor:  HexColor('#00008b'),
          minimumSize: Size.fromHeight(66),),
          onPressed: ()async{
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('showHome', true);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RegisterScreen()));
          },
          child:Text ('Get Started',style:TextStyle(fontSize:24))):
      Container(
        padding: const EdgeInsets.symmetric(horizontal:0),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: ()
              =>controller.jumpToPage(2),
             child: Text ('Skip')),
            Center(
              child: SmoothPageIndicator(
                controller:controller,
                count :3,
                effect: WormEffect(
                  spacing: 16,
                  dotColor: Colors.grey,
                  activeDotColor:  HexColor('#00008b')),
                ),
              ),
            TextButton(onPressed: ()=>controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut), child: Text ('Next')),
          ],
        ),
      ),
    );
  }
}
