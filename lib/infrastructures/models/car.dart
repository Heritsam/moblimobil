class Car {
  final int id;
  final String imageUrl;
  final String title;
  final String brand;
  final int price;
  final String fuelType;
  final String color;
  final int? originalPrice;

  const Car({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.brand,
    required this.price,
    required this.fuelType,
    required this.color,
    this.originalPrice,
  });
}

final carList = <Car>[
  Car(
    id: 1,
    title: 'MINI Cooper S',
    brand: 'MINI',
    price: 1250000,
    originalPrice: 1251000,
    fuelType: 'Gas',
    color: 'White',
    imageUrl:
        'https://images.unsplash.com/photo-1574438085144-72418a474aa9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
  ),
  Car(
    id: 2,
    title: 'Tesla Model S',
    brand: 'Tesla',
    price: 1250000,
    originalPrice: 1350000,
    fuelType: 'Electric',
    color: 'White',
    imageUrl:
        'https://images.unsplash.com/photo-1453491945771-a1e904948959?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
  ),
  Car(
    id: 3,
    title: 'Toyota Supra',
    brand: 'Toyota',
    price: 650000000,
    originalPrice: 750000000,
    fuelType: 'Gas',
    color: 'Black',
    imageUrl:
        'https://images.unsplash.com/photo-1607603750909-408e193868c7?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
  ),
  Car(
    id: 4,
    title: 'Honda Civic Type R',
    brand: 'Honda',
    price: 250000000,
    originalPrice: 225000000,
    fuelType: 'Gas',
    color: 'Red',
    imageUrl:
        'https://images.unsplash.com/photo-1570303278489-041bd897a873?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=80',
  ),
  Car(
    id: 5,
    title: 'Mazda RX-8',
    brand: 'Mazda',
    price: 750000000,
    fuelType: 'Gas',
    color: 'Grey',
    imageUrl:
        'https://images.unsplash.com/photo-1581182579913-764d707f478f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
  ),
  Car(
    id: 6,
    title: 'Porche 911',
    brand: 'Porche',
    price: 1250000000,
    fuelType: 'Gas',
    color: 'White',
    imageUrl:
        'https://images.unsplash.com/photo-1594502184342-2e12f877aa73?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
  ),
];
