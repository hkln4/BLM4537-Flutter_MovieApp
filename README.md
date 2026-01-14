Bu proje, Flutter kullanılarak geliştirilen bir Film Uygulamasıdır. Uygulama, gerçek
zamanlı olarak bir film veritabanı API'sinden verileri çeker ve kullanıcıya sunar.
Kullanıcılar, en popüler ve öne çıkan filmleri keşfedebilir, favori filmlerini
yönetebilir, izleme listesine ekleyebilirler, diğer filmleri değerlendirebilirler ve ayrıca
dizileri de keşfedebilirler. Uygulama, modern bir arayüze sahip olup kullanıcı
deneyimini artırmak için favorilere ekleme, izleme listesi, yorum sistemi ve
kişiselleştirilmiş profil yönetimi gibi özellikler içermektedir.

## Proje Özellikleri
### 1. Ana Ekran
• Ana ekranda popüler, trend olan ve en yüksek puanlı filmler gösterilecektir.
• Her film için poster görseli, film adı ve TMDb puanı yer alacaktır.
• Kullanıcılar ana ekranda en güncel ve öne çıkan içeriği göreceklerdir.
### 2. Film Detay Sayfası
• Seçilen filme ait detaylı bilgiler (film adı, açıklama, yayın tarihi, TMDb puanı, film
türü) gösterilecektir.
• Film sayfasında arka plan olarak film posteri kullanılacak ve görsel açıdan zengin
bir arayüz sunuluyor.
• Bu sayfada kullanıcılar filmleri; izleme listesine kaydetme, favorilere alma ve
yorumlama gibi işlemleri gerçekleştirebilir.
### 3. Arama Özelliği
• Kullanıcılar istedikleri filmleri arayabilecektir.
• Arama sonuçları film posterleri ve isimleriyle birlikte listelenecektir.
• Arama işlemi gerçek zamanlı olarak gerçekleştirilir.
### 4. API Entegrasyonu
• Film verileri The Movie Database (TMDb) API kullanılarak çekilir.
• Dinamik olarak güncel veriler sunar (yeni filmler, değişen popülerlik vb.).
### 5. Oyuncu ve Yönetmen Bilgileri
• Film detay sayfasında oyuncuların listesi bulunur.
• Her oyuncunun fotoğrafı ve adı gösterilir.
### 6. Platformlar Arası Destek (Android & iOS)
• Flutter ile geliştirildiği için Android ve iOS cihazlarda sorunsuz çalışır.
• Performans ve kullanıcı deneyimi açısından optimize edilmiştir.
### 7. Kullanıcı Girişi
• Kullanıcılar uygulamaya kayıt olabilir ve giriş yapabilirler.
• Kayıt işlemi sırasında ad, e-posta ve parola girilir.
• Parolalar güvenli bir şekilde şifrelenmiş olarak veritabanında saklanır.
• Başarılı giriş sonrasında kullanıcı uygulamanın tüm özelliklerine erişim sağlar.
### 8. Favori Yönetimi
• Kullanıcılar filmleri film detay sayfasından favorilere ekleyebilirler.
• Favorilere eklenen filmler profil sekmesindeki favoriler bölümünde listelenmekte.
• Favori listesi kullanıcıya özel olacak şekilde yapılandırılmıştır.
• Favori listesi, ekleme tarihleriyle birlikte sıralanır.
### 9. İzleme Listesi
• Kullanıcılar izlemek istedikleri filmleri izleme listesine ekleyebilir ve çıkarabilirler.
• İzleme listesi ayrı bir sekmede listelenmektedir.
• Favori listesi kullanıcıya özel olacak şekilde yapılandırılmıştır.
### 10. Yorum Sistemi
• Kullanıcılar filmler hakkında detaylı yorumlar yazabilirler.
• Yorum yazarken 1 ile 10 arasında bir puan verilir.
• Her yorum yazılan metin, puan, yazar adı ve yazma tarihi bilgilerini içerir.
• Kullanıcı kendi yazdığı yorum hakkında değişiklik yapabilir veya silebilir.
• Kullanıcı yaptığı tüm yorumlara profil sekmesinden erişebilmektedir.
### 11. Profil Yönetimi
• Kullanıcı profili sayfasında kişi bilgileri yer almaktadır.
• Kullanıcı kaç filmi favorisine eklediğini ve kaç yorum yazdığını görebilmektedir.
• Tüm özellikler kullanıcıya özel olacak şekilde yapılandırılmıştır.
• Profil sayfasından çıkış işlemi gerçekleştirilebilmektedir.
### 12. Yerel Backend
• Proje, Python Flask kütüphanesi kullanılarak geliştirilen bir backend sunucusuyla
entegre edilmiştir. Backend sunucusu SQLite veritabanı kullanmaktadır.
• Kullanıcı Yönetimi: Kayıt ve giriş işlemlerini yönetir. Parolalar bcrypt algoritması
kullanılarak güvenli bir şekilde şifrelenir. E-posta adresleri unique olarak saklanır.
• Favori Yönetimi: Kullanıcıların favorilere ekledikleri filmler için veri saklama ve
sorgulaması işlemlerini gerçekleştirilir. Her kullanıcı, favori olarak ekledikleri
filmlerin listesini görebilir. Bir film, bir kullanıcı tarafından sadece bir kez favorite
eklenebilir.
• İzleme Listesi: Kullanıcının izlemek istediği veya izlediği filmleri yönetir. Listenin
her öğesi, film bilgileri ve eklenme tarihi içerir. Bir film, bir kullanıcı tarafından
sadece bir kez eklenebilir.
• Yorum Yönetimi: Kullanıcı yorumlarını ve puanlarını yönetir. Her yorum, 1 ile 10
arasında bir puan, yorum metni, yazar kimliği ve oluşturulma tarihi bilgilerini
içerir. Bir kullanıcı, aynı filme sadece bir yorum yapabilir. Yorumlar güncellenebilir
ve silinebilir.
• API Endpoint'leri: Backend sunucusu, Kimlik Doğrulaması, Favori İşlemleri,
İzleme Listesi İşlemleri ve Yorum İşlemleri için toplamda 15 adet endpoint
sunmaktadır. Her endpoint, RESTful standartları takip eder. İstekler JSON
formatında gönderilir ve yanıtlar JSON formatında alınır.
