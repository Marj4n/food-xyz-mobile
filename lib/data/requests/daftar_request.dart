class DaftarRequest {
  final String username;
  final String password;
  final String nama;
  final String alamat;
  final String telpon;

  DaftarRequest({
    required this.username,
    required this.password,
    required this.nama,
    required this.alamat,
    required this.telpon,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "nama": nama,
      "alamat": alamat,
      "telpon": telpon,
    };
  }
}
