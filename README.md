


Referans alınan istekler 

[PandemiDönemi_StajProjesi.pdf](https://github.com/Stkaskin/Makale-Takip-Flutter-sqlflite/files/8992150/PandemiDonemi_StajProjesi.pdf)



Mobil platform  flutter

 
 <img src="https://user-images.githubusercontent.com/90522945/175945500-51ca7729-c1a4-4c77-9e4b-96cde1f9011b.png" weight="350" height="500">

 
Programda ilk kurulum gerçekleştirilir

<img src="https://user-images.githubusercontent.com/90522945/175945529-375f7d53-551a-4a31-9993-076713c94726.png" weight="350" height="500">

Baş editör ve Alan editörü makaleler  ekranı 


<img src="https://user-images.githubusercontent.com/90522945/175945582-80e6c439-c495-4584-a9b2-a0d72b031bbb.png" weight="350" height="500">

Baş editör ve alan editörü yeni personel ekleme sayfası
Baş editör hakem -yazar- alan editörü atar
Alan editörü hakem ve yazar atar


<img src="https://user-images.githubusercontent.com/90522945/175945611-81663121-9bb7-4a48-ba01-4a3413aea1be.png" weight="350" height="500">

Personel bilgi butonu ile bu sayfada personellerin bilgilerini görüntüler

<img src="https://user-images.githubusercontent.com/90522945/175945646-b7ee13cb-9508-4995-bc33-1c128a3845f4.png" weight="350" height="500">

Yazar giriş yaptıktan sonra bu ekranda makaleler görüntüler ,revizyon veya yeni makale ekler

<img src="https://user-images.githubusercontent.com/90522945/175945674-c54e76f1-6f2b-4737-bac5-8c12025d6983.png" weight="350" height="500">

Yazar yeni makale ekler

<img src="https://user-images.githubusercontent.com/90522945/175945719-de78541d-b178-4d61-ad84-012c911a78cc.png" weight="350" height="500">


<img src="https://user-images.githubusercontent.com/90522945/175945754-12a90bd8-f6ae-4b7b-9874-5ce7c4ccf042.png" weight="350" height="500">

Yeni makale makaleler sayfasında görünümü

<img src="https://user-images.githubusercontent.com/90522945/175945877-53f2e849-ac17-4b82-bd35-fff5973073f2.png" weight="350" height="500">

Baş editör sisteme giriş yapıp alan editörü ataması yapar sisteme giriş yaptıktan sonra görev bildirimi gelir


<img src="https://user-images.githubusercontent.com/90522945/175945915-f32b127d-2725-4a3c-9ec0-a63ec69d8e6d.png" weight="350" height="500">

Alan editörü giriş yaptıktan sonra  atama seçeneğinden hakem ataması yapar görevi varsa bildirim alır.


<img src="https://user-images.githubusercontent.com/90522945/175945941-95d88609-96f0-4baf-9c4e-214ca9b61d46.png" weight="350" height="500">


Hakem sisteme girdikten sonra davetlerim bölümünden davetleri görüntüler 
Kabul ederse oy verme hakkına sahip olur makalelerim sayfasında oy verebilir.
Ret eder veya süre aşımına uğrarsa makale ile ilişkisi kesilir.
Görev bilirimi alır


<img src="https://user-images.githubusercontent.com/90522945/175945978-8f38c1fd-1a6d-4168-9628-78d8ee635872.png" weight="350" height="500">

Hakem kabul ettiği davetleri makaleler bölümünde oy verir . oy verme süresi süre aşımına uğradığı takdirde makale ile ilişkisi kesilir 
Görev bildirimi alır


<img src="https://user-images.githubusercontent.com/90522945/175946021-517cf590-e879-41c3-8d02-b2ea56829585.png" weight="350" height="500">

3 hakemin puanladığı makale alan editör incelemesine sunulur
75 puan ve üzeri ise onaylar veya revizyon isteyebilir.
75 puan altında ise Ret eder veya revizyon isteyebilir.


<img src="https://user-images.githubusercontent.com/90522945/175946040-71d192c5-1ce6-4aae-93bd-347fcfe910b1.png" weight="350" height="500">

Yazar sistemde revizyon talebi olan makale varsa makale gönderir . Eğer revizyon talebi süre aşımına uğrarsa makale otomatik ret edildi olarak görülür.



<img src="https://user-images.githubusercontent.com/90522945/175946248-10d1ecd1-7ce5-4d35-960a-8f23bd520715.png" weight="350" height="500">

Yazar ve diğer yazarlar sistemde giriş yapmadan makale araması yapabilir
Giriş sayfasında **Giriş yapmadan makale ara “” butonu


<img src="https://user-images.githubusercontent.com/90522945/175946288-8ff2e8b1-088e-4fac-84b8-1190017781d7.png" weight="350" height="500">


Giriş yapmadan makale arandığında makalenin üzerine tıkladığında detaylı bilgi kutusu açılır






Özel Onay kodları. aşama için

[mobil database ve onay kodları .xlsx](https://github.com/Stkaskin/Makale-Takip-Flutter-sqlflite/files/8992135/mobil.database.ve.onay.kodlari.xlsx)

Mobil veritabanı SQLLİTE


![mobil ilk veritabanı tasarımı paint](https://user-images.githubusercontent.com/90522945/175946643-5387083f-ce43-40c4-9648-bcea791414d1.png" weight="350" height="500">


 "CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT,mail TEXT NOT NULL,parola TEXT NOT NULL,ad TEXT NOT NULL,yetki INTEGER,aktif INTEGER)");


  "CREATE TABLE makales (id INTEGER PRIMARY KEY AUTOINCREMENT , baslik TEXT NOT NULL , zaman TEXT NOT NULL , yazar TEXT NOT NULL , onay INTEGER , mail TEXT NOT NULL , revizyonzamani TEXT , yol TEXT)");

    "CREATE TABLE makaleislem (id INTEGER PRIMARY KEY AUTOINCREMENT,makaleid INTEGER, yazarid INTEGER,alaneditorid INTEGER, baseditorid INTEGER,hakemcevap INTEGER,alaneditorcevap INTEGER,baseditorcevap INTEGER,durum, baseditorzaman TEXT, alaneditorzaman TEXT)");

   "CREATE TABLE hakemislem (id INTEGER PRIMARY KEY AUTOINCREMENT,makaleid INTEGER, hakemid INTEGER, durum INTEGER, oy INTEGER,sonislem ,rapor TEXT)");


<img src="https://user-images.githubusercontent.com/90522945/175945339-aea4f0dd-db29-4d35-a42b-3715232bc74f.png" weight="350" height="500">


<img src="https://user-images.githubusercontent.com/90522945/175945349-17a1d96c-4111-4268-b2e3-b25fa6853492.png" weight="350" height="500">

<img src="https://user-images.githubusercontent.com/90522945/175945389-b2a1fe6c-70b1-43a1-a783-5a420058753a.png" weight="350" height="500">

<img src="https://user-images.githubusercontent.com/90522945/175945397-ef8aec74-f27a-40d6-b40a-e761a0bad7e3.png" weight="350" height="500">


