# **Kargo Takip Otomasyonu**

> Bu repository, **Fırat Üniversitesi Bilgisayar Mühendisliği** bölümü **Veri Tabanı Sistemleri** dersi için hazırlanmıştır.

## Proje Ekibi

- **Ömer Karaman**
- **Ahmet Yasin Durakcı**

---

## Proje Amacı

Bu proje, bir kargo şirketinin kargo takibi otomasyonunu sağlamak amacıyla geliştirilmiştir. Proje, kullanıcıların gönderici veya alıcı olarak kaydedilmesi, kargoların takibi, ödeme işlemleri ve kargo durumlarının güncellenmesini kapsayan bir veritabanı tasarımı içermektedir. Bu sistemde kullanılan ana bileşenler aşağıda sıralanmıştır:

- **Kullanıcı Yönetimi:** Gönderen ve alıcıların bilgileri kaydedilir.
- **Adres Yönetimi:** Kullanıcıların adres bilgileri saklanır.
- **Kargo Takibi:** Kargonun hareketleri ve güncel durumu takip edilir.
- **Ödeme Yöntemleri ve Ödemeler:** Kargo ücretlerinin ödenmesi için çeşitli ödeme yöntemleri sağlanır.
- **Şube Yönetimi:** Kargo işlemlerinin yapılacağı şubeler sisteme kaydedilir.

---

## Veritabanı Yapısı

Proje kapsamında kullanılan temel veritabanı tabloları ve her tablonun açıklamaları aşağıda sıralanmıştır:

### 1. **Users (Kullanıcılar)**

Bu tablo, kargo şirketinin sistemine kaydedilen kullanıcıları tutar. Her kullanıcının türü (Gönderen, Alıcı) ve kişisel bilgileri yer alır.

| Alan Adı    | Veri Türü            | Açıklama                                                   |
|-------------|----------------------|------------------------------------------------------------|
| **UserId**  | <span style = "color:blue">`int`                | <span style = "color:blue">**Primary Key**</span>, Kullanıcı için benzersiz numara. Bu alan her kullanıcıya özgü bir ID verir. |
| **UserType**| <span style = "color:blue">`varchar(50)`        | Kullanıcının tipi (örneğin: "Gönderen" veya "Alıcı"). Bu alan, kullanıcının sistemdeki rolünü belirler. |
| **Name**    | <span style = "color:blue">`varchar(100)`       | Kullanıcının adı. Bu alanda, kullanıcıların tam isimleri saklanır. |
| **PhoneNumber** | <span style = "color:blue">`varchar(15)`    | Kullanıcının telefon numarası. Telefon numarası formatı esnektir ve kullanıcıya ait telefon numarasını tutar. |
| **Email**   | <span style = "color:blue">`varchar(100)`       | Kullanıcının e-posta adresi. Sistemle ilgili bildirimler genellikle bu adres üzerinden yapılır. |
| **CreatedAt**| <span style = "color:blue">`DATETIME`          | Kullanıcının oluşturulma tarihi. Bu sütun, kullanıcı kaydının oluşturulduğu tarihi otomatik olarak alır. |

### 2. **Addresses (Adresler)**

Bu tablo, kullanıcıların adres bilgilerini tutar. Bir kullanıcı birden fazla adres kaydına sahip olabilir.

| Alan Adı     | Veri Türü            | Açıklama                                                      |
|--------------|----------------------|---------------------------------------------------------------|
| **AddressId**| <span style = "color:blue">`int`                | <span style = "color:blue">**Primary Key**</span>, Adres için benzersiz numara. Her adresin kendine ait bir ID'si vardır. |
| **UserId**   | <span style = "color:blue">`int`                | Kullanıcıyı ilişkilendiren ID. Bu alan, ilgili adresin hangi kullanıcıya ait olduğunu belirtir (Foreign Key). |
| **AddressLine** | <span style = "color:blue">`varchar(255)`     | Adres satırı (örneğin, cadde adı, sokak numarası vb.). Bu alan, kullanıcının adresinin tam metnini içerir. |
| **City**     | <span style = "color:blue">`varchar(100)`       | Şehir adı. Kullanıcının adresinin hangi şehirde bulunduğunu belirtir. |
| **PostalCode** | <span style = "color:blue">`varchar(10)`       | Posta kodu. Adresin bulunduğu bölgenin posta kodu bilgisini içerir. |

### 3. **ShipmentStatus (Kargo Durumu)**

Kargo takibinde kullanılan kargo durumlarını tutar (Örneğin: "Teslim Edildi", "Yolda", "Şubede").

| Alan Adı      | Veri Türü        | Açıklama                                                    |
|---------------|------------------|-------------------------------------------------------------|
| **StatusId**  | <span style = "color:blue">`int`            | <span style = "color:blue">**Primary Key**</span>, Kargo durumunun benzersiz ID'si. Her kargo durumunun kendine özgü bir ID'si vardır. |
| **StatusName**| <span style = "color:blue">`varchar(50)`    | Kargo durumunun adı. Örneğin: "Yolda", "Teslim Edildi", "Şubede" gibi kargo durumları burada saklanır. |
| **UpdatedAt** | <span style = "color:blue">`DATETIME`       | Kargo durumunun son güncellenme tarihi. Bu alan, durumun ne zaman güncellendiğini gösterir. |

### 4. **Shipments (Kargolar)**

Bu tablo, her bir kargonun gönderici ve alıcı bilgilerini, kargo fiyatını ve durumunu içerir.

