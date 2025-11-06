import 'dart:convert';
import 'dart:io';

import 'package:covid_tracker_app/model/drop_down_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  Future<List<DropDownModel>> getPost() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (response.statusCode == 200) {
        final body = json.decode(response.body) as List;
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return DropDownModel(
            userId: map['userId'],
            id: map['id'],
            title: map['title'],
            body: map['body'],
          );
        }).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
   var selectedValue;
  @override
  Widget build(BuildContext context) {

    return Scaffold(body: Column(children: [
      FutureBuilder<List<DropDownModel>>(
        future: getPost(), 
        builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DropdownButton(
            value: selectedValue,
            hint: Text("select value"),
            items: snapshot.data!.map(
              (e){ 
                return DropdownMenuItem(
                  value: e.id.toString(),
                  child: Text(e.id.toString()));
              }
              ).toList(),
            onChanged: (value) {
            selectedValue = value;
            setState(() {
              
            });
          },);
        }else{
          return CircularProgressIndicator();
        }
      },)

        ],
      ));
  }
}
