import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/add_info.dart';
import 'package:weather_app/secrets.dart';
import 'hourly_forecast.dat.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Weatherapp extends StatefulWidget{
const Weatherapp({super.key});


  @override
  State<Weatherapp> createState() => _WeatherappState();
}

class _WeatherappState extends State<Weatherapp> {

late  Future<Map<String,dynamic>> weather;
final TextEditingController _cityController = TextEditingController();
String _city = 'Vadodara';
Future<Map<String, dynamic>> getCurrentData() async
{

  try {

    final res = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$_city&units=metric&appid=$API_KEY',),
    );

    final data=jsonDecode(res.body);

    if(res.statusCode!=200)
    {
       throw 'An UnExpected Error Occured';
    }
    return data as Map<String, dynamic>;

  }

  catch(e)
  {
    throw e.toString();

  }

}
@override
initState(){
  super.initState();
  weather=getCurrentData();
}

void _searchCity() {
  setState(() {
    _city = _cityController.text;
    weather = getCurrentData();
  });
}

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       color: Colors.white70,

       home:Scaffold(
         backgroundColor: Colors.blueAccent,
         appBar:AppBar(
           title:const Text('Weather',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
           centerTitle: true,
           backgroundColor:Colors.black12 ,


          actions: [

           IconButton(
             onPressed: (){
             setState(() {
             weather = getCurrentData();
             });
           },

             icon: const Icon(Icons.refresh),
            ),

          ],
         ),
         body:
         SingleChildScrollView(
                  child: FutureBuilder<Map<String, dynamic>?>(
                     future:weather,
                     builder:(context,snapshot) {
                   
                       if(snapshot.connectionState==ConnectionState.waiting){
                         return const Center(child:  CircularProgressIndicator.adaptive());
                       }
                   
                       if(snapshot.hasError)
                       {
                         Center(child: Text(snapshot.error.toString()));
                       }
                   
                       if (!snapshot.hasData || snapshot.data == null) {
                         return const Center(child: Text('No data available'));
                       }
                   
                       final data=snapshot.data!;
                   
                       final currentemp=data['list'][0]['main']?['temp'] ?? 'N/A';
                       final currentsky=data['list'][0]['weather']?[0]?['main'] ?? 'N/A';
                       final pressure=data['list'][0]['main']['pressure'];
                       final humidity=data['list'][0]['main']['humidity'];
                       final wspeed=data['list'][2]['wind']['speed'];
                   
                   
                   
                       FaIcon typesky;
                       switch (currentsky)
                       {
                         case 'Rain':
                           typesky=const FaIcon(FontAwesomeIcons.cloudRain,color: Colors.yellow,size: 35,) ;
                           break;
                   
                   
                         case 'Smoke':
                           typesky=const FaIcon(FontAwesomeIcons.cloud,color: Colors.yellow,size: 35,);
                           break;
                   
                   
                         case 'Thunderstorm':
                           typesky=const FaIcon(FontAwesomeIcons.cloudBolt,color: Colors.yellow,size: 35,);
                           break;
                   
                         case 'Clouds':
                           typesky=const FaIcon(FontAwesomeIcons.cloudSun,color: Colors.yellow,size: 35,);
                           break;
                           
                         case 'light rain':
                           typesky=const FaIcon(FontAwesomeIcons.cloudRain,color: Colors.yellow,size: 35,);
                           break;


                         case 'Sunny':
                           typesky=const FaIcon(FontAwesomeIcons.sun,color: Colors.yellow,size: 35,);


                   
                         default:
                           typesky=const FaIcon(FontAwesomeIcons.sun,color: Colors.yellow,size: 35,);
                           break;
                   
                       }
                   
                   
                       return
                          Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:
                                            [
                                                 TextField(
                             controller: _cityController,
                             decoration: InputDecoration(
                               labelText: 'Enter City Name',
                                          
                               suffixIcon: IconButton(
                                 icon: const Icon(Icons.search),
                                 onPressed: _searchCity,
                               ),
                             ),
                                                 ),
                                                 SizedBox(height:10 ,),
                                                 //main card
                                                 SizedBox(
                             width:double.infinity,
                                          
                             child: Card(
                               color: Colors.blue,
                                          
                              elevation:10,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                child: BackdropFilter(
                                          
                                  filter:ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                                  child:  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                       children: [
                                         Text('$currentemp \u00b0C',style: const TextStyle(
                                           fontSize:32,
                                           fontWeight: FontWeight.bold,
                                          
                                         ),
                                         ),
                                       const   SizedBox(height: 15,),
                                         typesky,
                                        const  SizedBox(height: 7,),
                                        Text('$currentsky',style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                       ],
                                     ),
                                  ),
                                ),
                              ),
                                          
                             ),
                                                 ),
                                          
                                          
                                             const SizedBox(
                                                 height: 20,
                                            ),
                                                 //Weather Forecast
                                     SizedBox(
                                          
                            child: Card(
                              color: Colors.blueAccent,
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                          
                                          
                                   const Text('Weather Forecast',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.left,),
                                    const SizedBox(height: 8,),
                                          
                                      SizedBox(
                                          height: 100,
                                          
                                        child: ListView.builder(
                                          
                                          itemCount: 5,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context,index)
                                        {
                                          final hourlyforecast=data['list'][index+1];
                                          final hourlysky=data['list'][index+1]['weather'][0]['main'];
                                          final time=DateTime.parse(hourlyforecast['dt_txt']);
                                                 return hourlyForecast(time: DateFormat.j().format(time), icon:hourlysky=='Clouds' || hourlysky=='Rain' ?Icons.cloud:FontAwesomeIcons.moon , value: hourlyforecast['main']['temp'].toString());
                                        },
                                        ),
                                      ),
                                ],
                                    ),
                                          
                              )
                                          
                            ),
                                             ),
                                     const SizedBox(
                                                 height: 20,
                                            ),
                                                 //additional information
                                          
                                          
                            const Text('Additional Information',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.left,),
                            const SizedBox(height:10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                          
                                add_info(icon: Icons.water_drop, label: 'Humidity', value: '$humidity'),
                                add_info(icon: Icons.air, label: 'Wind Speed', value: '$wspeed'),
                                add_info(icon: Icons.beach_access, label: 'Pressure', value: '$pressure'),
                                          
                                          
                                          
                                          
                                ],
                              ),
                                          
                                          
                                            ],
                                          
                                    ),
                            
                  
                          );
                     },
                   ),
                ),
              ),


       




    );
  }
}