| Alan Adı     | Veri Türü            | Açıklama                                                  |
|--------------|----------------------|-----------------------------------------------------------|
| **ShipmentId**| <span style = "color:blue">`int`               | <span style = "color:blue">**Primary Key**</span>, Kargo için benzersiz numara. Her kargonun kendine ait bir ID'si vardır. |
| **SenderId** | <span style = "color:blue">`int`                | <span style = "color:red">**Foreign Key**</span>, Gönderen kullanıcı ID'si. Kargonun göndereni ile ilgili bilgileri tutar. |
| **ReceiverId**| <span style = "color:blue">`int`               | <span style = "color:red">**Foreign Key**</span>, Alıcı kullanıcı ID'si. Kargonun alıcısını belirtir. |
| **Weight**   | <span style = "color:blue">`DECIMAL(5,2)`       | Kargonun ağırlığı. Kargo ağırlığı kilogram cinsinden saklanır. |
| **Size**     | <span style = "color:blue">`DECIMAL(5,2)`       | Kargonun boyutları. Kargo paketinin boyutları (genişlik, uzunluk vb.) burada saklanır. |
| **Price**    | <span style = "color:blue">`DECIMAL(10,2)`      | Kargo ücreti. Kargonun taşıma ücretini belirtir. |
| **StatusId** | <span style = "color:blue">`int`                | <span style = "color:red">**Foreign Key**</span>, Kargo durumu ID'si. Kargonun güncel durumunu belirler (ShipmentStatus(StatusId)). |
| **CreatedAt**| <span style = "color:blue">`DATETIME`           | Kargonun oluşturulma tarihi. Kargonun sisteme kaydedildiği tarihi belirtir. |

### 5. **ShipmentTracking (Kargo Takibi)**

Kargonun her bir hareketi ve durumu bu tabloda yer alır. Kargo her hareket ettiğinde bir kayıt oluşturulur.

| Alan Adı      | Veri Türü        | Açıklama                                                   |
|---------------|------------------|------------------------------------------------------------|
| **TrackingId**| <span style = "color:blue">`int`            | <span style = "color:blue">**Primary Key**</span>, Kargo takibi için benzersiz numara. Her takip kaydının kendine ait bir ID'si vardır. |
| **ShipmentId**| <span style = "color:blue">`int`            | <span style = "color:red">**Foreign Key**</span>, Kargo ID'si. Takip edilen kargonun ID'sini belirtir. |
| **Location**  | <span style = "color:blue">`varchar(100)`   | Kargonun bulunduğu konum. Kargonun hangi şehir veya şubede olduğunu belirtir. |
| **StatusId**  | <span style = "color:blue">`int`            | <span style = "color:red">**Foreign Key**</span>, Kargo durumu ID'si. Kargonun o anki durumu (ShipmentStatus(StatusId)) |
| **Timestamp** | <span style = "color:blue">`DATETIME`       | Takip kaydının oluşturulma tarihi. Kargo hareketinin zamanını gösterir. |

### 6. **PaymentMethods (Ödeme Yöntemleri)**

Kargo ücretinin ödenmesi için geçerli olan ödeme yöntemlerini tutar.

| Alan Adı      | Veri Türü        | Açıklama                                                   |
|---------------|------------------|------------------------------------------------------------|
| **PaymentMethodId**| <span style = "color:blue">`int`        | <span style = "color:blue">**Primary Key**</span>, Ödeme yöntemi için benzersiz numara. Her ödeme yönteminin kendine özgü bir ID'si vardır. |
| **MethodName**| <span style = "color:blue">`varchar(50)`    | Ödeme yönteminin adı. Örneğin: "Kredi Kartı", "Nakit" gibi seçenekler burada saklanır. |

### 7. **Payments (Ödemeler)**

Kargoların ödeme işlemlerine ait detayları içerir.

| Alan Adı      | Veri Türü        | Açıklama                                                   |
|---------------|------------------|------------------------------------------------------------|
| **PaymentId** | <span style = "color:blue">`int`            | <span style = "color:blue">**Primary Key**</span>, Ödeme için benzersiz numara. Her ödeme kaydının kendine ait bir ID'si vardır. |
| **ShipmentId**| <span style = "color:blue">`int`            | <span style = "color:red">**Foreign Key**</span>, Ödeme yapılan kargo ID'si. Kargo ile ilişkilendirilmiş ödeme kaydını belirtir. |
| **PaymentMethodId**| <span style = "color:blue">`int`       | <span style = "color:red">**Foreign Key**</span>, Ödeme yöntemi ID'si. Kullanılan ödeme yöntemini belirtir. |
| **Amount**    | <span style = "color:blue">`DECIMAL(10,2)`  | Ödeme tutarı. Kargo ücretinin ödendiği miktarı belirtir. |
| **PaidAt**    | <span style = "color:blue">`DATETIME`       | Ödemenin yapıldığı tarih. Bu alan, ödemenin alındığı zamanı gösterir. |

### 8. **Branches (Şubeler)**

Kargo işlemlerinin yapılacağı şubeleri tanımlar. Şubeler, kargo alımı, teslimatı ve işlem süreçlerinin yapıldığı yerlerdir.

| Alan Adı      | Veri Türü        | Açıklama                                                   |
|---------------|------------------|------------------------------------------------------------|
| **BranchId**  | <span style = "color:blue">`int`            | *<span style = "color:blue">**Primary Key**</span>, Şube için benzersiz numara. Her şubenin kendine özgü bir ID'si vardır. |
| **BranchName**| <span style = "color:blue">`varchar(100)`   | Şubenin adı. Bu alanda şubenin ismi saklanır. |
| **AddressId** | <span style = "color:blue">`int`            | <span style = "color:red">**Foreign Key**</span>, Şubenin adres bilgileri için bağlantılı ID. Bu sütun, şubenin adresinin saklandığı adres tablosuyla ilişkilidir. |
| **PhoneNumber**| <span style = "color:blue">`varchar(15)`    | Şube telefon numarası. Bu alanda şubenin iletişim telefon numarası yer alır. |
</br>
