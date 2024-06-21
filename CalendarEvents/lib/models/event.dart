import 'package:cloud_firestore/cloud_firestore.dart';

//class Event {
  //final String id;
  //final String title;
  //final DateTime date;


  //Event({
    //required this.id,
    //required this.title,
    //required this.date,
    //required this.description,
  //});

  //factory Event.fromJson(DocumentSnapshot doc) {
    //Map data = doc.data() as Map<String, dynamic>;
    //return Event(
        //id: doc.id,
        //title: data['title'],
        //date: (data['date'] as Timestamp).toDate(),

    //);

  //}
//}



class Event {
  final String id, title;
  final String? starttime, endtime;
  final DateTime date;


  Event({
    required this.id,
    required this.title,
    required this.date,
    this.starttime,
    this.endtime,
  });


  factory Event.fromJson(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Event(
        id: doc.id,
        title: data['title'],
        date: (data['date'] as Timestamp).toDate(),
        starttime :data['starttime'],
        endtime :data['endtime']
    );


  }
}

