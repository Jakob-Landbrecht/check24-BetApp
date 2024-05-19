import 'package:cloud_firestore/cloud_firestore.dart';

class Community{
  final String name;
  String? communityUid;

  Community({
    required this.name,
    this.communityUid
  });

  factory Community.fromFirestore(
    DocumentSnapshot<Map<String,dynamic>> snapshot,
    SnapshotOptions? options,
  ){
    final data = snapshot.data();
    return Community(
      name: data?["name"],
       );
  }


  Map<String, dynamic> toFirestore(){
    return{
      "name": name,
    };
  }

}