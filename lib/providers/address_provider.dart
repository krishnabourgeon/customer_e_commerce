import 'package:customer_e_commerce/service/location_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/address.dart';
import '../dummy_data/dummy_user.dart';

enum LocationFetchState { idle, loading, success, error }

class AddressProvider extends ChangeNotifier {
  List<Address> _addresses = List.from(dummyAddresses);
  int _selectedIndex = 0;
  LocationFetchState _fetchState = LocationFetchState.idle;
  String _fetchError = '';

  List<Address> get addresses => _addresses;
  Address get selectedAddress => _addresses[_selectedIndex];
  int get selectedIndex => _selectedIndex;
  LocationFetchState get fetchState => _fetchState;
  String get fetchError => _fetchError;
  bool get isFetching => _fetchState == LocationFetchState.loading;

  void selectAddress(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void addAddress(Address address) {
    _addresses.add(address);
    _selectedIndex = _addresses.length - 1;
    notifyListeners();
  }

  void removeAddress(int index) {
    if (_addresses.length <= 1) return;
    _addresses.removeAt(index);
    if (_selectedIndex >= _addresses.length) {
      _selectedIndex = _addresses.length - 1;
    }
    notifyListeners();
  }

  /// Detects GPS location → reverse geocodes → inserts as "Current Location"
  /// at top of list and auto-selects it.
  Future<void> useCurrentLocation() async {
    _fetchState = LocationFetchState.loading;
    _fetchError = '';
    notifyListeners();

    try {
      final Position pos = await LocationService.getCurrentPosition();
      final String addressStr = await LocationService.getAddressFromCoordinates(
        pos.latitude, pos.longitude,
      );

      _addresses.removeWhere((a) => a.id == 'addr_current');

      _addresses.insert(0, Address(
        id: 'addr_current',
        label: 'Current Location',
        fullAddress: addressStr,
        latitude: pos.latitude,
        longitude: pos.longitude,
      ));
      _selectedIndex = 0;
      _fetchState = LocationFetchState.success;
    } catch (e) {
      _fetchState = LocationFetchState.error;
      _fetchError = e.toString();
    }

    notifyListeners();
  }
}