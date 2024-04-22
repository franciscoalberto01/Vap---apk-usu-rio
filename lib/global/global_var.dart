import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String userName = "";
String userPhone = "";
String userID = FirebaseAuth.instance.currentUser!.uid;

String googleMapKey = "AIzaSyBgXX0iNkVoifr7vnuESyfzqyAbL6lT3hQ";
String serverKeyFCM =
    "key=AAAAWeZxtXE:APA91bGLkrAq8-gZ8p6WzVZj5iloQh3QDvtFSvyoGJh-MSnaQ93eHRoSkmwMmwVZvjmiXn_8ndG8cUOGnSaihWC15NCGVk-8ENEERrLg7zmLWp6sgThUA84RvP1Wq1WB7zAPNej25CTZ";

const CameraPosition googlePlexInitialPosition = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);
