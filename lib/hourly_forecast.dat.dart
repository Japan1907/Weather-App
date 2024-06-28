import 'package:flutter/material.dart';

class hourlyForecast extends StatelessWidget{
  final String time;
  final IconData icon;
  final String value;
   const hourlyForecast(
      {
        super.key,
        required this.time,
        required this.icon,
        required this.value,
  });

  @override
  Widget build(BuildContext context)
  {
    return  Card(
      elevation: 6,
      color: Colors.white60,

      //card 1
      child:Container(
        width:80,

        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),

        ),
        child: Column(

          children: [
              Expanded(
              child: Text(time,style: const TextStyle(
                fontSize:10,
                fontWeight: FontWeight.bold,

              ),
                maxLines: 1,

              ),
            ),
            const SizedBox(height: 8,),
            Icon(icon,size: 32,color: Colors.yellow,),
            const SizedBox(height: 8,),
            Text(value,style:const TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

