import 'package:flutter/material.dart';

class Complaints extends StatefulWidget {
  const Complaints({Key? key}) : super(key: key);

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  
  //final _controller = TabController(length: 2, vsync: null);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blueGrey.shade50,
      height: MediaQuery.of(context).size.height/1,
      child: DefaultTabController(
        length: 2,
        child: TabBar(
          tabs: [
            new Tab(
              icon: const Icon(Icons.home),
              text: 'Address',
            ),
            new Tab(
              icon: const Icon(Icons.my_location),
              text: 'Location',
            ),
          ],
        ),
      ),
    );
  }
}
