import 'Donation.dart';
import 'Financial.dart';

abstract class User {
  final int _id;
  String _name;
  String _phone;
  String _email;
  String _password;

  User(this._id, this._name, this._phone, this._email, this._password);

//User Setters
  void setName(String name) { 
    _name = name;
   }
  void setPhone(String phone) { 
    _phone = phone;
   }
  void setEmail(String email) {
    _email = email;
  }
  void setPassword(String password) { 
    //Edit this to enable encryption
    _password = password;
   }

//User Getters
  String getName() { 
    return _name; }
  String getPhone() {  
    return _phone; }
  String getEmail() {  
    return _email; }
  int getID() { 
    return _id; }
  bool authenticate(String password, String email) { 
    if (password==_password && email==_email){
      return true; 
    }
    return false;
    }
  List<Donation> getDonations();
  List<Financial> getFinancials();
}
