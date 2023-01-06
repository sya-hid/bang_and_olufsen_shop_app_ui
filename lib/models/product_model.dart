class ProductModel {
  final String name;
  final double price;
  final List<String> images;
  ProductModel({
    required this.name,
    required this.price,
    required this.images,
  });
}

List<ProductModel> products = [
  ProductModel(name: 'Beosound A1 2nd Gen', price: 330.33, images: [
    'beosound a1/a1_2nd_gen_1.png',
    'beosound a1/a1_2nd_gen_2.png',
  ]),
  ProductModel(name: 'Beoplay H95', price: 1054.44, images: [
    'beoplay h95/h95_1.png',
    'beoplay h95/h95_2.png',
    'beoplay h95/h95_3.png',
    'beoplay h95/h95_4.png',
    'beoplay h95/h95_5.png',
    'beoplay h95/h95_6.png',
  ]),
  ProductModel(name: 'Beoplay E8 2.0', price: 225.00, images: [
    'beoplay e8/e8_1.png',
    'beoplay e8/e8_2.png',
    'beoplay e8/e8_3.png',
    'beoplay e8/e8_4.png',
    'beoplay e8/e8_5.png',
  ]),
  ProductModel(name: 'Beoplay A9 4th Gen', price: 3447.46, images: [
    'beoplay a9/a9_1.png',
    'beoplay a9/a9_2.png',
    'beoplay a9/a9_3.png',
  ]),
  ProductModel(name: 'Beoplay Portal', price: 551.01, images: [
    'beoplay portal/portal_1.png',
    'beoplay portal/portal_2.png',
    'beoplay portal/portal_3.png',
  ]),
];
