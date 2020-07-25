import 'package:CAA/scannerpage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class Exam extends StatefulWidget {
  static String routeName ='/exam';
  Firestore _firestore = Firestore.instance;
  @override
  _ExamState createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: widget._firestore.collection('exam').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('Loading...');
          }
          return Scaffold(
            appBar:AppBar(
               title: Text("Technical Test"),
            ),
                      body: ListView.builder(
              itemCount: snapshot.data.documents.length,
              
              itemBuilder: (context, index) {
              String itemTitle = snapshot.data.documents[index]['ID'];
              bool status = snapshot.data.documents[index]['status_coding'];
              String docId = snapshot.data.documents[index].documentID;
              return CardItem(itemTitle: itemTitle, status: status, docId: docId);
            }),
          );
        });
  }
}

// ignore: must_be_immutable
class CardItem extends StatefulWidget {
  String itemTitle;
  bool status;
  String docId;
 
  CardItem({this.itemTitle, this.status, this.docId});
  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  Firestore _firestore =  Firestore.instance;
  String _name ="";

  //bool isChecked = false;


  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    getNamePreference().then(updateName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.itemTitle),
      //  subtitle: Text(_name),
       
        trailing: Checkbox(
          value: widget.status,
          onChanged: (bool) {
             print(_name.length);
              print(widget.itemTitle.length);
            if(_name.trim() == widget.itemTitle.trim()){
             
               widget.status = !widget.status;
             _firestore.collection('exam').document(widget.docId)
        .updateData({'status_coding': widget.status});
              }
           
          },
        ),
      ),
    );
  }
  void updateName(String name){
  setState((){
    this._name=name;
  });

}
}

