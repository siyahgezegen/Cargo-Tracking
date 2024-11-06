# **Kargo Takip Otomasyonu**

> Bu repository, **Fırat Üniversitesi Bilgisayar Mühendisliği** bölümü **Veri Tabanı Sistemleri** dersi için hazırlanmıştır.

</br>

## Proje Ekibi

>- **Ömer Karaman**
>- **Ahmet Yasin Durakcı**
</br>

## Proje Amacı

Bu proje, bir kargo şirketinin kargo takibi otomasyonunu sağlamak amacıyla tasarlandı. 
Proje, kullanıcıların gönderici veya alıcı olarak kaydedilmesi, kargo takibi, ödeme işlemleri ve kargo durumlarının güncellenmesini kapsayan bir veritabanı tasarımı içermektedir.

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
| **UserId**  | `int`                | **Primary Key**, Kullanıcı için benzersiz numara. Bu alan her kullanıcıya özgü bir ID verir. |
| **UserType**| `varchar(50)`        | Kullanıcının tipi (örneğin: "Gönderen" veya "Alıcı"). Bu alan, kullanıcının sistemdeki rolünü belirler. |
| **Name**    | `varchar(100)`       | Kullanıcının adı. Bu alanda, kullanıcıların tam isimleri saklanır. |
| **PhoneNumber** | `varchar(15)`    | Kullanıcının telefon numarası. Telefon numarası formatı esnektir ve kullanıcıya ait telefon numarasını tutar. |
| **Email**   | `varchar(100)`       | Kullanıcının e-posta adresi. Sistemle ilgili bildirimler genellikle bu adres üzerinden yapılır. |
| **CreatedAt**| `DATETIME`          | Kullanıcının oluşturulma tarihi. Bu sütun, kullanıcı kaydının oluşturulduğu tarihi otomatik olarak alır. |

### 2. **Addresses (Adresler)**

Bu tablo, kullanıcıların adres bilgilerini tutar. Bir kullanıcı birden fazla adres kaydına sahip olabilir.

| Alan Adı     | Veri Türü            | Açıklama                                                      |
|--------------|----------------------|---------------------------------------------------------------|
| **AddressId**| `int`                | **Primary Key**, Adres için benzersiz numara. Her adresin kendine ait bir ID'si vardır. |
| **UserId**   | `int`                | Kullanıcıyı ilişkilendiren ID. Bu alan, ilgili adresin hangi kullanıcıya ait olduğunu belirtir (Foreign Key). |
| **AddressLine** | `varchar(255)`     | Adres satırı (örneğin, cadde adı, sokak numarası vb.). Bu alan, kullanıcının adresinin tam metnini içerir. |
| **City**     | `varchar(100)`       | Şehir adı. Kullanıcının adresinin hangi şehirde bulunduğunu belirtir. |
| **PostalCode** | `varchar(10)`       | Posta kodu. Adresin bulunduğu bölgenin posta kodu bilgisini içerir. |

### 3. **ShipmentStatus (Kargo Durumu)**

Kargo takibinde kullanılan kargo durumlarını tutar (Örneğin: "Teslim Edildi", "Yolda", "Şubede").

| Alan Adı      | Veri Türü        | Açıklama                                                    |
|---------------|------------------|-------------------------------------------------------------|
| **StatusId**  | `int`            | **Primary Key**, Kargo durumunun benzersiz ID'si. Her kargo durumunun kendine özgü bir ID'si vardır. |
| **StatusName**| `varchar(50)`    | Kargo durumunun adı. Örneğin: "Yolda", "Teslim Edildi", "Şubede" gibi kargo durumları burada saklanır. |
| **UpdatedAt** | `DATETIME`       | Kargo durumunun son güncellenme tarihi. Bu alan, durumun ne zaman güncellendiğini gösterir. |

### 4. **Shipments (Kargolar)**

Bu tablo, her bir kargonun gönderici ve alıcı bilgilerini, kargo fiyatını ve durumunu içerir.

| Alan Adı     | Veri Türü            | Açıklama                                                  |
|--------------|----------------------|-----------------------------------------------------------|
| **ShipmentId**| `int`               | **Primary Key**, Kargo için benzersiz numara. Her kargonun kendine ait bir ID'si vardır. |
| **SenderId** | `int`                | **Foreign Key**, Gönderen kullanıcı ID'si. Kargonun göndereni ile ilgili bilgileri tutar. |
| **ReceiverId**| `int`               | **Foreign Key**, Alıcı kullanıcı ID'si. Kargonun alıcısını belirtir. |
| **Weight**   | `DECIMAL(5,2)`       | Kargonun ağırlığı. Kargo ağırlığı kilogram cinsinden saklanır. |
| **Size**     | `DECIMAL(5,2)`       | Kargonun boyutları. Kargo paketinin boyutları (genişlik, uzunluk vb.) burada saklanır. |
| **Price**    | `DECIMAL(10,2)`      | Kargo ücreti. Kargonun taşıma ücretini belirtir. |
| **StatusId** | `int`                | **Foreign Key**, Kargo durumu ID'si. Kargonun güncel durumunu belirler (ShipmentStatus(StatusId)). |
| **CreatedAt**| `DATETIME`           | Kargonun oluşturulma tarihi. Kargonun sisteme kaydedildiği tarihi belirtir. |

