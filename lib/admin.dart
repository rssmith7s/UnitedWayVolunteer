import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'designs.dart';
import 'opportunity.dart';
import 'login.dart';
import 'vollist.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  void _acceptOpportunity(VolunteerOpportunity opportunity) {
    opportunity.status = OpportunityStatus.accepted;
    Provider.of<OpportunityNotifier>(context, listen: false).notifyListeners();
  }

  void _rejectOpportunity(VolunteerOpportunity opportunity) {
    opportunity.status = OpportunityStatus.rejected;
  }

  void _goToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _viewVolunteerList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VolunteerListPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var opportunities = Provider.of<OpportunityNotifier>(context).opportunities;

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _viewVolunteerList,
<<<<<<< Updated upstream
              child: Text(
                'View All Volunteers',
                style: TextStyle(color: accentColor),
              ),
=======
              child: Text('View All Volunteers',
              style: TextStyle(color: colorScheme.secondary),),
>>>>>>> Stashed changes
            ),
            const SizedBox(height: 16),
            Text(
              'Pending Opportunities:',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: opportunities.length,
                itemBuilder: (context, index) {
                  if (opportunities[index].status ==
                      OpportunityStatus.pending) {
                    return ListTile(
<<<<<<< Updated upstream
                      title: Text(
                        opportunities[index].organization,
                        style: TextStyle(color: textColor),
                      ),
                      subtitle: Text(
                        'Date: ${opportunities[index].date}',
                        style: TextStyle(color: accentColor),
                      ),
=======
                      title: Text(opportunities[index].organization, style: TextStyle(color: textColor),),
                      subtitle: Text('Date: ${opportunities[index].date}', style: TextStyle(color: colorScheme.secondary),),
>>>>>>> Stashed changes
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check),
<<<<<<< Updated upstream
                            onPressed: () =>
                                _acceptOpportunity(opportunities[index]),
=======
                            onPressed: () => _acceptOpportunity(opportunities[index]),
>>>>>>> Stashed changes
                            color: textColor,
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
<<<<<<< Updated upstream
                            onPressed: () {
=======
                            onPressed: (){
>>>>>>> Stashed changes
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
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Approved Opportunities:',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: opportunities.length,
                itemBuilder: (context, index) {
                  if (opportunities[index].status ==
                      OpportunityStatus.accepted) {
                    return ListTile(
                      title: Text(
                        opportunities[index].organization,
                        style: TextStyle(color: textColor),
                      ),
                      subtitle: Text('Date: ${opportunities[index].date}',
<<<<<<< Updated upstream
                          style: TextStyle(color: accentColor)),
=======
                        style: TextStyle(color: colorScheme.secondary)),
>>>>>>> Stashed changes
                      onTap: () => _viewVolunteerList(),
                    );
                  } else {
                    return const SizedBox.shrink();
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
