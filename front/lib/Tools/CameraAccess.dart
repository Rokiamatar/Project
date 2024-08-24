import 'package:flutter/cupertino.dart';

import '../Screens/Camera.dart';
import '../Screens/showcamera.dart';
import 'cachehelper.dart';

class CameraPass extends StatefulWidget {
  CameraPass({Key? key}) : super(key: key);

  @override
  State<CameraPass> createState() => _CameraPassState();
}
class _CameraPassState extends State<CameraPass> {
  @override
  Widget build(BuildContext context) {
    String ?token = CacheHelper.getData(key: 'token') ;
    if( token != null){
      print(token);
      return ShowCamera();
    }else
      return CameraOpen();
  }
}

