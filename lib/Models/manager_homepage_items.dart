import 'package:project1/Utils/constants.dart';

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
      title: 'Pending Requests', image: Constants.pendingRequests),
  ManagerHomepageItems(
      title: 'Approved Requests', image: Constants.approvedRequests),
  ManagerHomepageItems(title: 'Add Products', image: Constants.addProducts),
  ManagerHomepageItems(
      title: 'Delete Products', image: Constants.deleteProducts),
  ManagerHomepageItems(
      title: 'Available Products', image: Constants.availableProducts),
  ManagerHomepageItems(title: 'Driver Records', image: Constants.driverRecords),
];
