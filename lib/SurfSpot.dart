//This class define the SurfSpot objects for later
class SurfSpot {
  String? name;
  String? url;
  String? address;

  SurfSpot(this.name, this.url, this.address);

  SurfSpot.fromJson(Map<String, dynamic> json) {
    name = json["Surf Break"];
    url = json["Photos"];
    address = json["Address"];
  }

  get imageURL => null;

  // @override
  // String toString() {
  //   return '{ ${this.name}, ${this.url}, ${this.address} }';
  // }
}
