enum BookAttribute { name, author, price, desc, imgUrl }

class BookModel {
  String name;
  String desc;
  String imgUrl;
  String author;
  String price;

  BookModel({
    required this.name,
    required this.desc,
    required this.imgUrl,
    required this.author,
    required this.price,
  });

  toMap() {
    return {
      "name": name,
      "desc": desc,
      "imgUrl": imgUrl,
      "author": author,
      "price": price,
    };
  }

  BookModel.fromJson(Map<BookAttribute, dynamic> json)
      : name = json[BookAttribute.name]!,
        author = json[BookAttribute.author]!,
        imgUrl = json[BookAttribute.imgUrl]!,
        price = json[BookAttribute.price]!,
        desc = json[BookAttribute.desc]!;
}
