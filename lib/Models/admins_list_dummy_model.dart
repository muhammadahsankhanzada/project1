class AdminListModel {
  final String name;
  final String address;

  AdminListModel({required this.name, required this.address});
}

List<AdminListModel> adminsListContents = [
  AdminListModel(name: 'Michael Adams', address: '234 Elm St, Springfield'),
  AdminListModel(name: 'Sarah Connor', address: '567 Maple Ave, Hilltop'),
  AdminListModel(name: 'David Banner', address: '890 Oak Rd, Rivertown'),
  AdminListModel(name: 'Emily Clark', address: '123 Pine Ln, Lakeside'),
  AdminListModel(name: 'James Bond', address: '456 Cedar Blvd, Oceanview'),
  AdminListModel(
      name: 'Natalie Portman', address: '789 Birch St, Mountainview'),
  AdminListModel(name: 'Tony Stark', address: '101 Walnut Way, Forest City'),
];
