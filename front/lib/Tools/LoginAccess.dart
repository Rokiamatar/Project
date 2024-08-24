import 'package:flutter/cupertino.dart';
import 'package:parko2/Map/map.dart';
import 'package:parko2/registeration%20screens/SIGNIN/loginpage.dart';

import 'cachehelper.dart';

class LoginAccess extends StatefulWidget {
  const LoginAccess({Key? key}) : super(key: key);

  @override
  State<LoginAccess> createState() => _LoginAccessState();
}

class _LoginAccessState extends State<LoginAccess> {
  @override
  Widget build(BuildContext context) {
    String ?token = CacheHelper.removeData(key: 'token') as String?;

    if (token != null) {
      return Login();
    } else {
      return Login();
    }
  }
}
