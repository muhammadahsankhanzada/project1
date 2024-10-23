class ProductCategory {
  final String name;
  final String imageUrl;
  final List<Product> products;

  ProductCategory({
    required this.name,
    required this.imageUrl,
    required this.products,
  });
}

class Product {
  final String name;
  final String imageUrl;
  int quantity;
  final double price;

  Product({
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });
}

List<ProductCategory> productCategoriesDummyModelContents = [
  ProductCategory(
    name: 'Electronics',
    imageUrl:
        'https://th.bing.com/th?id=OIP.g2ejcBJqMzaxfzuGXfdsVQHaFj&w=288&h=216&c=8&rs=1&qlt=90&r=0&o=6&dpr=1.3&pid=3.1&rm=2',
    products: [
      Product(
        name: 'Smartphone',
        imageUrl: 'https://example.com/smartphone.jpg',
        quantity: 0,
        price: 30000,
      ),
      Product(
        name: 'Laptop',
        imageUrl: 'https://example.com/laptop.jpg',
        quantity: 0,
        price: 80000,
      ),
      Product(
        name: 'Headphones',
        imageUrl: 'https://example.com/headphones.jpg',
        quantity: 0,
        price: 200,
      ),
    ],
  ),
  ProductCategory(
    name: 'Home Appliances',
    imageUrl:
        'https://th.bing.com/th?id=OIP.R6B-rcBUyJs9wg-s1B8dIgHaFj&w=288&h=216&c=8&rs=1&qlt=90&r=0&o=6&dpr=1.3&pid=3.1&rm=2',
    products: [
      Product(
        name: 'Microwave',
        imageUrl: 'https://example.com/microwave.jpg',
        quantity: 0,
        price: 10000,
      ),
      Product(
        name: 'Refrigerator',
        imageUrl: 'https://example.com/refrigerator.jpg',
        quantity: 0,
        price: 40000,
      ),
      Product(
        name: 'Washing Machine',
        imageUrl: 'https://example.com/washing_machine.jpg',
        quantity: 0,
        price: 25000,
      ),
    ],
  ),
  ProductCategory(
    name: 'Fashion',
    imageUrl:
        'https://th.bing.com/th/id/OIP.ORH_mwC_R1rP2xGViNy_lwHaE8?w=225&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    products: [
      Product(
        name: 'T-Shirt',
        imageUrl: 'https://example.com/tshirt.jpg',
        quantity: 0,
        price: 300,
      ),
      Product(
        name: 'Jeans',
        imageUrl: 'https://example.com/jeans.jpg',
        quantity: 0,
        price: 900,
      ),
      Product(
        name: 'Sneakers',
        imageUrl: 'https://example.com/sneakers.jpg',
        quantity: 0,
        price: 3000,
      ),
    ],
  ),
  ProductCategory(
    name: 'Health & Beauty',
    imageUrl:
        'https://th.bing.com/th?id=OIP.FbkPPMz1KzcjU1nj38ASHwHaE8&w=306&h=204&c=8&rs=1&qlt=90&r=0&o=6&dpr=1.3&pid=3.1&rm=2',
    products: [
      Product(
        name: 'Face Cream',
        imageUrl: 'https://example.com/face_cream.jpg',
        quantity: 0,
        price: 800,
      ),
      Product(
        name: 'Shampoo',
        imageUrl: 'https://example.com/shampoo.jpg',
        quantity: 0,
        price: 300,
      ),
      Product(
        name: 'Perfume',
        imageUrl: 'https://example.com/perfume.jpg',
        quantity: 0,
        price: 1000,
      ),
    ],
  ),
  ProductCategory(
    name: 'Sports & Outdoors',
    imageUrl:
        'https://th.bing.com/th?id=OIP.4SzmtvaKfnFSUgNggpHjdAHaD4&w=345&h=181&c=8&rs=1&qlt=90&r=0&o=6&dpr=1.3&pid=3.1&rm=2',
    products: [
      Product(
        name: 'Tennis Racket',
        imageUrl: 'https://example.com/tennis_racket.jpg',
        quantity: 0,
        price: 900,
      ),
      Product(
        name: 'Football',
        imageUrl: 'https://example.com/football.jpg',
        quantity: 0,
        price: 800,
      ),
      Product(
        name: 'Yoga Mat',
        imageUrl: 'https://example.com/yoga_mat.jpg',
        quantity: 0,
        price: 300,
      ),
    ],
  ),
  ProductCategory(
    name: 'Toys & Games',
    imageUrl:
        'https://th.bing.com/th?id=OIP.z2ml1WSWIQMWG0AGgkLiUgHaE8&w=305&h=204&c=8&rs=1&qlt=90&r=0&o=6&dpr=1.3&pid=3.1&rm=2',
    products: [
      Product(
        name: 'Action Figure',
        imageUrl: 'https://example.com/action_figure.jpg',
        quantity: 0,
        price: 3000,
      ),
      Product(
        name: 'Puzzle',
        imageUrl: 'https://example.com/puzzle.jpg',
        quantity: 0,
        price: 200,
      ),
      Product(
        name: 'Board Game',
        imageUrl: 'https://example.com/board_game.jpg',
        quantity: 0,
        price: 500,
      ),
    ],
  ),
  ProductCategory(
    name: 'Automotive',
    imageUrl:
        'https://th.bing.com/th?id=OIP.oj71K58ycqUwDzhd0htVTAHaE8&w=305&h=204&c=8&rs=1&qlt=90&r=0&o=6&dpr=1.3&pid=3.1&rm=2',
    products: [
      Product(
        name: 'Car Wax',
        imageUrl: 'https://example.com/car_wax.jpg',
        quantity: 0,
        price: 1000,
      ),
      Product(
        name: 'Tire Inflator',
        imageUrl: 'https://example.com/tire_inflator.jpg',
        quantity: 0,
        price: 3000,
      ),
      Product(
        name: 'Car Seat Cover',
        imageUrl: 'https://example.com/car_seat_cover.jpg',
        quantity: 0,
        price: 2000,
      ),
    ],
  ),
  ProductCategory(
    name: 'Books',
    imageUrl:
        'https://th.bing.com/th/id/OIP.K0-6kdzB4K1dH6p0oBdUBAHaEo?w=303&h=189&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    products: [
      Product(
        name: 'Fiction Novel',
        imageUrl: 'https://example.com/fiction_novel.jpg',
        quantity: 0,
        price: 200,
      ),
      Product(
        name: 'Cookbook',
        imageUrl: 'https://example.com/cookbook.jpg',
        quantity: 0,
        price: 100,
      ),
      Product(
        name: 'Science Book',
        imageUrl: 'https://example.com/science_book.jpg',
        quantity: 0,
        price: 500,
      ),
    ],
  ),
  ProductCategory(
    name: 'Home & Garden',
    imageUrl:
        'https://th.bing.com/th/id/OIP.oMVW7qSS5Grq6dW__k8LrgHaDP?w=347&h=153&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    products: [
      Product(
        name: 'Plant Pot',
        imageUrl: 'https://example.com/plant_pot.jpg',
        quantity: 0,
        price: 500,
      ),
      Product(
        name: 'Garden Tools',
        imageUrl: 'https://example.com/garden_tools.jpg',
        quantity: 0,
        price: 5000,
      ),
      Product(
        name: 'Outdoor Furniture',
        imageUrl: 'https://example.com/outdoor_furniture.jpg',
        quantity: 0,
        price: 70000,
      ),
    ],
  ),
  ProductCategory(
    name: 'Grocery',
    imageUrl:
        'https://th.bing.com/th/id/OIP.EngSBRxdHEkz_layq222YwHaHa?w=265&h=199&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    products: [
      Product(
        name: 'Organic Apples',
        imageUrl: 'https://example.com/organic_apples.jpg',
        quantity: 0,
        price: 300,
      ),
      Product(
        name: 'Whole Wheat Bread',
        imageUrl: 'https://example.com/whole_wheat_bread.jpg',
        quantity: 0,
        price: 200,
      ),
      Product(
        name: 'Milk',
        imageUrl: 'https://example.com/milk.jpg',
        quantity: 0,
        price: 200,
      ),
    ],
  ),
];
