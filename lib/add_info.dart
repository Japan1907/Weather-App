import 'package:flutter/material.dart';
class add_info extends StatelessWidget{
  final IconData icon;
  final String label;
  final String value;
  const add_info(
  {
    super.key,
    required this.icon,
    required this.label,
    required this.value,
}
);
  @override
  Widget build(BuildContext context)
  {
    return Card(
      elevation: 6,color: Colors.white70,

      child:Container(
        width:80,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),

        ),
        child:  Column(

          children: [

            Icon(icon,size: 32,color: Colors.black54,),

           const SizedBox(height: 8,),
            Text(label,style: const TextStyle(
              fontSize:11,
              fontWeight: FontWeight.bold,
              color: Colors.black87,

            ),
            ),
            const SizedBox(height: 8,),
            Text(value,style:const TextStyle(fontSize: 13,color: Colors.black87)),
          ],
        ),
      ),


    );



  }
}