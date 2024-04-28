import 'package:flutter/material.dart';
import 'supabase_functions.dart';
import 'opportunity.dart';
import 'event.dart';
import 'designs.dart';

class VolunteerPage extends StatefulWidget {
  @override
  _VolunteerPageState createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {

  Future<List<VolunteerOpportunityDatabase>> getAllOpportunities() async {
    List<VolunteerOpportunityDatabase> opportunitiesdb = [];
    List tableData = await fetchData('event_table');
    for (var i = 0; i < tableData.length; i++) {
    VolunteerOpportunityDatabase opportunitydb = VolunteerOpportunityDatabase(
      title: tableData[i]['title'],
      date: tableData[i]['date'],
      time: tableData[i]['time'],
      location: tableData[i]['location'],
      description: tableData[i]['description'],
      eventId: tableData[i]['event_id'],
      status: tableData[i]['status'],
    );
    opportunitiesdb.add(opportunitydb);
    
    }
    
    return opportunitiesdb;
  }

  @override
  Widget build(BuildContext context) {
    // var opportunities = Provider.of<OpportunityNotifier>(context).opportunities;
    Future<List> opportunities = getAllOpportunities();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Image.network(
                'https://unitedwayofsemo.org/wp-content/uploads/2021/04/United-Way-Logo-White.png',
                width: 100,
                height: 80,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: CustomPaint(
              size: Size(40, 40),
              painter: DiagonalLinePainter(isBottomLeftAngle: false),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: CustomPaint(
              size: Size(40, 40),
              painter: DiagonalLinePainter(isBottomLeftAngle: true),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomPaint(
              size: Size(40, 40),
              painter: DiagonalLinePainter(isBottomLeftAngle: true),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CustomPaint(
              size: Size(40, 40),
              painter: DiagonalLinePainter(isBottomLeftAngle: false),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: CustomPaint(
              size: Size(20, 20),
              painter: DiagonalLinePainter(isBottomLeftAngle: false),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: CustomPaint(
              size: Size(20, 20),
              painter: DiagonalLinePainter(isBottomLeftAngle: true),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: CustomPaint(
              size: Size(20, 20),
              painter: DiagonalLinePainter(isBottomLeftAngle: true),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CustomPaint(
              size: Size(20, 20),
              painter: DiagonalLinePainter(isBottomLeftAngle: false),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 100.0, 16.0, 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: FutureBuilder<List>(
                    future: opportunities,
                    builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data?[index].status == true) {
                              return ListTile(
                                title: Text(snapshot.data?[index].title,
                                  style: TextStyle(color: textColor)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Date: ${snapshot.data?[index].date}',
                                      style: TextStyle(color: accentColor)),
                                    Text('Location: ${snapshot.data?[index].location}',
                                      style: TextStyle(color: accentColor)),
                                    Text('Description: ${snapshot.data?[index].description}',
                                      style: TextStyle(color: accentColor)),
                                  ],
                                ),
                                onTap: () {
                                  // Navigate to the details page when the event is tapped
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EventDetailsPage(opportunity: snapshot.data?[index]),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        );
                      } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            // While data is loading:
                            return CircularProgressIndicator();
                          }
                      },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DiagonalLinePainter extends CustomPainter {
  final bool isBottomLeftAngle;

  DiagonalLinePainter({this.isBottomLeftAngle = true});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = alternateColor
      ..strokeWidth = 3.0;

    if (isBottomLeftAngle) {
      canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), paint);
    } else {
      canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}