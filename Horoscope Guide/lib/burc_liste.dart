import 'package:flutter/material.dart';
import 'package:flutter_burc_rehberi/models/burc.dart';
import 'package:flutter_burc_rehberi/utils/Strings.dart';

//models sınıfında Burc sınıfını yapma amacımız burc_liste çalıştığında ilk olarak veri kaynağını hazırlamak için
class BurcListesi extends StatelessWidget {
// başa statik yazmamızın nedeni BurcDetayda tumBurcları kullanmamız gerekiyor
  static List<Burc> tumBurclar;

//Burç listesini oluşturabilmek için öncelikle veri kaynağını oluşturmak gerek.
//models sınıfında Burc sınıfını yapma amacımız BurcListesi çalıştığında Burc nesneli liste  oluşturmak.

// Bir liste oluşturacakken yapman gereken ilk şey bir model oluşturmak ardından bu listeyi doldurmak.

  @override
  Widget build(BuildContext context) {
    tumBurclar = veriKaynaginiHazirla();

    return Scaffold(
      appBar: AppBar(
        title: Text("Burc Rehberi"),
      ),
      body: listeyiHazirla(),
    );
  }

  //static olanlar sınıfa özgü static olmayanlar nesneye özgü. build methodu çalıştığında artık tumBurclar ilgili nesneye bağlı. O yüzden static yazmaya veya nesne üretmeye gerek yok.
  int index = 0;

  List<Burc> veriKaynaginiHazirla() {
    // !!!!!!!!!!!!!!!!!!LİSTE OLUŞTURMA!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    List<Burc> burclar = [];

    for (int i = 0; i < 12; i++) {
//toLowerCase küçük harf  yapma
      String kucukResim = Strings.BURC_ADLARI[i].toLowerCase() + "${i + 1}.png";
      String buyukResim =
          Strings.BURC_ADLARI[i].toLowerCase() + "_buyuk${i + 1}.png";

      //eklenecekBurc diye bir Burc elemanı oluşturduk.
      Burc eklenecekBurc = Burc(
          Strings.BURC_ADLARI[i],
          Strings.BURC_TARIHLERI[i],
          Strings.BURC_GENEL_OZELLIKLERI[i],
          kucukResim,
          buyukResim);
      // oluşturduğun eklenecekBurc u Listeye  ekle.
      burclar.add(eklenecekBurc);
    }
    return burclar;
  }

  // BODY KISMI BİZDEN BİR WİDGET İSTİYOR
  Widget listeyiHazirla() {
    // tek tek doldurulacak olsaydı ListView deyip childrenları dolduracaktık.

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return tekSatirBurcWidget(context, index);
      },
      itemCount: tumBurclar.length,
    );
  }

  Widget tekSatirBurcWidget(BuildContext context, int index) {
    Burc oAnListeyeEklenenBurc = tumBurclar[index];
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          onTap: () => Navigator.pushNamed(context, "/burcDetay/$index"),
          leading: Image.asset(
            "images/${oAnListeyeEklenenBurc.burckucukResim}",
            width: 64,
            height: 64,
          ),
          title: Text(
            "${oAnListeyeEklenenBurc.burcAdi}",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade500),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "${oAnListeyeEklenenBurc.burcTarihi}",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
