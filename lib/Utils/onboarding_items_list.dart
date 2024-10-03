class OnboardingItemsList {
  final title;
  final subtitle;
  final image;

  OnboardingItemsList({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

final List<OnboardingItemsList> onboardingItemsListContent = [
  OnboardingItemsList(
      title: 'Welcome to [App Name]!',
      subtitle:
          'Join us in revolutionizing the way food products are delivered. Connect with local shops and streamline deliveries, ensuring freshness and quality every time.',
      image: 'assets/images/R.png'),
  OnboardingItemsList(
      title: 'Easy Driver Management',
      subtitle:
          'Our app empowers drivers to effortlessly pick up products from warehouses and deliver them to shops. Track routes in real-time and optimize your deliveries with just a few taps!',
      image: 'assets/images/R.png'),
  OnboardingItemsList(
      title: 'Efficient Shop Coordination',
      subtitle:
          'Managers can oversee inventory, track deliveries, and manage drivers all in one place. Stay organized and ensure your shops are always stocked with the best products.',
      image: 'assets/images/R.png'),
];
