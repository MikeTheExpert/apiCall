class Location {
  final String city;
  final String state;
  final String country;
  final String postcode;
  final StreetLocation streetLocation;
  final LocationTimezone timezone;

  Location({
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.streetLocation,
    required this.timezone,
  });

}

class LocationTimezone {
  final String offset;
  final String description;

  LocationTimezone({
    required this.offset,
    required this. description,
});
}

class StreetLocation {
  final String number;
  final String name;

  StreetLocation({required this.number, required this.name});
}
