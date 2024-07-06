import 'package:donorlink/Models/Admin.dart';
import 'package:donorlink/Models/Interaction.dart';
import 'package:donorlink/Models/User.dart';
import 'package:donorlink/views/Admin/view_interaction.dart';
import 'package:donorlink/views/templates/interaction_chart.dart';
import 'package:flutter/material.dart';
import 'package:string_capitalize/string_capitalize.dart';

class ViewInteractions extends StatefulWidget {
  final Admin admin;
  final User? user;
  final String? type;
  const ViewInteractions({super.key, this.user, required this.type, required this.admin,});

    @override
  _PageState createState() => _PageState();
}

class _PageState extends State<ViewInteractions> {
  String _searchText = "";
  late Future<List<Interaction>> _elementsFuture;
  late List<Interaction> elements;

  @override
  void initState() {
    super.initState();
    if(widget.user != null && widget.type!=null)_elementsFuture = widget.user!.getInteractions(widget.type!); 
    if(widget.user == null && widget.type!=null)_elementsFuture = widget.admin.getInteractions(widget.type!); 
    if(widget.user == null && widget.type==null)_elementsFuture = widget.admin.getAllInteractions(); 
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
            Text('View ${widget.type ?? 'Interactions'}'),
            if(widget.type != null) Chart(widget.type!, _elementsFuture),
            TextField(
              decoration: InputDecoration(
                labelText: 'Search ${widget.type ?? 'Interactions'}',
                prefixIcon: const Icon(Icons.search),
              ),
              // Update _searchText on user input change
              onChanged: (text) { 
                setState(() {
                  _searchText = text;
                });
              },
            ),
            Expanded(
              child: FutureBuilder<List<Interaction>>(
                future: _elementsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No ${widget.type!.capitalize()}s found.'));
                  }

                  List<Interaction> elements = snapshot.data!;

                  elements = elements.where((element) =>
                  element.getDate().toLowerCase().contains(_searchText.toLowerCase())).toList();

                  return ListView.builder(
                    itemCount: elements.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(elements[index].getDate()),
                          subtitle: Text('Donor: ${elements[index].donor.name}\nOrganisation: ${elements[index].org.name}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ViewInteraction(user: widget.admin, inter: elements[index],),),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          if(widget.type==null) Column(children: [
              ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewInteractions(user: widget.user, type: 'donation' ,admin: widget.admin),
                  ),
                );
              },
              child: const Text('View Donations'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewInteractions(user: widget.user, type: 'appointment', admin: widget.admin ,),
                  ),
                );
              },
              child: const Text('View Appointments'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewInteractions(user: widget.user, type: 'rating' ,admin: widget.admin),
                  ),
                );
              },
              child: const Text('View Ratings'),
            ),
            ],),
         
          ],
        ),
      ),
    );
  }
  
}
