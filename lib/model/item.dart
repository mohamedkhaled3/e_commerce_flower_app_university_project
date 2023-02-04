// Item is product 
class Item {
  String imgPath;
  double price;
  String location;

  Item({
    required this.imgPath,
    required this.price,
    this.location = "main branch", // 

  });
}

final List<Item> items = [
  Item(imgPath: "assets/img/1.webp", price: 12.99, location: "fayoum"),
  Item(imgPath: "assets/img/2.webp", price: 13.99),
  Item(imgPath: "assets/img/3.webp", price: 14.99),
  Item(imgPath: "assets/img/4.webp", price: 15.99),
  Item(imgPath: "assets/img/5.webp", price: 16.99),
  Item(imgPath: "assets/img/6.webp", price: 17.99),
  Item(imgPath: "assets/img/7.webp", price: 18.99),
  Item(imgPath: "assets/img/8.webp", price: 19.99),
];
