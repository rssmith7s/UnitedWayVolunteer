import 'package:flutter/material.dart';

void main() {
  runApp(VolunteerEventApp());
}

class VolunteerEventApp extends StatelessWidget {
  const VolunteerEventApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EventListPage(),
    );
  }
}

class EventListPage extends StatelessWidget {
  final List<Event> events = getEventList(); // Replace with your event data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Volunteer Events"),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailsPage(event: events[index]),
                ),
              );
            },
            child: Card(
              child: Column(
                children: <Widget>[
                  Image.network(events[index].coverImage),
                  Text(events[index].title),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class EventDetailsPage extends StatelessWidget {
  final Event event;

  EventDetailsPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: Column(
        children: <Widget>[
          Image.network(event.coverImage),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              event.description,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          // You can add more event details here
        ],
      ),
    );
  }
}

class Event {
  final String title;
  final String coverImage;
  final String description; // Add a description field

  Event({required this.title, required this.coverImage, required this.description});
}

List<Event> getEventList() {
  return [
    Event(
      title: "Trash Pickup",
      coverImage: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fiseusa.org%2Fthe-importance-of-volunteering%2F&psig=AOvVaw3ELgRJn-xkLXWwkUARSMLP&ust=1698417934956000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCPDT0fz5k4IDFQAAAAAdAAAAABAE",
      description: '''
      Date: November 10, 2023\n
      Time: 9:00 AM - 12:00 PM\n
      Activity: Trash Pickup Volunteer Event\n
      \n
      Join us on November 10, 2023, from 9:00 AM to 12:00 PM for a community-wide Trash Pickup Volunteer Event. 
      This is an opportunity for us to come together and make our neighborhood cleaner and more beautiful. We will meet at [Location], 
      where we'll provide gloves, bags, and other necessary equipment. 
      Please wear comfortable clothing and closed-toe shoes.\n
      \n
      Let's work together to make a positive impact on our environment and create a cleaner, healthier community. 
      Your participation is greatly appreciated, and together, we can make a difference!"
    '''
    ),
    Event(
      title: "Tree Planting",
      coverImage: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fstudents.1fbusa.com%2Fpay-it-forward%2F25-ways-to-volunteer-in-your-community&psig=AOvVaw3ELgRJn-xkLXWwkUARSMLP&ust=1698417934956000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCPDT0fz5k4IDFQAAAAAdAAAAABAJ",
      description: '''
      Date: April 22, 2023\n
      Time: 10:00 AM - 1:00 PM\n
      Activity: Tree Planting Volunteer Event\n
      \n 
      On April 22, 2023, from 10:00 AM to 1:00 PM, we invite you to join us for a Tree Planting Volunteer Event. 
      This event is part of our efforts to promote a greener and more sustainable community. We will meet at [Location], 
      where you'll be provided with the necessary tools and saplings. Please come dressed in comfortable outdoor clothing 
      and bring a water bottle to stay hydrated.\n
\n
      Let's work together to enhance our local environment, improve air quality, and beautify our neighborhood. 
      Your participation is crucial in creating a more sustainable and green future for our community. 
      We look forward to planting trees with you on this special day!
      '''
    ),
    // Add more events here
  ];
}

