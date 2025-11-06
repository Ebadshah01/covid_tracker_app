import 'package:covid_tracker_app/services/states_services.dart';
import 'package:covid_tracker_app/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return
     Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.black,
         title: Text("All Countries", style: TextStyle(color: Colors.white)),
         centerTitle: true,
       ),
       backgroundColor: Colors.black,
       body: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
           children: [
             TextFormField(
              style: TextStyle(
                color: Colors.white
              ),
               controller: searchController,
               onChanged: (value) {
                 setState(() {});
               },
               decoration: InputDecoration(
                 contentPadding: EdgeInsets.symmetric(
                   horizontal: 20,
                   vertical: 5,
                 ),
     
                 hintText: 'Search',
                 hintStyle: TextStyle(color: Colors.white),
     
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(40),
                   borderSide: BorderSide(color: Colors.white),
                 ),
               ),
             ),
             SizedBox(height: 20,),
             Expanded(
               child: FutureBuilder(
                 future: statesServices.countriesListApi(),
                 builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                   if (!snapshot.hasData) {
                     // return Text("Loading");
                     return ListView.builder(
                       itemCount: 8,
                       itemBuilder: (context, index) {
                         return Shimmer.fromColors(
                           baseColor: Colors.grey.shade600,
                           highlightColor: Colors.white,
                           child: ListTile(
                             leading: Container(
                               height: 40,
                               width: 60,
                               color: Colors.grey.shade900,
                             ),
                             title: Container(
                               height: 10,
                               width: 100,
                               color: Colors.grey.shade900,
                             ),
                             subtitle: Container(
                               height: 10,
                               width: 50,
                               color: Colors.grey.shade900,
                             ),
                           ),
                         );
                       },
                     );
                   } else {
                     return ListView.builder(
                       itemCount: snapshot.data!.length,
                       itemBuilder: (context, index) {
                         String name = snapshot.data![index]['country'];
                         if (searchController.text.isEmpty) {
                           return InkWell(
                             onTap: () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => DetailScreen(
                                     name: snapshot.data![index]['country'],
                                     image: snapshot
                                         .data![index]['countryInfo']['flag'],
                                     cases: snapshot.data![index]['cases'],
                                     deaths: snapshot.data![index]['deaths'],
                                     recovered:
                                         snapshot.data![index]['recovered'],
                                   ),
                                 ),
                               );
                             },
                             child: ListTile(
                               leading: Container(
                                 decoration: BoxDecoration(
                                   border: Border.all(color: Colors.grey),
                                 ),
                                 child: Image(
                                   height: 40,
                                   width: 60,
                                   fit: BoxFit.cover,
                                   image: NetworkImage(
                                     snapshot
                                         .data![index]['countryInfo']['flag'],
                                   ),
                                 ),
                               ),
                               title: Text(
                                 snapshot.data![index]['country'],
                                 style: TextStyle(color: Colors.white),
                               ),
                               subtitle: Text(
                                 snapshot.data![index]['countryInfo']['iso3']
                                     .toString(),
                                 style: TextStyle(color: Colors.white),
                               ),
                             ),
                           );
                         } else if (name.toLowerCase().contains(
                           searchController.text.toLowerCase(),
                         )) {
                           return InkWell(
                             onTap: () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => DetailScreen(
                                     name: snapshot.data![index]['country'],
                                     image: snapshot
                                         .data![index]['countryInfo']['flag'],
                                     cases: snapshot.data![index]['cases'],
                                     deaths: snapshot.data![index]['deaths'],
                                     recovered:
                                         snapshot.data![index]['recovered'],
                                   ),
                                 ),
                               );
                             },
                             child: ListTile(
                               leading: Image(
                                 height: 40,
                                 width: 60,
                                 fit: BoxFit.cover,
                                 image: NetworkImage(
                                   snapshot
                                       .data![index]['countryInfo']['flag'],
                                 ),
                               ),
                               title: Text(
                                 snapshot.data![index]['country'],
                                 style: TextStyle(color: Colors.white),
                               ),
                               subtitle: Text(
                                 snapshot.data![index]['countryInfo']['iso3']
                                     .toString(),
                                 style: TextStyle(color: Colors.white),
                               ),
                             ),
                           );
                         } else {
                           return Container();
                         }
                       },
                     );
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
