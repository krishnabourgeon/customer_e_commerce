
import 'package:customer_e_commerce/models/address.dart';
import 'package:customer_e_commerce/models/user.dart';

final AppUser dummyUser = const AppUser(
  name: 'Aditya Menon',
  email: 'aditya.menon@example.com',
  phone: '+91 98765 43210',
  imageUrl: 'https://i.pravatar.cc/300?img=12',
);

final List<Address> dummyAddresses = [
  const Address(
    id: 'addr_1',
    label: 'Home',
    fullAddress: 'Door No. 24, Lake View Apartments, Kakkanad, Kochi - 682030',
    isDefault: true,
    latitude: 10.0159,
    longitude: 76.3419,
  ),
  const Address(
    id: 'addr_2',
    label: 'Work',
    fullAddress: 'Office 3B, Tech Park, Infopark Road, Kochi - 682042',
    latitude: 10.0261,
    longitude: 76.3509,
  ),
];