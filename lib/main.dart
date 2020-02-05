import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';


void main() async{
  
  var _data = await getJsonData();
  List _jsonData = _data['features'];

  var format = new DateFormat("yMd");
 
   runApp(
  new MaterialApp(
    title: "Earth Quake App",
    home: new Scaffold(
      appBar: AppBar(
        title: Text("Quakes"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _jsonData.length,
          itemBuilder: (BuildContext context, int position){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Divider(height: 3.5),
                Center(
                  child: ListTile(
                    title: Text((new DateTime.fromMicrosecondsSinceEpoch(_jsonData[position]["properties"]["time"])).toString(),
                    style: TextStyle(
                      color: Colors.orange
                    ),),
                    subtitle: Text(_jsonData[position]["properties"]["title"].substring(8, _jsonData[position]["properties"]["title"].length)),
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text((_jsonData[position]["properties"]["mag"]).toString()),
                    ),
                    onTap: ()=>showTapMessage(context, "Quakes", _jsonData[position]["properties"]["title"]),
                  ),
                )
              ]
            );
          }),
      ),
    ),
  )
);
}


Future<Map> getJsonData() async {
  String url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson";
   http.Response response = await http.get(url);
    return json.decode(response.body);
}
  
void showTapMessage(BuildContext context, String message, String message2) {
   var alertDialog = new AlertDialog(
        title: Text(message),
        content: Text(message2),
        actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("OK"))
        ],
   );
  showDialog(context: context, builder: (context){
      return alertDialog;
  });
   
}