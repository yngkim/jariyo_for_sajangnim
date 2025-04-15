import 'package:flutter/material.dart';

class SeatState extends ChangeNotifier {
  List<bool> selectedSeats = List<bool>.filled(81, false);
  List<String?> seatNumbers = List<String?>.filled(81, null);
  List<bool> redSeats = List<bool>.filled(81, false);
  List<bool> blueSeats = List<bool>.filled(81, false); // 파란색 상태 관리 리스트

  void updateSeat(int index, bool isSelected, String? seatNumber) {
    selectedSeats[index] = isSelected;
    seatNumbers[index] = seatNumber;
    notifyListeners();
  }

  void loadState(List<bool> newSelectedSeats, List<String?> newSeatNumbers) {
    selectedSeats = newSelectedSeats;
    seatNumbers = newSeatNumbers;
    notifyListeners();
  }

  void toggleSeat(int index) {
    selectedSeats[index] = !selectedSeats[index];
    redSeats[index] = false; // 초기화
    notifyListeners();
  }

  void toggleRedSeat(int index) {
    redSeats[index] = !redSeats[index];
    notifyListeners();
  }

  void toggleBlueSeat(int index) {
    blueSeats[index] = !blueSeats[index];
    notifyListeners();
  }
}