### 5. **ShipmentTracking (Kargo Takibi)**

Kargonun her bir hareketi ve durumu bu tabloda yer alır. Kargo her hareket ettiğinde bir kayıt oluşturulur.

| Alan Adı      | Veri Türü        | Açıklama                                                   |
|---------------|------------------|------------------------------------------------------------|
| **TrackingId**| `int`            | **Primary Key**, Kargo takibi için benzersiz numara. Her takip kaydının kendine ait bir ID'si vardır. |
| **ShipmentId**| `int`            | **Foreign Key**, Kargo ID'si. Takip edilen kargonun ID'sini belirtir. |
| **Location**  | `varchar(100)`   | Kargonun bulunduğu konum. Kargonun hangi şehir veya şubede olduğunu belirtir. |
| **StatusId**  | `int`            | **Foreign Key**, Kargo durumu ID'si. Kargonun o anki durumu (ShipmentStatus(StatusId)) |
| **Timestamp** | `DATETIME`       | Takip kaydının oluşturulma tarihi. Kargo hareketinin zamanını gösterir. |

### 6. **PaymentMethods (Ödeme Yöntemleri)**

Kargo ücretinin ödenmesi için geçerli olan ödeme yöntemlerini tutar.

| Alan Adı      | Veri Türü        | Açıklama                                                   |
|---------------|------------------|------------------------------------------------------------|
| **PaymentMethodId**| `int`        | **Primary Key**, Ödeme yöntemi için benzersiz numara. Her ödeme yönteminin kendine özgü bir ID'si vardır. |
| **MethodName**| `varchar(50)`    | Ödeme yönteminin adı. Örneğin: "Kredi Kartı", "Nakit" gibi seçenekler burada saklanır. |

### 7. **Payments (Ödemeler)**

Kargoların ödeme işlemlerine ait detayları içerir.

| Alan Adı      | Veri Türü        | Açıklama                                                   |
|---------------|------------------|------------------------------------------------------------|
| **PaymentId** | `int`            | **Primary Key**, Ödeme için benzersiz numara. Her ödeme kaydının kendine ait bir ID'si vardır. |
| **ShipmentId**| `int`            | **Foreign Key**, Ödeme yapılan kargo ID'si. Kargo ile ilişkilendirilmiş ödeme kaydını belirtir. |
| **PaymentMethodId**| `int`       | **Foreign Key**, Ödeme yöntemi ID'si. Kullanılan ödeme yöntemini belirtir. |
| **Amount**    | `DECIMAL(10,2)`  | Ödeme tutarı. Kargo ücretinin ödendiği miktarı belirtir. |
| **PaidAt**    | `DATETIME`       | Ödemenin yapıldığı tarih. Bu alan, ödemenin alındığı zamanı gösterir. |

### 8. **Branches (Şubeler)**

Kargo işlemlerinin yapılacağı şubeleri tanımlar. Şubeler, kargo alımı, teslimatı ve işlem süreçlerinin yapıldığı yerlerdir.

| Alan Adı      | Veri Türü        | Açıklama                                                   |
|---------------|------------------|------------------------------------------------------------|
| **BranchId**  | `int`            | **Primary Key**, Şube için benzersiz numara. Her şubenin kendine özgü bir ID'si vardır. |
| **BranchName**| `varchar(100)`   | Şubenin adı. Bu alanda şubenin ismi saklanır. |
| **AddressId** | `int`            | **Foreign Key**, Şubenin adres bilgileri için bağlantılı ID. Bu sütun, şubenin adresinin saklandığı adres tablosuyla ilişkilidir. |
| **PhoneNumber**| `varchar(15)`    | Şube telefon numarası. Bu alanda şubenin iletişim telefon numarası yer alır. |

---

# Relationships

- **User -> Address**: Bir kullanıcının 1 adresi olabilir. (1:1)
- **User -> Shipment (Sender)**: Bir kullanıcı (Gönderen) birden fazla kargo gönderebilir. (1:n)
- **User -> Shipment (Receiver)**: Bir kullanıcı (Alıcı) birden fazla kargo alabilir. (1:n)
- **Shipment -> ShipmentStatus**: Her kargo bir kargo durumuna sahiptir. (n:1)
- **Shipment -> Payment**: Her kargo bir ödeme kaydıyla ilişkilidir. (1:1)
- **Shipment -> ShipmentTracking**: Her kargo birden fazla takip kaydına sahip olabilir. (1:n)
- **Payment -> PaymentMethod**: Her ödeme bir ödeme yöntemiyle ilişkilidir. (n:1)
- **Branch -> Address**: Her şube bir adresle ilişkilidir. (1:1)

