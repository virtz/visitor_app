class Visitor {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String purpose;
  final String who;
  final String status;

  Visitor(
      {this.id, this.name, this.address, this.phone, this.purpose, this.who,this.status});

   factory Visitor.fromJson(Map<String,dynamic>json){
     return new Visitor(
       id:json['_id'],
       name:json['name'],
       address: json['address'],
       phone: json['phone'],
       purpose: json['purpose'],
       who:json['who'],
       status: json['status']
     );
   }   
}
