/// Represents the logged-in customer's profile (dummy/local only).
class AppUser {
  final String name;
  final String email;
  final String phone;
  final String imageUrl;

  const AppUser({
    required this.name,
    required this.email,
    required this.phone,
    this.imageUrl = '',
  });
}
