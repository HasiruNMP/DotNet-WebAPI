import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slbfe_citizenapp/api/userAuth.dart';
import 'package:slbfe_citizenapp/utilities/global.dart';
import 'package:slbfe_citizenapp/view/bottomnavigation.dart';
import 'package:slbfe_citizenapp/view/signin.dart';

class StateController extends StatelessWidget {
  const StateController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(Globals.isLoggedIn){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (BuildContext context) => BottomNavigation(Globals.nic))
      );
    }
    else{
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (BuildContext context) => SignIn())
      );
    }
    return Container(child: Center(child: Text("Error"),),);
  }
}
