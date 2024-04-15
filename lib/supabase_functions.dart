import 'package:supabase_flutter/supabase_flutter.dart';
import 'opportunity.dart';

// void fetchData() async {
//   final response = await Supabase.instance.client
//       .from('event_table')
//       .select('*');

//   if (response != null) {
//       for (final row in response) {
//         print('Fetched row: $row');
//       }
//     }
// }

Future<void> updateOpportunityStatus(String title) async {
  final supabase = Supabase.instance.client;

  final response = await supabase
      .from('event_table')
      .update({'status': true}).eq('title', title);

  if (response.error != null) {
    throw Exception(
        'Failed to update event status: ${response.error!.message}');
  }
}

Future<void> insertOpportunity(VolunteerOpportunity opportunity) async {
  try {
    final response = await Supabase.instance.client.from('event_table').insert({
      'title': opportunity.title,
      'date': opportunity.date,
      'time': opportunity.time,
      'location': opportunity.location,
      'description': opportunity.description,
    });

    final List<dynamic> insertedEvents = response.data ?? [];
    final Map<String, dynamic> insertedEvent =
        insertedEvents.isNotEmpty ? insertedEvents[0] : {};
    final String eventId = insertedEvent['event_id'] as String;
    opportunity.eventId = eventId;

    //print eventId dumbass

    if (response.error != null && response.error.message != null) {
      print('Error inserting opportunity: ${response.error.message}');
    } else if (response.error != null) {
      print('Error inserting opportunity: Unknown error occurred');
    } else {
      print('Opportunity inserted successfully');
    }
  } catch (error) {
    print('Error inserting opportunity(catch): $error');
  }
}

Future<void> removeOpportunity(String eventId) async {
  try {
    final response = await Supabase.instance.client
        .from('event_table')
        .delete()
        .eq('event_id', eventId);

    if (response.error != null && response.error.message != null) {
      // Handle error
      print('Error removing opportunity: ${response.error.message}');
    } else if (response.error != null) {
      // Handle error without message
      print('Error removing opportunity: Unknown error occurred');
    } else {
      // Deletion successful
      print('Opportunity removed successfully');
    }
  } catch (error) {
    print('Error removing opportunity (catch): $error');
  }
}

Future<void> insertVolunteer(Volunteer volunteer) async {
  try {
    final response = await Supabase.instance.client.from('user_table').insert({
      'first_name': volunteer.first_name,
      'last_name': volunteer.last_name,
      'email': volunteer.email,
      'phone': volunteer.phone,
    });

    if (response.error != null && response.error.message != null) {
      print('Error inserting opportunity: ${response.error.message}');
    } else if (response.error != null) {
      print('Error inserting opportunity: Unknown error occurred');
    } else {
      print('Opportunity inserted successfully');
    }
  } catch (error) {
    print('Error inserting opportunity: $error');
  }
}
