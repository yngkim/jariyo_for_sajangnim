import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'seat_state.dart';
import 'dart:async';

class SeatManage extends StatefulWidget {
  const SeatManage({super.key});

  @override
  _SeatManageState createState() => _SeatManageState();
}

class _SeatManageState extends State<SeatManage> {
  Timer? _timer;
  Duration _duration = const Duration(minutes: 4, seconds: 30);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.inSeconds > 0) {
        setState(() {
          _duration = _duration - const Duration(seconds: 1);
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Consumer<SeatState>(
            builder: (context, seatState, child) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 9),
                itemCount: 81,
                itemBuilder: (context, index) {
                  int row = index ~/ 9;
                  int col = index % 9;

                  bool isSelected = seatState.selectedSeats[index];
                  bool isRed = seatState.redSeats[index];
                  bool isBlue = seatState.blueSeats[index];

                  Color boxColor;
                  if (row == 4 && col == 2) {
                    boxColor = isBlue ? Colors.red : Colors.blue; // 파란색과 빨간색 토글
                  } else if (isSelected) {
                    boxColor = isRed ? Colors.red : Colors.green;
                  } else {
                    boxColor = Colors.white;
                  }

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (row == 4 && col == 2) {
                          seatState.toggleBlueSeat(index);
                        } else if (isSelected) {
                          seatState.toggleRedSeat(index);
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: boxColor,
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Center(
                        child: Stack(
                          children: [
                            Center(
                              child: seatState.seatNumbers[index] != null
                                  ? Text(seatState.seatNumbers[index]!,
                                      style: TextStyle(
                                          color: isSelected ||
                                                  (row == 4 && col == 2)
                                              ? Colors.white
                                              : Colors.black))
                                  : Container(),
                            ),
                            if (row == 4 && col == 2)
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Text(
                                  _formatDuration(_duration),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SwitchListTile(
                title: const Text('가게 운영'),
                value: true,
                onChanged: (bool value) {
                  // 스위치 변경 기능 구현
                },
              ),
              SwitchListTile(
                title: const Text('예약 가능 여부'),
                value: true,
                onChanged: (bool value) {
                  // 스위치 변경 기능 구현
                },
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '예약 시간 설정',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // 예약 시간 저장 버튼 기능 구현
                },
                child: const Text('저장하기'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
