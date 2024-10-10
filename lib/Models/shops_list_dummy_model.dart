import 'package:project1/Utils/constants.dart';

class ShopDummyDetails {
  final String name;
  final String address;
  final String imageUrl;

  ShopDummyDetails({
    required this.name,
    required this.address,
    required this.imageUrl,
  });
}

List<ShopDummyDetails> shopsListContents = [
  ShopDummyDetails(
    name: 'The Coffee House',
    address: '123 Brew Lane, Coffee City',
    imageUrl: Constants.myImage,
  ),
  ShopDummyDetails(
    name: 'The Book Nook',
    address: '456 Read St, Booktown',
    imageUrl: Constants.myImage,
  ),
  ShopDummyDetails(
    name: 'Gadget Galaxy',
    address: '789 Tech Ave, Gadget City',
    imageUrl: Constants.myImage,
  ),
  ShopDummyDetails(
    name: 'Fresh Produce Market',
    address: '321 Green Way, Farmtown',
    imageUrl: Constants.myImage,
  ),
  ShopDummyDetails(
    name: 'Fashion Forward',
    address: '654 Style St, Trendy Town',
    imageUrl: Constants.myImage,
  ),
  ShopDummyDetails(
    name: 'Fashion Fiesta',
    address: '101 Style Blvd, Trendy City',
    imageUrl: Constants.myImage,
  ),
  ShopDummyDetails(
    name: 'Gourmet Grocers',
    address: '202 Fresh Ave, Foodie Town',
    imageUrl: Constants.myImage,
  ),
];
