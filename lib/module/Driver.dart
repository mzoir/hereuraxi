class Driver {
  int driverId;
  String name;
  String vehicle;
  bool available;
  double  rating ;

  Driver({required this.driverId, required this.name, required this.vehicle,required this.rating})
      : available = true;

  void startRide(String destination) {
    if (available) {
      print('$name is starting a ride to $destination.');
      available = false;
    } else {
      print('$name is currently unavailable.');
    }
  }

  void endRide() {
    if (!available) {
      print('$name has ended the ride.');
      available = true;
    } else {
      print('$name is already available.');
    }
  }

  @override
  String toString() {
    return 'Driver $name, Vehicle: $vehicle';
  }
}