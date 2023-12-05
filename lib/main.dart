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

  VolunteerOpportunity({
    required this.organization,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.status,
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
    } else if (username == 'volunteer' && password == 'volunteerpassword') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => VolunteerPage()),
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

class VolunteerPage extends StatefulWidget {
  @override
  _VolunteerPageState createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
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
        title: Text('Volunteer Page'),
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
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// void main() {
//   runApp(VolunteerEventApp());
// }

// class VolunteerEventApp extends StatelessWidget {
//   const VolunteerEventApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: EventListPage(),
//     );
//   }
// }

// class EventListPage extends StatelessWidget {
//   final List<Event> events = getEventList(); // Replace with your event data

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Volunteer Events"),
//       ),
//       body: ListView.builder(
//         itemCount: events.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => EventDetailsPage(event: events[index]),
//                 ),
//               );
//             },
//             child: Card(
//               child: Column(
//                 children: <Widget>[
//                   Image.network(events[index].coverImage),
//                   Text(events[index].title),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class EventDetailsPage extends StatelessWidget {
//   final Event event;

//   EventDetailsPage({required this.event});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(event.title),
//       ),
//       body: Column(
//         children: <Widget>[
//           Image.network(event.coverImage),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               event.description,
//               style: TextStyle(fontSize: 16.0),
//             ),
//           ),
//           // You can add more event details here
//         ],
//       ),
//     );
//   }
// }

// class Event {
//   final String title;
//   final String coverImage;
//   final String description; // Add a description field

//   Event({required this.title, required this.coverImage, required this.description});
// }

// List<Event> getEventList() {
//   return [
//     Event(
//       title: "Trash Pickup",
//       coverImage: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fiseusa.org%2Fthe-importance-of-volunteering%2F&psig=AOvVaw3ELgRJn-xkLXWwkUARSMLP&ust=1698417934956000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCPDT0fz5k4IDFQAAAAAdAAAAABAE",
//       description: '''
//       Date: November 10, 2023\n
//       Time: 9:00 AM - 12:00 PM\n
//       Activity: Trash Pickup Volunteer Event\n
//       \n
//       Join us on November 10, 2023, from 9:00 AM to 12:00 PM for a community-wide Trash Pickup Volunteer Event. 
//       This is an opportunity for us to come together and make our neighborhood cleaner and more beautiful. We will meet at [Location], 
//       where we'll provide gloves, bags, and other necessary equipment. 
//       Please wear comfortable clothing and closed-toe shoes.\n
//       \n
//       Let's work together to make a positive impact on our environment and create a cleaner, healthier community. 
//       Your participation is greatly appreciated, and together, we can make a difference!"
//     '''
//     ),
//     Event(
//       title: "Tree Planting",
//       coverImage: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fstudents.1fbusa.com%2Fpay-it-forward%2F25-ways-to-volunteer-in-your-community&psig=AOvVaw3ELgRJn-xkLXWwkUARSMLP&ust=1698417934956000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCPDT0fz5k4IDFQAAAAAdAAAAABAJ",
//       description: '''
//       Date: April 22, 2023\n
//       Time: 10:00 AM - 1:00 PM\n
//       Activity: Tree Planting Volunteer Event\n
//       \n 
//       On April 22, 2023, from 10:00 AM to 1:00 PM, we invite you to join us for a Tree Planting Volunteer Event. 
//       This event is part of our efforts to promote a greener and more sustainable community. We will meet at [Location], 
//       where you'll be provided with the necessary tools and saplings. Please come dressed in comfortable outdoor clothing 
//       and bring a water bottle to stay hydrated.\n
// \n
//       Let's work together to enhance our local environment, improve air quality, and beautify our neighborhood. 
//       Your participation is crucial in creating a more sustainable and green future for our community. 
//       We look forward to planting trees with you on this special day!
//       '''
//     ),
//     // Add more events here
//   ];
// }

