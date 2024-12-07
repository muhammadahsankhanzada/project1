import 'package:project1/Utils/image_urls.dart';

class ManagerHomepageItems {
  final String title;
  final String image;
  ManagerHomepageItems({
    required this.title,
    required this.image,
  });
}

List<ManagerHomepageItems> managerHomepageContents = [
  ManagerHomepageItems(
      title: 'Pending Requests', image: ImageUrls.pendingRequests),
  ManagerHomepageItems(
      title: 'Approved Requests', image: ImageUrls.approvedRequests),
  ManagerHomepageItems(title: 'Add Products', image: ImageUrls.addProducts),
  ManagerHomepageItems(
      title: 'Delete Products', image: ImageUrls.deleteProducts),
  ManagerHomepageItems(
      title: 'Available Products', image: ImageUrls.availableProducts),
  ManagerHomepageItems(
      title: 'Salesman Records', image: ImageUrls.driverRecords),
  ManagerHomepageItems(
      title: 'Product Collection', image: ImageUrls.driverRecords),
];
