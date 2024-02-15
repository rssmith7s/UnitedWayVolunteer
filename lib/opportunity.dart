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
  String organization;
  String date;
  String time;
  String location;
  String description;
  OpportunityStatus status;
  List<Volunteer> volunteers; // New property to hold a list of volunteers

  VolunteerOpportunity({
    required this.organization,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.status,
    List<Volunteer>? volunteers, // Provide a default empty list
  }) : volunteers = volunteers ?? [];
}

class Volunteer {
  String firstName;
  String lastName;
  String phoneNumber;
  String email;

  Volunteer({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
  });
}

enum OpportunityStatus {
  pending,
  accepted,
  rejected,
}