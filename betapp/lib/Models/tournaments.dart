// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Tournament{
  final String? name;
  final String? image_url;
  String? _uid;

  Tournament({
    this.name,
    this.image_url
  });


  String getUID(){
    return _uid ?? "";
  }
  
  void setUID(String uid){
    _uid = uid;
  }

  String getName(){
    return name ?? "";
  }

  String getImage(){
    return image_url ?? "";
  }

  factory Tournament.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options
  ){
    final data = snapshot.data();
    return Tournament(
      name: data?["name"],
      image_url: data?["image_url"]
    );
  }


  Map<String, dynamic> toFirestore(){
    return {
      if(name != null) "name":name,
      if(image_url != null) "image_url":image_url,
    };
  }
  

}