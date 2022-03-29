import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'),backgroundColor: Colors.blue,),
      body: SafeArea(
        child: Column(
          children: [
           Center(
             child: InkWell(
               child: ImageIcon( AssetImage("assets/profile.png"),
                    color: Colors.black26,
                    size: 110,),
             ),


             
           ),

            Container(
              height: 200,
              width: 360,
              color: Colors.black26,
              child:Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  children: [

                    Row(
                        children: [
                          Icon(Icons.person),
                          Text("name")
                        ],
                      ),
                    SizedBox(
                      height: 13,
                    ),
                    Row(
                      children: [
                        Icon(Icons.mail),
                        Text("E-Mail")
                      ],
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone),
                        Text("Phone")
                      ],
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Row(
                      children: [
                        Icon(Icons.perm_identity),
                        Text("NIC")
                      ],
                    ),
                  ],
                ),
              )
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 360,
              child: ElevatedButton(onPressed: (){}, child: const Text('More Details'),style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)
                      )
                  )
              )),
            ),
            SizedBox(
              height: 9,
            ),
            SizedBox(
              width: 360,
              child: ElevatedButton(onPressed: (){}, child: const Text('Documents'),style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)
                      )
                  )
              )),
            ),
            SizedBox(
              height: 9,
            ),
            SizedBox(
              width: 360,
              child: ElevatedButton(onPressed: (){}, child: const Text('Location'),style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)
                      ),
                  ),
              )),
            ),
            SizedBox(
              height: 9,
            ),
            SizedBox(
              width: 360,
              child: ElevatedButton(onPressed: (){}, child: const Text('Contacts'),style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)
                      )
                  )
              )),
            ),
            SizedBox(
              height: 9,
            ),
            SizedBox(
              width: 360,
              child: ElevatedButton(onPressed: (){}, child: const Text('Account'),style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)
                      )
                  )
              )),
            ),
          ],
          
        ),
      ),
      
    );
  }
}

