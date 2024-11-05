import 'package:project1/Utils/image_urls.dart';

class ShopListModel {
  final String name;
  final String address;
  final String imageUrl;

  ShopListModel({
    required this.name,
    required this.address,
    required this.imageUrl,
  });
}

List<ShopListModel> shopsListContents = [
  ShopListModel(
    name: 'The Coffee House',
    address: '123 Brew Lane, Coffee City',
    imageUrl: ImageUrls.myImage,
  ),
  ShopListModel(
    name: 'The Book Nook',
    address: '456 Read St, Booktown',
    imageUrl: ImageUrls.myImage,
  ),
  ShopListModel(
    name: 'Gadget Galaxy',
    address: '789 Tech Ave, Gadget City',
    imageUrl: ImageUrls.myImage,
  ),
  ShopListModel(
    name: 'Fresh Produce Market',
    address: '321 Green Way, Farmtown',
    imageUrl: ImageUrls.myImage,
  ),
  ShopListModel(
    name: 'Fashion Forward',
    address: '654 Style St, Trendy Town',
    imageUrl: ImageUrls.myImage,
  ),
  ShopListModel(
    name: 'Fashion Fiesta',
    address: '101 Style Blvd, Trendy City',
    imageUrl: ImageUrls.myImage,
  ),
  ShopListModel(
    name: 'Gourmet Grocers',
    address: '202 Fresh Ave, Foodie Town',
    imageUrl: ImageUrls.myImage,
  ),
];
