import 'package:flutter/material.dart';
import 'package:flutter_burc_rehberi/burc_detay.dart';
import 'package:flutter_burc_rehberi/burc_liste.dart';

// Fat arrow kullanımı
void main() => runApp(MyAppp());

//Widget Oluşturalım
class MyAppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ilk kök widgetı genellikle --> MaterialApp
    return MaterialApp(
      debugShowCheckedModeBanner: false,
//initialRoute: "/burcListesi",
      routes: {
        "/": (context) => BurcListesi(),
        "/burcListesi": (context) => BurcListesi(),
      },
      onGenerateRoute: (RouteSettings settings) {
        List<String> pathElemanlari =
            settings.name.split("/"); // !!!!!!!!!!!!!!     / burcDetay / 1
        if (pathElemanlari[1] == "burcDetay") {
          return MaterialPageRoute(
              builder: (context) => BurcDetay(int.parse(pathElemanlari[2])));
        }
        return null;
      },
      //
      theme: ThemeData(primarySwatch: Colors.pink),
      title: "BURÇ REHBERİ",
    );
  }
}
