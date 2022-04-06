import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:slbfe_website/views/profile.dart';

class Validate extends StatefulWidget {
  const Validate({Key? key}) : super(key: key);

  @override
  State<Validate> createState() => _ValidateState();
}

class _ValidateState extends State<Validate> {
  //late TabController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blueGrey.shade50,
      //height: MediaQuery.of(context).size.height/1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                //color: Colors.deepPurple,
                child: ListView(
                  children: [
                    ValidateCard(),
                  ],
                )
              ),
            ),
            VerticalDivider(),
            Expanded(
              flex: 4,
              child: Profile()
            ),
          ],
        ),
      ),
    );
  }
}

class ValidateCard extends StatelessWidget {
  const ValidateCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 8),
      child: Card(
        color: Colors.teal.shade100,
        child: InkWell(
          onTap: (){},
          child: ListTile(
            title: Text("NIC, Date Time"),
            subtitle: Text("preview"),
          ),
        ),
      ),
    );
  }
}
