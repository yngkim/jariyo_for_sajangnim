import 'package:flutter/material.dart';

class SeatManagementState extends ChangeNotifier {
  List<List<bool>> seatStates =
      List.generate(9, (index) => List.generate(9, (index) => false));
  String reservationTime = '';
  bool isOperating = false;
  bool isReservationAllowed = false;

  void updateSeatState(int row, int col) {
    seatStates[row][col] = !seatStates[row][col];
    notifyListeners();
  }

  void updateOperatingStatus(bool value) {
    isOperating = value;
    notifyListeners();
  }

  void updateReservationStatus(bool value) {
    isReservationAllowed = value;
    notifyListeners();
  }

  void updateReservationTime(String value) {
    reservationTime = value;
    notifyListeners();
  }
}
