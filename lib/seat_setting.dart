import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'seat_state.dart';

class SeatSetting extends StatefulWidget {
  const SeatSetting({super.key});

  @override
  _SeatSettingState createState() => _SeatSettingState();
}

class _SeatSettingState extends State<SeatSetting> {
  final List<bool> _selectedSeats = List<bool>.filled(81, false);
  final List<TextEditingController> _controllers =
      List.generate(81, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 9),
            itemCount: 81,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSeats[index] = !_selectedSeats[index];
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(2.0),
                  color: _selectedSeats[index] ? Colors.green : Colors.grey,
                  child: _selectedSeats[index]
                      ? TextField(
                          controller: _controllers[index],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '숫자 입력',
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Container(),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  List<bool> selectedSeats = List<bool>.from(_selectedSeats);
                  List<String?> seatNumbers = _controllers
                      .map((controller) =>
                          controller.text.isEmpty ? null : controller.text)
                      .toList();
                  Provider.of<SeatState>(context, listen: false)
                      .loadState(selectedSeats, seatNumbers);
                },
                child: const Text('저장하기'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
