//BİR BURÇ İLE İLGİLİ BÜTÜN VERİLER BURADA OLACAK....
class Burc {
  // özellikleri verirken private ver. private verdiğinde bu sınıfın dışında okuyamazsın veya bunlara veri yazamazsın. Bunları yaptırmak için getter ve setter...
  String _burcAdi;
  String _burcTarihi;
  String _burcDetayi;
  String _burckucukResim;
  String _burcBuyukResim;

  /*
 Her sınıfın bir yapıcı yani Constructor metodu vardır.
Eğer biz bunu yazmaz isek boş olarak yazılmış gibi işler.
Constructor metod sınıfın ismiyle aynı ismi taşır.
Bir sınıftan nesne türetildiği anda bazı bilgilerin mutlaka verilmesini istiyorsak bunu constructor metoda parametreler vererek zorlayabiliriz.
   */

  //Bu sınıftan bir nesne oluşturmak için  alttaki constructor kullanılacak :
  Burc(this._burcAdi, this._burcTarihi, this._burcDetayi, this._burckucukResim,
      this._burcBuyukResim);

  // Eğer ki bize  _burcBuyukResim lazımsa o zaman burcBuyukResim çağıralacak demek.

  String get burcBuyukResim => _burcBuyukResim;

  set burcBuyukResim(String value) {
    _burcBuyukResim = value;
  }

  String get burckucukResim => _burckucukResim;

  set burkucukResim(String value) {
    _burckucukResim = value;
  }

  String get burcDetayi => _burcDetayi;

  set burcDetayi(String value) {
    _burcDetayi = value;
  }

  String get burcTarihi => _burcTarihi;

  set burcTarihi(String value) {
    _burcTarihi = value;
  }

  String get burcAdi => _burcAdi;

  set burcAdi(String value) {
    _burcAdi = value;
  }
//verdiğimiz parametreleri yukaradaki değerlere atacak.

}
