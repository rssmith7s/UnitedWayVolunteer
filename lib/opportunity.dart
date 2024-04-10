import 'package:flutter/material.dart';

class OpportunityNotifier with ChangeNotifier {
  List<VolunteerOpportunity> _opportunities = [];

  List<VolunteerOpportunity> get opportunities => _opportunities;

  set opportunities(List<VolunteerOpportunity> opportunities) {
    _opportunities = opportunities;
    notifyListeners();
  }
}

class VolunteerOpportunity {
  String title;
  String date;
  String time;
  String location;
  String description;
  String eventId;
  OpportunityStatus status;
  List<Volunteer> volunteers; // New property to hold a list of volunteers

  VolunteerOpportunity({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.status,
    required this.eventId,
    List<Volunteer>? volunteers, // Provide a default empty list
  }) : volunteers = volunteers ?? [];
}

class Volunteer {
  String first_name;
  String last_name;
  String email;
  String phone;
  

  Volunteer({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.phone,
  });
}

enum OpportunityStatus {
  pending,
  accepted,
  rejected,
}