class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl

  });
}
final List<Product> sampleProducts = [
  Product(
    id: "1",
    name: "Yamaha R1",
    description: "High-performance sport motorcycle with advanced aerodynamics.",
    price: 20000,
    imageUrl: 'https://www.roadracingworld.com/wp-content/uploads/2024/09/2025-Yamaha-YZF1000R1COMP-EU-Tech_Black-Static-001-03_1726681296-1536x864.jpg',
  ),
  Product(
    id: '2',
    name: 'Kawasaki Ninja ZX-6R',
    description: 'Lightweight supersport bike built for speed and control.',
    price: 12000,
    imageUrl: 'https://www.peeramotosports.co.th/wp-content/uploads/2024/09/gallery-full-02-1599x1066.jpg',
  ),
  Product(
    id: '3',
    name: 'Ducati Panigale V4',
    description: 'Premium Italian superbike with powerful V4 engine.',
    price: 28000,
    imageUrl: 'https://i.bstr.es/highmotor/2024/07/Ducati-Panigale-V2-Superquadro-Final-Edition-7-1220x813.jpg',
  ),
  Product(
    id: '4',
    name: 'BMW S1000RR',
    description: 'Cutting-edge superbike with race-level performance.',
    price: 22000,
    imageUrl: 'https://puromotor.com/wp-content/uploads/2022/09/P90480032_highRes_the-new-bmw-s-1000-r.jpg',
  ),
];