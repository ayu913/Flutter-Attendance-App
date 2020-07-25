import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class GrpDis extends StatefulWidget {
  Firestore _firestore = Firestore.instance;
  @override
  _GrpDisState createState() => _GrpDisState();
}

class _GrpDisState extends State<GrpDis> {
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
               title: Text("Pre-Placement Talk"),
            ),
                      body: ListView.builder(
              itemCount: snapshot.data.documents.length,
              
              itemBuilder: (context, index) {
              String itemTitle = snapshot.data.documents[index]['ID'];
              bool status = snapshot.data.documents[index]['status_gd'];
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
  //bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.itemTitle),
        trailing: Checkbox(
          value: widget.status,
          onChanged: (bool) {
            setState(() {
               widget.status = !widget.status;
               _firestore.collection('exam').document(widget.docId)
        .updateData({'status_gd': widget.status});
            });
           
          },
        ),
      ),
    );
  }
}




