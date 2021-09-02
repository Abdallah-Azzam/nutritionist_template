import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_reference;

CollectionReference nutristionistCollection =
    FirebaseFirestore.instance.collection('Nutritionist_Users');
CollectionReference nutritionistPostCollection =
    FirebaseFirestore.instance.collection('Nutritionist_post');
CollectionReference nutritionistPublicPost =
    FirebaseFirestore.instance.collection('Nutritionist_Public_Post');
CollectionReference userPost = FirebaseFirestore.instance.collection('posts');
firebase_reference.Reference postPicture =
    firebase_reference.FirebaseStorage.instance.ref().child('postPicture');
CollectionReference postCollection =
    FirebaseFirestore.instance.collection('posts');
CollectionReference userCollection =
    FirebaseFirestore.instance.collection('users');
