// class Seller {
//   String? companyName;
//   String? name;
//   String? email;
//   int? phone;
//   String? pass;

//   Seller(
//       {this.name = '',
//       this.email = '',
//       this.pass = '',
//       this.companyName = '',
//       this.phone = 0});

//   String getCompanyName() {
//     return companyName ?? '';
//   }

//   int getPhone() {
//     return phone ?? 0;
//   }

//   String getname() {
//     return name ?? '';
//   }

//   String getemail() {
//     return email ?? '';
//   }

//   String getPass() {
//     return pass ?? '';
//   }

//   factory Seller.fromJson(Map<String, String> json) {
//     return Seller(
//         name: json['name'],
//         email: json['email'] as String,
//         pass: json['pass'],
//         companyName: json['companyName'],
//         phone: json['phone'] as int);
//   }
// }
