
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'custom_time_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffa8c889),
      child: Scaffold(
        backgroundColor:const Color(0xffa8c889) ,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                //color: Colors.black,
                height: MediaQuery.sizeOf(context).height*0.6,
                width: double.infinity,
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topRight:Radius.circular(55),
                     topLeft: Radius.circular(55),
                     bottomLeft: Radius.circular(35),
                     bottomRight: Radius.circular(35)
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('12:00', style: TextStyle(color: const Color(0xffa8c889), fontSize: 150,height: 0),),
                        Text('The Next Alarm Clock in 20 MIN', style: TextStyle(color: const Color(
                            0xff92a383), fontSize: 20,fontWeight: FontWeight.w600),)
                      ],
                    ),
                   Padding(
                     padding: const EdgeInsets.all(15.0),
                     child: CustomPaint(painter: ProgressPainter(5), size:  const Size(double.infinity, 150),),
                   )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                'SUN, MON, TUE, WED, THU, FRI, SAT'].map((day)=>
                  Text(day,style: TextStyle(fontSize: 22, 
                      color: DateTime.now().weekday==['SUN, MON, TUE, WED, THU, FRI, SAT'].indexOf(day)+1 ? Colors.black : Colors.black54
                  )
                  )
              )
                  .toList(),
            ),
            SizedBox(height: 10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate( 3, (index)=> Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: DottedBorder(
                   color: Colors.black87,
                    strokeWidth: 3,
                    dashPattern: const [6,6],
                    child: Container(
                     padding:const EdgeInsets.all(8),
                      width: 350,
                      height: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:MainAxisAlignment.spaceAround,
                            children: [
                              Text('12:00', style: TextStyle(fontSize: 60),
                              ),
                              Icon(Icons.play_arrow, size: 70,)
                            ],
                          ),
                          Text('Time for the next alarm', style: TextStyle(fontSize: 20, color: Colors.black54),)
                        ],
                      ),
                    ),
                  ),
                )
                )
                ,
              ),
            )
          ],
        ),
        persistentFooterButtons: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: (){},
                  icon: Icon(Icons.calendar_month, color: Color(0xffa8c889),
                  ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black87,
                  foregroundColor: Color(0xffa8c889),
                  fixedSize: const Size(60,60)
                ),
              ),
              SizedBox(
                width: 230,
                child: FloatingActionButton.extended(onPressed: (){},
                    label: const Text('12:00', style: TextStyle(fontSize: 30),),
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.black87,
                  foregroundColor: Color(0xffa8c889),
                ),
              ),
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const CustomTimePicker()));
              },
                  icon: Icon(Icons.add,),
                style: IconButton.styleFrom(
                  foregroundColor: Color(0xffa8c889),
                  backgroundColor: Colors.black87,
                  fixedSize: const Size(60,60)
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ProgressPainter extends CustomPainter{
  final int totalBars= 40;
  final int currentProgress;

  ProgressPainter(this.currentProgress);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth=2..style= PaintingStyle.stroke;

    double barSpacing = size.width/ totalBars;

    for (int i = 0; i < totalBars; i++) {
      paint.color = i < currentProgress ? const Color(0xff333333) : const Color(0xffa8c889);
      canvas.drawLine(Offset(i * barSpacing, size.height), Offset(i * barSpacing, 0), paint);
      if (i % 5 == 0 && i != currentProgress) {
        paint
          ..style = PaintingStyle.fill
          ..color = const Color(0xffa8c889);
        canvas.drawCircle(Offset(i * barSpacing, -30), 3, paint);
        paint.style = PaintingStyle.stroke;
      }
      paint.color = Colors.red;
      canvas.drawLine(
        Offset(currentProgress * barSpacing, size.height),
        Offset(currentProgress * barSpacing, 0),
        paint..strokeWidth = 3,
      );

      paint
        ..style = PaintingStyle.fill
        ..color = Colors.red;

      final path = Path();
      final arrowX = currentProgress * barSpacing;
      path.moveTo(arrowX, -20);
      path.lineTo(arrowX - 10, -40);
      path.lineTo(arrowX + 10, -40);
      path.close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
   return true;
  }
  
}
