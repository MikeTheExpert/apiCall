import 'dart:convert';

import 'package:api_calls/models/user_dob.dart';
import 'package:api_calls/models/user_location.dart';
import 'package:api_calls/models/user_reg.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import '../models/user_name.dart';

class ApiCall {
  Future fetchUsers() async {
    //change variable, to vary the number of users.
    final int numOfUsers = 20;
    // SETUP for fetching JSON
    final uri = 'https://randomuser.me/api/?results=$numOfUsers ';
    final url = Uri.parse(uri);
    final response = await http.get(url);
    final body = response.body;
    final json = jsonDecode(body);

    //transforming the result into presentable obj types
    final result = json['results'] as List<dynamic>;

    //mapping the data types from json to dart
    final transformation =
        result.map((e) {
          //returning name obj
          final name = UserName(
            title: e['name']['title'],
            first: e['name']['first'],
            last: e['name']['last'],
          );

          //returning streetLocation parameters
          final street = StreetLocation(
            number: e['location']['street']['number'],
            name: e['location']['street']['name'],
          );

          //returning LocationTimezone parameters
          final timezone = LocationTimezone(
            offset: e['location']['timezone']['offset'],
            description: e['location']['timezone']['description'],
          );

          //returning location obj
          final location = Location(
            city: e['location']['city'],
            state: e['location']['state'],
            country: e['location']['country'],
            postcode: e['location']['postcode'],
            streetLocation: street,
            timezone: timezone,
          );

          //returning registered obj
          final registered = RegDate(
            age: e['registered']['age'],
            date: e['registered']['date'],
          );

          //returning dateOfBirth obj
          final dob = DateOfBirth(age: e['dob']['age'],
              date: e['dob']['date']);

          //retuning List of Users
          return Users(
            email: e['email'],
            cell: e['cell'],
            gender: e['gender'],
            nat: e['nat'],
            phone: e['phone'],
            fullName: name,
            registered: registered,
            dob: dob,
            location: location,
          );
        }).toList();

    return transformation;
  }
}
