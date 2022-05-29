//login models

class Customer {
  String id;
  String name;
  int numberOfNotification;
  Customer(this.id, this.name, this.numberOfNotification);
}

class Contact {
  String phone;
  String email;
  String link;
  Contact(this.email, this.link, this.phone);
}

class Authentiacation {
  Customer? customer;
  Contact? contact;
  Authentiacation(this.contact, this.customer);
}
