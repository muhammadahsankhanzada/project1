class Warehouse {
  final String name;
  final String address;
  final String imageUrl;

  Warehouse({
    required this.name,
    required this.address,
    required this.imageUrl,
  });
}

List<Warehouse> warehousesDummyListContents = [
  Warehouse(
    name: "Alpha Warehouse",
    address: "1234 Alpha St, Cityville, CA 90210",
    imageUrl:
        'https://th.bing.com/th?id=OIP.lhdnUBYMUdKNOVNO7YXMTgHaEK&w=333&h=187&c=8&rs=1&qlt=90&r=0&o=6&dpr=1.3&pid=3.1&rm=2',
  ),
  Warehouse(
    name: "Bravo Warehouse",
    address: "5678 Bravo Ave, Townsville, TX 75001",
    imageUrl:
        'https://th.bing.com/th?id=OIP.lhdnUBYMUdKNOVNO7YXMTgHaEK&w=333&h=187&c=8&rs=1&qlt=90&r=0&o=6&dpr=1.3&pid=3.1&rm=2',
  ),
  Warehouse(
    name: "Charlie Warehouse",
    address: "9101 Charlie Blvd, Villagetown, NY 10001",
    imageUrl:
        'https://th.bing.com/th?id=OIP.lhdnUBYMUdKNOVNO7YXMTgHaEK&w=333&h=187&c=8&rs=1&qlt=90&r=0&o=6&dpr=1.3&pid=3.1&rm=2',
  ),
  Warehouse(
    name: "Delta Warehouse",
    address: "1213 Delta Rd, Metropolis, IL 60601",
    imageUrl:
        'https://th.bing.com/th?id=OIP.lhdnUBYMUdKNOVNO7YXMTgHaEK&w=333&h=187&c=8&rs=1&qlt=90&r=0&o=6&dpr=1.3&pid=3.1&rm=2',
  ),
  Warehouse(
    name: "Echo Warehouse",
    address: "1415 Echo St, Hamptontown, FL 33101",
    imageUrl:
        'https://th.bing.com/th?id=OIP.lhdnUBYMUdKNOVNO7YXMTgHaEK&w=333&h=187&c=8&rs=1&qlt=90&r=0&o=6&dpr=1.3&pid=3.1&rm=2',
  ),
];
