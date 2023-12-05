import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => OpportunityNotifier(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

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

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _login() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username == 'admin' && password == 'adminpassword') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminPage()),
      );
    } else if (username == 'partner' && password == 'partnerpassword') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PartnerPage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid username or password.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                );
              },
              child: Text('Forgot Password?'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VolunteerPage()),
                );
              },
              child: Text("I'm a Volunteer"),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController usernameController = TextEditingController();

  void _sendResetInstructions() {
    String username = usernameController.text.trim();

    if (username.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter your username.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Reset Instructions Sent'),
          content: Text('Instructions to reset your password have been sent to your email.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendResetInstructions,
              child: Text('Send Reset Instructions'),
            ),
          ],
        ),
      ),
    );
  }
}

class PartnerPage extends StatefulWidget {
  @override
  _PartnerPageState createState() => _PartnerPageState();
}

class _PartnerPageState extends State<PartnerPage> {
  TextEditingController organizationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void _submitOpportunity() {
    String organization = organizationController.text.trim();
    String date = dateController.text.trim();
    String time = timeController.text.trim();
    String location = locationController.text.trim();
    String description = descriptionController.text.trim();

    if (organization.isNotEmpty &&
        date.isNotEmpty &&
        time.isNotEmpty &&
        location.isNotEmpty &&
        description.isNotEmpty) {
      VolunteerOpportunity opportunity = VolunteerOpportunity(
        organization: organization,
        date: date,
        time: time,
        location: location,
        description: description,
        status: OpportunityStatus.pending,
      );

      var opportunities = Provider.of<OpportunityNotifier>(context, listen: false);
      opportunities.opportunities.add(opportunity);
      opportunities.notifyListeners();

      organizationController.clear();
      dateController.clear();
      timeController.clear();
      locationController.clear();
      descriptionController.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );

      print('New Opportunity Submitted: $opportunity');
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all fields.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var opportunities = Provider.of<OpportunityNotifier>(context).opportunities;

    return Scaffold(
      appBar: AppBar(
        title: Text('Partner Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.lock),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: organizationController,
              decoration: InputDecoration(labelText: 'Organization'),
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            TextField(
              controller: timeController,
              decoration: InputDecoration(labelText: 'Time'),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitOpportunity,
              child: Text('Submit Opportunity'),
            ),
            SizedBox(height: 10),
            Text(
              'Accepted Opportunities:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: opportunities.length,
                itemBuilder: (context, index) {
                  if (opportunities[index].status == OpportunityStatus.accepted) {
                    return ListTile(
                      title: Text(opportunities[index].organization),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: ${opportunities[index].date}'),
                          Text('Location: ${opportunities[index].location}'),
                          Text('Description: ${opportunities[index].description}'),
                        ],
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  void _acceptOpportunity(VolunteerOpportunity opportunity) {
    opportunity.status = OpportunityStatus.accepted;
    Provider.of<OpportunityNotifier>(context, listen: false).notifyListeners();
  }

  void _goToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _viewVolunteerList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VolunteerListPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var opportunities = Provider.of<OpportunityNotifier>(context).opportunities;

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.lock),
            onPressed: _goToLoginPage,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _viewVolunteerList,
              child: Text('View All Volunteers'),
            ),
            SizedBox(height: 16),
            Text(
              'Pending Opportunities:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: opportunities.length,
                itemBuilder: (context, index) {
                  if (opportunities[index].status == OpportunityStatus.pending) {
                    return ListTile(
                      title: Text(opportunities[index].organization),
                      subtitle: Text('Date: ${opportunities[index].date}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check),
                            onPressed: () => _acceptOpportunity(opportunities[index]),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              // Handle rejection if needed
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Approved Opportunities:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: opportunities.length,
                itemBuilder: (context, index) {
                  if (opportunities[index].status == OpportunityStatus.accepted) {
                    return ListTile(
                      title: Text(opportunities[index].organization),
                      subtitle: Text('Date: ${opportunities[index].date}'),
                      onTap: () => _viewVolunteerList(),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class VolunteerPage extends StatefulWidget {
  @override
  _VolunteerPageState createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
  @override
  Widget build(BuildContext context) {
    var opportunities = Provider.of<OpportunityNotifier>(context).opportunities;

    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer Opportunities'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.lock),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: opportunities.length,
                itemBuilder: (context, index) {
                  if (opportunities[index].status == OpportunityStatus.accepted) {
                    return ListTile(
                      title: Text(opportunities[index].organization),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: ${opportunities[index].date}'),
                          Text('Location: ${opportunities[index].location}'),
                          Text('Description: ${opportunities[index].description}'),
                        ],
                      ),
                      onTap: () {
                        // Navigate to the details page when the event is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetailsPage(opportunity: opportunities[index]),
                          ),
                        );
                      },
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventDetailsPage extends StatefulWidget {
  final VolunteerOpportunity opportunity;

  EventDetailsPage({required this.opportunity});

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
        title: Text('Error'),
        content: Text('Please fill in all fields.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Organization: ${widget.opportunity.organization}'),
            Text('Date: ${widget.opportunity.date}'),
            Text('Time: ${widget.opportunity.time}'),
            Text('Location: ${widget.opportunity.location}'),
            Text('Description: ${widget.opportunity.description}'),
            SizedBox(height: 20),
            Text('Volunteer Information Form:'),
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitVolunteerInfo,
              child: Text('Submit Volunteer Information'),
            ),
          ],
        ),
      ),
    );
  }
}

class VolunteerListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var opportunities = Provider.of<OpportunityNotifier>(context).opportunities;

    // Extract all volunteers from all opportunities
    var allVolunteers = opportunities.expand((opportunity) => opportunity.volunteers).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('All Volunteers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Volunteers:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allVolunteers.length,
                itemBuilder: (context, index) {
                  var volunteer = allVolunteers[index];
                  return ListTile(
                    title: Text('${volunteer.firstName} ${volunteer.lastName}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone: ${volunteer.phoneNumber}'),
                        Text('Email: ${volunteer.email}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

