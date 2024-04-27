import 'package:flutter/material.dart';
import 'designs.dart';
import 'opportunity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class VolunteerListPage extends StatelessWidget {
//   Future<List<Volunteer>> getAllVolunteers() async {
//     List<Volunteer> volunteersdb = [];
//     List tableData = await fetchVolunteers('user_table');
//     for (var i = 0; i < tableData.length; i++) {
//     Volunteer volunteerdb = Volunteer(
//       first_name: tableData[i]['first_name'],
//       last_name: tableData[i]['last_name'],
//       phone: tableData[i]['phone'],
//       email: tableData[i]['email'],
//       category: tableData[i]['category'],
//       eventId: tableData[i]['event_id'],
//     );
//     volunteersdb.add(volunteerdb);
//     print(volunteerdb);
//     }

//     return volunteersdb;
//   }

  Future<List<Volunteer>> getAllVolunteers() async {
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

      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> tableData = jsonDecode(response.body);
        final List<Volunteer> volunteersdb = [];

        for (var i = 0; i < tableData.length; i++) {
          final Volunteer volunteerdb = Volunteer(
            first_name: tableData[i]['first_name'] ?? '',
            last_name: tableData[i]['last_name'] ?? '',
            email: tableData[i]['email'] ?? '',
            phone: tableData[i]['phone'] ?? '',
            category: tableData[i]['category'] ?? '',
            eventId:
                tableData[i]['event_id'].toString(), // Convert to string
          );
          volunteersdb.add(volunteerdb);
        }

        return volunteersdb;
      } else {
        // Handle unsuccessful response
        print('Error fetching volunteers: ${response.body}');
        return [];
      }
    } catch (error) {
      // Handle exceptions
      print('Error fetching volunteers: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<List> volunteers = getAllVolunteers();

    // Extract all volunteers from all opportunities

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Volunteers:',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
            Expanded(
              child: FutureBuilder<List>(
                future: volunteers,
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        var volunteer = snapshot.data?[index];
                        return ListTile(
                          title: Text(
                            '${volunteer.first_name} ${volunteer.last_name}',
                            style: TextStyle(color: textColor),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Phone: ${volunteer.phone}',
                                style: TextStyle(color: accentColor),
                              ),
                              Text(
                                'Email: ${volunteer.email}',
                                style: TextStyle(color: accentColor),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // While data is loading:
                    return const CircularProgressIndicator();
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
