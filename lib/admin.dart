import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'designs.dart';
import 'opportunity.dart';
import 'login.dart';
import 'vollist.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  void _acceptOpportunity(VolunteerOpportunity opportunity) {
    opportunity.status = OpportunityStatus.accepted;
    // Provider.of<OpportunityNotifier>(context, listen: false).notifyListeners();
  }

  void _rejectOpportunity(VolunteerOpportunity opportunity) {
    opportunity.status = OpportunityStatus.rejected;
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
            top: 100, // Adjust as needed
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _viewVolunteerList,
                    child: Text(
                      'View All Volunteers',
                      style: TextStyle(color: accentColor),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Pending Opportunities:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: opportunities.length,
                      itemBuilder: (context, index) {
                        if (opportunities[index].status == OpportunityStatus.pending) {
                          return ListTile(
                            title: Text(
                              opportunities[index].organization,
                              style: TextStyle(color: textColor),
                            ),
                            subtitle: Text(
                              'Date: ${opportunities[index].date}',
                              style: TextStyle(color: accentColor),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.check),
                                  onPressed: () => _acceptOpportunity(opportunities[index]),
                                  color: textColor,
                                ),
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    _rejectOpportunity(opportunities[index]);
                                    setState(() {
                                      opportunities.removeAt(index);
                                    });
                                  },
                                  color: textColor,
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
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: opportunities.length,
                      itemBuilder: (context, index) {
                        if (opportunities[index].status == OpportunityStatus.accepted) {
                          return ListTile(
                            title: Text(
                              opportunities[index].organization,
                              style: TextStyle(color: textColor),
                            ),
                            subtitle: Text(
                              'Date: ${opportunities[index].date}',
                              style: TextStyle(color: accentColor),
                            ),
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
          ),
          // Diagonal lines
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
          // Additional diagonal lines
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