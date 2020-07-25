import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'Attendance/exam.dart';
import 'flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class Location {
  int id;
  String name;

  Location({this.id, this.name});

  static List<Location> getLocation() {
    return <Location>[
      Location(id: 1,name: 'Pre-Placement Talk'),
      Location(id: 2,name: 'Technical Exam'),
      Location(id: 3,name: 'Personal Interview'),
      
      
    ];
  }
}

class _ScannerPageState extends State<ScannerPage> {
 static String _scanBarcode = 'Unknown';
  List<Location> _location = Location.getLocation();
  List<DropdownMenuItem<Location>> _dropdownMenuItems;
  Location _selectedLocation;
  

  @override
  void initState() {
    
    _dropdownMenuItems =buildDropDownMenuItems(_location);
    _selectedLocation = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Location>> buildDropDownMenuItems(List locations){
  List<DropdownMenuItem<Location>> items = List();
  for(Location location in locations){
    items.add(
      DropdownMenuItem(
        value: location,
        child:Text(location.name),
      ),
    );
  }
  return items;
  }

onChangeDropdownItem(Location selectedLocation){

  setState((){
    _selectedLocation = selectedLocation;
  });
}
  

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes); 
      // String docId = snapshot.data.documents[index].documentID;
      // final CollectionReference pointsCollection = Firestore.instance.collection("users");
      // await pointsCollection.document(docId).collection('points').document(docId)
      // .updateData({
      //   "points" : FieldValue.increment(1),
      //   "transactions":FieldValue.increment(-1),
      // });
             
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
     
     
      
      _scanBarcode = barcodeScanRes;
       Firestore.instance
      .collection('exam')
      .where('ID', isEqualTo:_scanBarcode)
      .where('status_coding',isEqualTo:false)
      
      .snapshots();
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Stack(
          
          children: <Widget>[
             Container(
                   height: 250,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
          ),
         
            Container(
              padding: EdgeInsets.only(top:100,left: 80,),

           child: Column(
            children: [
            DropdownButton(items: _dropdownMenuItems, onChanged: onChangeDropdownItem,hint:Text("Location",style:TextStyle(color: Colors.black,fontSize: 20,),),),
            SizedBox(height:20.0,),
            Text('Selected:${_selectedLocation.name}',
             
            style:TextStyle(color: Colors.black,fontSize: 16,),
            ),
          ],
           ),
             ),
      //       Firestore.instance
      // .collection('Tasks')
      // .orderBy("deadline")
      // .orderBy("assignedTime")
      // .where('assignedTo', isEqualTo: uid)
      // .where('status', isEqualTo: false)
      // .snapshots();
            Container(
              
                padding: EdgeInsets.only(top:350,left: 80,),
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                      onPressed: () => scanBarcodeNormal(),
                      child: Text("Start barcode scan")),
                       Text('Scan result : $_scanBarcode\n',
                style: TextStyle(fontSize: 20),),
                       RaisedButton(
                    color: Colors.blue,
                      onPressed: () => saveName(),
                      child: Text("Sheet"),
                      ),
                ],
              ),
            ),
           
          ]
  ));
}


void saveName(){
    String name = _scanBarcode;
    saveNamePreference(name).then((bool committed){
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Exam()),);
      Navigator.of(context).pushNamed(Exam.routeName);
    });
  }
}
  

  
  Future<bool> saveNamePreference(String name) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    prefs.setString("name",name);

    // ignore: deprecated_member_use
    return prefs.commit();
  }
  
  Future<String> getNamePreference() async{
   SharedPreferences prefs= await SharedPreferences.getInstance();
    String name = prefs.getString("name");

    return name;

  }