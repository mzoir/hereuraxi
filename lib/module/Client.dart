class Client {
  int clientId;
  String name;
  String location;

  Client({required this.clientId, required this.name, required this.location});

  void requestRide(String destination) {
    print('$name has requested a ride to $destination from $location.');
  }

  @override
  String toString() {
    return 'Client $name, Location: $location';
  }
}