

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTimePicker extends StatefulWidget {
  final void Function(int hour, int minute)? onTimeSelected;
  const CustomTimePicker({super.key, this.onTimeSelected});

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late FixedExtentScrollController  _hourController;
  late FixedExtentScrollController  _minuteController;

  int selectedHour=0;
  int selectedMinute= 0;

  @override
  void initState(){
   _hourController = FixedExtentScrollController(initialItem: 0);
   _minuteController= FixedExtentScrollController(initialItem: 0);
   super.initState();
  }

  @override
  void dispose(){
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Expanded(child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(child:
                Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 65,
                  decoration: BoxDecoration(
                    color: Color(0xff36402b),
                    borderRadius: BorderRadius.circular(10)
                  ),
                )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildWheelList(
                          controller: _hourController,
                          items: List.generate(24, (index)=> index),
                          onChanged: (value) {
                            setState(() {
                              selectedHour = value;
                            });
                            widget.onTimeSelected?.call(selectedHour, selectedMinute);
                          }
                      ),
                      Text(':', style: TextStyle(fontSize: 60, color: Color(0xffa8c889)),),
                      _buildWheelList(
                          controller: _hourController,
                          items: List.generate(60, (index)=> index),
                          onChanged: (value) {
                            setState(() {
                              selectedMinute = value;
                            });
                            widget.onTimeSelected?.call(selectedHour, selectedMinute);
                          }
                      )
                    ],
                  ),
                )

              ],
            ))
          ],
        ),
      ),
    );
  }
  Widget _buildWheelList({
   required FixedExtentScrollController controller,
    required List<int> items,
    required Function(int) onChanged,
}){
    return SizedBox(
      width: 70,
      child: ListWheelScrollView.useDelegate(
          itemExtent: 80
          ,
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: items.length,
              builder: (context, index){
                return Center(
                  child: Text(
                    items[index].toString().padLeft(2, '0'),
                    style: const TextStyle(
                      fontSize: 60,
                      color: Color(0xffa8c889), fontWeight: FontWeight.w700
                    ),
                  ),
                );
              }
          )
      )
    );
}
}
