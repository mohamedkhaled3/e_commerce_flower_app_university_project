// Item is product 
class Item {
  String imgPath;
  String name;
  double price;
  String location;


  Item({
    required this.imgPath,
    required this.name,
    required this.price,
    this.location = "main branch", // 

  });
}

final List<Item> items = [
  Item(name:"product1" ,imgPath: "assets/img/1.webp", price: 12.99, location: "fayoum"),
  Item(name:"product2" ,imgPath: "assets/img/2.webp", price: 13.99),
  Item(name:"product3" ,imgPath: "assets/img/3.webp", price: 14.99),
  Item(name:"product4" ,imgPath: "assets/img/4.webp", price: 15.99),
  Item(name:"product5" ,imgPath: "assets/img/5.webp", price: 16.99),
  Item(name:"product6" ,imgPath: "assets/img/6.webp", price: 17.99),
  Item(name:"product7" ,imgPath: "assets/img/7.webp", price: 18.99),
  Item(name:"product8" ,imgPath: "assets/img/8.webp", price: 19.99),
];
