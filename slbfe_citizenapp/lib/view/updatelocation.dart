import 'package:flutter/material.dart';

class UpdateLocation extends StatefulWidget {
  const UpdateLocation({Key? key}) : super(key: key);

  @override
  State<UpdateLocation> createState() => _UpdateLocationState();
}

class _UpdateLocationState extends State<UpdateLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Location"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: null
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: (){},
                    child: Text("Update Location"),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
