import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Attendance/exam.dart';
import 'Attendance/groupdiscussion.dart';
import 'Attendance/personalinterview.dart';



class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
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
                padding: EdgeInsets.all(30.0),
                margin: EdgeInsets.only(top:100),
                
                child: GridView.count(crossAxisCount: 2,
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap:(){ Navigator.push(context, MaterialPageRoute(builder:(context)=>Exam()),);
                  
                        
                      },
                      splashColor:Colors.red,
                      child:Center(child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:[
                          Icon(Icons.library_books,size:60.0),
                          Text("Technical Test",
                          style:TextStyle(fontSize: 17.0),),
                        ],
                      ),),
                    ),
                  ),
                    Card(
                    margin: EdgeInsets.all(8.0),
                    child: InkWell(
                    onTap:(){ Navigator.push(context, MaterialPageRoute(builder:(context)=>GrpDis()),);
                    },
                      splashColor:Colors.red,
                      child:Center(child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:[
                          Icon(Icons.group,size:60.0),
                          
                          Text("  Pre-Placement    \t\tTalk",
                          style:TextStyle(fontSize: 17.0),),
                        ],
                      ),),
                    ),
                  ),
                    Card(
                    margin: EdgeInsets.all(8.0),
                    child: InkWell(
                     onTap:(){ Navigator.push(context, MaterialPageRoute(builder:(context)=>PerIn()),);
                    },
                      splashColor:Colors.red,
                      child:Center(child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:[
                          Icon(FontAwesomeIcons.laptop,size:60.0),
                          SizedBox(height:10,),
                          Text("Interview",

                          style:TextStyle(fontSize: 17.0),),
                        ],
                      ),),
                    ),
                  ),
                    Card(
                    margin: EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap:(){},
                      splashColor:Colors.red,
                      child:Center(child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:[
                          Icon(FontAwesomeIcons.file,size:60.0),
                          SizedBox(height:10,),
                          Text("Others",
                          style:TextStyle(fontSize: 17.0),),
                        ],
                      ),),
                    ),
                  ),

                ],),
              ),
             
        ],
      ),
    );
  }

}





