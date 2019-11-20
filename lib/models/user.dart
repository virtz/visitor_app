class User {
   final String status;
  final String id;
  final String name;
  final String email;
  final String isAdmin;
 
 

User({this.id,this.name,this.email,this.isAdmin,this.status});

   factory User.fromJson(Map<String,dynamic>json){
     return new User(
        status: json['status'],
       id:json['id'],
       name:json['name'],
       email: json['email'],
       isAdmin: json['isAdmin'],
      
     
     );
   }   
}