import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Financial.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/views/Donors/financial_document.dart';
import 'package:flutter/material.dart';

class ViewFinancials extends StatefulWidget {
  final Donor user;
  final Organisation org;
  const ViewFinancials({super.key, required this.user, required this.org,});

    @override
  _PageState createState() => _PageState();
}

class _PageState extends State<ViewFinancials> {
  String _searchText = "";
  late Future<List<Financial>> _financialsFuture;

  @override
  void initState() {
    super.initState();
    _financialsFuture = widget.org.getFinancials(); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 48,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
          Text('${widget.org.name} Financials', style: Theme.of(context).textTheme.headlineSmall),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Date',
                prefixIcon: Icon(Icons.search),
              ),
              // Update _searchText on user input change
              onChanged: (text) { 
                setState(() {
                  _searchText = text;
                });
              },
            ),
                        Expanded(
              child: FutureBuilder<List<Financial>>(
                future: _financialsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No Financial documents found.'));
                  }

                  List<Financial> fins = snapshot.data!;
                  fins = fins.where((fin) =>
                  fin.getDate().toLowerCase().contains(_searchText.toLowerCase())).toList();

                  return ListView.builder(
                    itemCount: fins.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text('${fins[index].date}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FinancialDocument(user: widget.user, fin: fins[index],),),
                            );
                          },
                        ),
                      );
                    },
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
