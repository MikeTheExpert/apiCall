import 'dart:convert';

import 'package:api_calls/models/user_dob.dart';
import 'package:api_calls/models/user_img.dart';
import 'package:api_calls/models/user_location.dart';
import 'package:api_calls/models/user_reg.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import '../models/user_name.dart';

class ApiCall {
  Future<List<Users>> fetchUsers({int numOfUsers = 20}) async {
    final uri = 'https://randomuser.me/api/?results=$numOfUsers';
    final url = Uri.parse(uri);

    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception('Failed to load users: ${response.statusCode}');
      }

      final json = jsonDecode(response.body);
      final result = json['results'] as List<dynamic>;

      final users =
          result.map((e) {
            final name = UserName(
              title: e['name']['title'],
              first: e['name']['first'],
              last: e['name']['last'],
            );

            final picture = UserImg(
              thumbnail: e["picture"]["thumbnail"],
              medium: e['picture']['medium'],
            );

            final street = StreetLocation(
              number: e['location']['street']['number'],
              name: e['location']['street']['name'],
            );

            final timezone = LocationTimezone(
              offset: e['location']['timezone']['offset'],
              description: e['location']['timezone']['description'],
            );

            final location = Location(
              city: e['location']['city'],
              state: e['location']['state'],
              country: e['location']['country'],
              postcode: e['location']['postcode'],
              streetLocation: street,
              timezone: timezone,
            );

            final registered = RegDate(
              age: e['registered']['age'],
              date: e['registered']['date'],
            );

            final dob = DateOfBirth(
              age: e['dob']['age'],
              date: e['dob']['date'],
            );

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
              picture: picture,
            );
          }).toList();

      return users;
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }
}
