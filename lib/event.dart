import 'package:flutter/material.dart';
import 'opportunity.dart';
import 'designs.dart';

class EventDetailsPage extends StatefulWidget {
  final VolunteerOpportunity opportunity;

  const EventDetailsPage({super.key, required this.opportunity});

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void _submitVolunteerInfo() {
  String firstName = firstNameController.text.trim();
  String lastName = lastNameController.text.trim();
  String phoneNumber = phoneNumberController.text.trim();
  String email = emailController.text.trim();

  if (firstName.isNotEmpty &&
      lastName.isNotEmpty &&
      phoneNumber.isNotEmpty &&
      email.isNotEmpty) {
    // Create a new Volunteer object
    Volunteer newVolunteer = Volunteer(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
    );

    // Add the new volunteer to the opportunity's list of volunteers
    widget.opportunity.volunteers.add(newVolunteer);

    // You can implement logic to send this information to the administrator and partner
    // For simplicity, let's just print the information for now
    print('Volunteer Information Submitted:');
    print('Name: $firstName $lastName');
    print('Phone Number: $phoneNumber');
    print('Email: $email');

    // Clear the form fields
    firstNameController.clear();
    lastNameController.clear();
    phoneNumberController.clear();
    emailController.clear();
  } else {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Please fill in all fields.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Organization: ${widget.opportunity.organization}',
              style: const TextStyle(color: textColor)),
            Text('Date: ${widget.opportunity.date}',
              style: const TextStyle(color: textColor)),
            Text('Time: ${widget.opportunity.time}',
              style: const TextStyle(color: textColor)),
            Text('Location: ${widget.opportunity.location}',
              style: const TextStyle(color: textColor)),
            Text('Description: ${widget.opportunity.description}',
              style: const TextStyle(color: textColor)),
            const SizedBox(height: 20),
            const Text('Volunteer Information Form:',
              style: TextStyle(color: textColor)),
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
              cursorColor: accentColor,
              style: const TextStyle(color: textColor),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
              style: const TextStyle(color: textColor),
              cursorColor: accentColor,
            ),
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              style: const TextStyle(color: textColor),
              cursorColor: accentColor,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              style: const TextStyle(color: textColor),
              cursorColor: accentColor,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitVolunteerInfo,
              child: const Text('Submit Volunteer Information',
              style: TextStyle(color: accentColor),),
            ),
          ],
        ),
      ),
    );
  }
}
