import 'package:api_calls/models/user_dob.dart';
import 'package:api_calls/models/user_location.dart';
import 'package:api_calls/models/user_name.dart';
import 'package:api_calls/models/user_reg.dart';

class Users {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final UserName fullName;
  final DateOfBirth dob;
  final RegDate registered;
  final Location location;
  Users({
    required this.email,
    required this.cell,
    required this.gender,
    required this.nat,
    required this.phone,
    required this.fullName,
    required this.registered,
    required this.dob,
    required this.location,
  });
}
