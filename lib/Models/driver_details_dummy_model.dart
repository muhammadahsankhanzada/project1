class Driver {
  final String cnic;
  final String phoneNumber;
  final String email;
  final int deliveries;
  final String vehicleType;
  final String vehicleNumber;
  final String description;

  Driver({
    required this.cnic,
    required this.phoneNumber,
    required this.email,
    required this.deliveries,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.description,
  });
}

List<Driver> dummyDrivers = [
  Driver(
    cnic: '12345-1234567-1',
    phoneNumber: '0300-1234567',
    email: 'driver1@example.com',
    deliveries: 15,
    vehicleType: 'Van',
    vehicleNumber: 'ABC-123',
    description:
        'Responsible for delivering products from warehouse to shops daily.',
  ),
  Driver(
    cnic: '23456-2345678-2',
    phoneNumber: '0300-2345678',
    email: 'driver2@example.com',
    deliveries: 20,
    vehicleType: 'Truck',
    vehicleNumber: 'XYZ-456',
    description: 'Handles bulk deliveries for various retail outlets.',
  ),
  Driver(
    cnic: '34567-3456789-3',
    phoneNumber: '0300-3456789',
    email: 'driver3@example.com',
    deliveries: 18,
    vehicleType: 'Bike',
    vehicleNumber: 'LMN-789',
    description: 'Delivers smaller packages to local shops efficiently.',
  ),
  Driver(
    cnic: '45678-4567890-4',
    phoneNumber: '0300-4567890',
    email: 'driver4@example.com',
    deliveries: 22,
    vehicleType: 'Pickup',
    vehicleNumber: 'QWE-101',
    description: 'Specializes in time-sensitive deliveries to major clients.',
  ),
  Driver(
    cnic: '56789-5678901-5',
    phoneNumber: '0300-5678901',
    email: 'driver5@example.com',
    deliveries: 10,
    vehicleType: 'Van',
    vehicleNumber: 'RTY-202',
    description: 'Ensures safe and timely delivery of products to shops.',
  ),
];
