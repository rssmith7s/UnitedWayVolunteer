import 'package:supabase_flutter/supabase_flutter.dart';
import 'opportunity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

fetchData(String table) async {
  final response = await Supabase.instance.client.from(table).select('*');

  for (final row in response) {
    print('Fetched row: $row');
  }
  return response;
}

fetchVolunteers(String table) async {
  final response = await Supabase.instance.client
      .from(table)
      .select('*')
      .like('category', 'volunteer');

  for (final row in response) {
    print('Fetched row: $row');
  }
  return response;
}

fetchSpecific(String table, String row, String column) async {
  final response = await Supabase.instance.client
      .from(table)
      .select('*')
      .like(column, row); // (event_id, specific_id)

  for (final row in response) {
    print('Fetched row: $row');
  }
  return response;
}

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

Future<void> removeOpportunity(String title) async {
  try {
    final response = await Supabase.instance.client
        .from('event_table')
        .delete()
        .eq('title', title);

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

// Future<void> insertVolunteer(Volunteer volunteer) async {
//   try {
//     final response = await Supabase.instance.client.from('user_table').insert({
//       'first_name': volunteer.first_name,
//       'last_name': volunteer.last_name,
//       'email': volunteer.email,
//       'phone': volunteer.phone,
//       'event_id': volunteer.eventId,
//     });

//     if (response.error != null && response.error.message != null) {
//       print('Error inserting opportunity: ${response.error.message}');
//     } else if (response.error != null) {
//       print('Error inserting opportunity: Unknown error occurred');
//     } else {
//       print('Opportunity inserted successfully');
//     }
//   } catch (error) {
//     print('Error inserting opportunity: $error');
//   }
// }

Future<void> insertVolunteer(Volunteer volunteer) async {
  try {
    final url = Uri.parse(
        'https://ynxtlagcgaktgltpzqoa.supabase.co/rest/v1/user_table');
    final headers = {
      'apikey':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlueHRsYWdjZ2FrdGdsdHB6cW9hIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcxMTM5OTA1MywiZXhwIjoyMDI2OTc1MDUzfQ.odMJuJgMJ7gIJRXQKM_ncm1-KQaPIVt4eSADTzveQVo',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlueHRsYWdjZ2FrdGdsdHB6cW9hIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcxMTM5OTA1MywiZXhwIjoyMDI2OTc1MDUzfQ.odMJuJgMJ7gIJRXQKM_ncm1-KQaPIVt4eSADTzveQVo',
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        'first_name': volunteer.first_name,
        'last_name': volunteer.last_name,
        'email': volunteer.email,
        'phone': volunteer.phone,
        'event_id': volunteer.eventId,
      }),
    );

    if (response.statusCode == 201) {
      print('Volunteer inserted successfully');
    } else {
      print('Error inserting volunteer: ${response.body}');
    }
  } catch (error) {
    print('Error inserting volunteer: $error');
  }
}
