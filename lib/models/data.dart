//  "nama": "nama123",
//     "detail": "ini detial",
//     "gambar": "https://images.unsplash.com/photo-1668365187350-05c997d09eba?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
class Data {
  String nama;
  String detail;
  String gambar;

  Data({required this.nama, required this.detail, required this.gambar});

  factory Data.fromJson(Map map) {
    return Data(
        nama: map['nama'], detail: map['detail'], gambar: map['gambar']);
  }
}
