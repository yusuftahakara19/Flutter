import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ortalama Hesaplama',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dersAdi;
  int dersKredi = 1;
  double dersHarfDegeri = 4;
  List<Ders> tumDersler;
  double ortalama = 0;
  static int sayac = 0;

  // floatingAction Button için oluşturuldu
  /*
  * . Widget ların key diye bir özelliği vardır.
  * Eğer sen bir widget a key verirsen onun ile o widgetin boyutunu, ekranda nerede olduğunu, kapladığı alanı gibi özel bilgileri bu key ile edinebilirsin.
  * Bazı widgetlar için ekstra özelliklere de ulaşabiliyorsun.
   */
  var formKey = GlobalKey<FormState>();
  /*
  * initstate widget ilk olusturuldugunda calıstırılır ve sonra calıstırılmaz,
  *   build metotları tekrar tekrar tetiklenir ama initstate sadece bir kere tetiklenir
  * eger biz tumdersler tanımını build metotu içinde yapsaydık build her tetiklendiğinde - ki eğer build metotu içine bir debugprint ifadesi koyarsan sürekli çağrıldıgını görürsün - sürekli sıfırlanırdı o yüzden initstate kullandık.
  * */
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumDersler = [];
  }

// NEDEN DİSPOSE KULLANILMADI ?****
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,

        // klavyeye basıldığında gelen hatayı kapatmak için kullanılır.

        appBar: AppBar(
          title: Text("Ortalama Hesaplama"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //Eğer ki değerlerimizi validate olmuşsa onsave çalışır
            //currentState=şu anki durum
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
            }
          },
          child: Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return uygulamaGovdesi();
              } else {
                return uygulamaGovdesiLandscape();
              }
            },
          ),
        ));
  }

  Widget uygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              padding: EdgeInsets.all(20),
              // color: Colors.pink.shade100,

              //Form : Form widgetlerini bir arada tutan widget.
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan, width: 2),
                          borAderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: "Ders Adı",
                        hintText: "Ders Adını Giriniz...",
                        hintStyle: TextStyle(fontSize: 15),
                        labelStyle: TextStyle(fontSize: 15),
                        /*  border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.indigo, width: 10),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),*/
                      ),
                      validator: (girilenDeger) {
                        if (girilenDeger.length > 0) {
                          return null;
                        } else {
                          return "Ders Adını Giriniz";
                        }
                      },
                      onSaved: (kaydedilecekDeger) {
                        dersAdi = kaydedilecekDeger;
                        //State sınıfından türetildiği için state’in değişmesi durumunda ekranın tekrar çizilmesi sağlanıyor.
                        setState(() {
                          tumDersler
                              .add(Ders(dersAdi, dersHarfDegeri, dersKredi));
                          ortalama = 0;
                          ortalamayiHesapla();
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              border: Border.all(color: Colors.blue, width: 2)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          margin: EdgeInsets.all(4),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              items: dersKredileriItems(),
                              onChanged: (secilenKredi) {
                                setState(() {
                                  dersKredi = secilenKredi;
                                });
                              },
                              value: dersKredi,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              border: Border.all(
                                color: Colors.blue,
                                width: 2,
                              )),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          margin: EdgeInsets.all(4),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<double>(
                              items: dersHarfDegerleriItems(),
                              onChanged: (secilenHarf) {
                                setState(() {
                                  dersHarfDegeri = secilenHarf;
                                });
                              },
                              value: dersHarfDegeri,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              border: BorderDirectional(
                start: BorderSide(color: Colors.blue[400], width: 2),
                top: BorderSide(color: Colors.blue[400], width: 2),
                bottom: BorderSide(color: Colors.blue[400], width: 2),
                end: BorderSide(color: Colors.blue[400], width: 2),
              ),
            ),
            height: 70, //??????????????????????????????*
            child: Center(
                child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: tumDersler.length == 0
                        ? "Ders Ekleyiniz"
                        : "Ortalama : ",
                    style: TextStyle(fontSize: 30, color: Colors.black)),
                TextSpan(
                    // virgülden sonraki basamağı belirlemek için
                    text: tumDersler.length == 0
                        ? ""
                        : "${ortalama.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold)),
              ]),
            )),
          ),
          Expanded(
            child: Container(
                //  color: Colors.orange.shade100,
                child: ListView.builder(
              itemBuilder: _listeElemanlariniOlustur,
              itemCount: tumDersler.length,
            )),
          ),
        ],
      ),
    );
  }

  Widget uygulamaGovdesiLandscape() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(20),
                    // color: Colors.pink.shade100,

                    //Form : Form widgetlerini bir arada tutan widget.
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.cyan, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              labelText: "Ders Adı",
                              hintText: "Ders Adını Giriniz...",
                              hintStyle: TextStyle(fontSize: 15),
                              labelStyle: TextStyle(fontSize: 15),
                              /*  border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.indigo, width: 10),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),*/
                            ),
                            validator: (girilenDeger) {
                              if (girilenDeger.length > 0) {
                                return null;
                              } else {
                                return "Ders Adını Giriniz";
                              }
                            },
                            onSaved: (kaydedilecekDeger) {
                              dersAdi = kaydedilecekDeger;
                              //State sınıfından türetildiği için state’in değişmesi durumunda ekranın tekrar çizilmesi sağlanıyor.
                              setState(() {
                                tumDersler.add(
                                    Ders(dersAdi, dersHarfDegeri, dersKredi));
                                ortalama = 0;
                                ortalamayiHesapla();
                              });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18)),
                                    border: Border.all(
                                        color: Colors.blue, width: 2)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                margin: EdgeInsets.all(4),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                                    items: dersKredileriItems(),
                                    onChanged: (secilenKredi) {
                                      setState(() {
                                        dersKredi = secilenKredi;
                                      });
                                    },
                                    value: dersKredi,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18)),
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 2,
                                    )),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                margin: EdgeInsets.all(4),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<double>(
                                    items: dersHarfDegerleriItems(),
                                    onChanged: (secilenHarf) {
                                      setState(() {
                                        dersHarfDegeri = secilenHarf;
                                      });
                                    },
                                    value: dersHarfDegeri,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 1, bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      border: BorderDirectional(
                        start: BorderSide(color: Colors.blue[400], width: 2),
                        top: BorderSide(color: Colors.blue[400], width: 2),
                        bottom: BorderSide(color: Colors.blue[400], width: 2),
                        end: BorderSide(color: Colors.blue[400], width: 2),
                      ),
                    ),
                    height: 70, //??????????????????????????????*
                    child: Center(
                        child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: tumDersler.length == 0
                                ? "Ders Ekleyiniz"
                                : "Ortalama : ",
                            style:
                                TextStyle(fontSize: 30, color: Colors.black)),
                        TextSpan(
                            // virgülden sonraki basamağı belirlemek için
                            text: tumDersler.length == 0
                                ? ""
                                : "${ortalama.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold)),
                      ]),
                    )),
                  ),
                ),
              ],
            ),
            flex: 1,
          ),
          Expanded(
            child: Container(
                //  color: Colors.orange.shade100,
                child: ListView.builder(
              itemBuilder: _listeElemanlariniOlustur,
              itemCount: tumDersler.length,
            )),
            flex: 1,
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> dersKredileriItems() {
    List<DropdownMenuItem<int>> krediler = [];
    for (int i = 1; i <= 10; i++) {
      krediler.add(DropdownMenuItem<int>(
        value: i,
        child: Text("$i Kredi"),
      ));
    }
    return krediler;
  }

  List<DropdownMenuItem<double>> dersHarfDegerleriItems() {
    List<DropdownMenuItem<double>> harfler = [];
    harfler.add(
      DropdownMenuItem(
        child: Text("AA"),
        value: 4,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text("BA"),
        value: 3.5,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text("BB"),
        value: 3,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text("CB"),
        value: 2.5,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text("CC"),
        value: 2,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text("DC"),
        value: 1.5,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text("DD"),
        value: 1,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text("FF"),
        value: 0,
      ),
    );
    return harfler;
  }

  Widget _listeElemanlariniOlustur(BuildContext context, int index) {
    sayac++;

    return Dismissible(
      key: Key(sayac.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          tumDersler.removeAt(index);
          ortalamayiHesapla();
        });
      },
      child: Card(
        child: ListTile(
          leading: Icon(
            Icons.menu_book_outlined,
            color: Colors.cyan,
          ),
          title: Text(tumDersler[index].ad),
          trailing: Icon(
            Icons.arrow_forward_ios,
          ),
          subtitle: Text(tumDersler[index].kredi.toString() +
              " Kredi , Ders Not Değeri:" +
              tumDersler[index].harfDegeri.toString()),
        ),
      ),
    );
  }

  void ortalamayiHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;

    for (var oankiDers in tumDersler) {
      toplamKredi = toplamKredi + oankiDers.kredi;
      toplamNot = toplamNot + (oankiDers.harfDegeri * oankiDers.kredi);
    }
    ortalama = toplamNot / toplamKredi;
  }
}

class Ders {
  String ad;
  double harfDegeri;
  int kredi;
  Ders(this.ad, this.harfDegeri, this.kredi);
}
