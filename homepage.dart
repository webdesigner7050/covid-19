import 'dart:convert';
import 'package:covid19/datasource.dart';
import 'package:covid19/pages/countryPage.dart';
import 'package:covid19/panels/infoPanel.dart';
import 'package:covid19/panels/mosteffectedcountries.dart';
import 'package:covid19/panels/worldwidepanel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map worldData;
  fetchWorldWideData() async{
    http.Response response= await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData=json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async{
    http.Response response= await http.get('https://corona.lmao.ninja/v2/countries');
    setState(() {
      countryData=json.decode(response.body);
    });
  }
  @override
  void initState() {
    fetchWorldWideData();
    fetchCountryData();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
         title: Text('COVID-19 TRACKER'),
      ),
      body:SingleChildScrollView (child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            height: 100,
            color: Colors.orangeAccent[100
            ],
            child:Text(DataSource.quote, style:TextStyle(color: Colors.orange[800],fontWeight: FontWeight.bold,fontSize:18),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:10,horizontal: 10.0),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('WORLDWIDE',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>CountryPage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                  color: Colors.black,
                    borderRadius:BorderRadius.circular(10),
                  ),
                    padding: EdgeInsets.all(10),
                    child: Text('Regional',style: TextStyle(fontSize: 16,color:Colors.white,fontWeight: FontWeight.bold),)),
              )
            ],
          ),
          ),
         worldData==null?CircularProgressIndicator():WorldWidePanel(worldData: worldData,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('TOTAL CASES',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          ),
         SizedBox(height: 10,),
         countryData==null?Container(): MostAffectedPanel(
           countryData: countryData,),
         InfoPanel(),
          SizedBox(height: 20,),
          Text('WE ARE TOGETHER IN THE FIGHT'),
          SizedBox(height: 50,)
        ],
      )
      ),
    );
  }
}


