# **Kargo Takip Otomasyonu**

> Bu repository, **Fırat Üniversitesi Bilgisayar Mühendisliği** bölümü **Veri Tabanı Sistemleri** dersi için hazırlanmıştır.

</br>

## Proje Ekibi

>- **Ömer Karaman**
>- **Ahmet Yasin Durakcı**
</br>

## Proje Amacı

Bu proje, bir kargo şirketinin kargo takibi otomasyonunu sağlamak amacıyla tasarlandı. 
Proje, kullanıcıların gönderici veya alıcı olarak kaydedilmesi, kargo takibi, ödeme işlemleri ve kargo durumlarının güncellenmesini kapsıyor.

- **Kullanıcı Yönetimi:** Gönderen ve alıcıların bilgileri kaydedilir.
- **Adres Yönetimi:** Kullanıcıların adres bilgileri saklanır.
- **Kargo Takibi:** Kargonun hareketleri ve güncel durumu takip edilir.
- **Ödeme Yöntemleri ve Ödemeler:** Kargo ücretlerinin ödenmesi için çeşitli ödeme yöntemleri sağlanır.
- **Şube Yönetimi:** Kargo işlemlerinin yapılacağı şubeler sisteme kaydedilir.

---

## Veritabanı Yapısı

Proje içerisindeki tablolar ve yapıları aşşağıdaki gibidir.

### 1. **Users (Kullanıcılar)**

Bu tablo, kargo şirketinin sistemine kaydedilen kullanıcıları tutar. Her kullanıcının türü (Gönderen, Alıcı) ve kişisel bilgileri yer alır.

| Alan Adı    | Veri Türü            | Açıklama                                                   |
|-------------|----------------------|------------------------------------------------------------|
| **UserId**  | `int`                | **Primary Key**, Kullanıcı için benzersiz numara.      |
| **UserType**| `varchar(50)`        | Kullanıcının tipi (örneğin: "Gönderen" veya "Alıcı"). Bu alan, kullanıcının sistemdeki rolünü belirler. |
| **Name**    | `varchar(100)`       | Kullanıcının adı. |
| **PhoneNumber** | `varchar(15)`    | Kullanıcının telefon numarası.  |
| **Email**   | `varchar(100)`       | Kullanıcının e-posta adresi.  |
| **CreatedAt**| `DATETIME`          | Kullanıcının oluşturulma tarihi. Bu sütun, kullanıcı kaydının oluşturulduğu tarihi otomatik olarak alır. |

---


### 2. **Addresses (Adresler)**

Bu tablo, kullanıcıların adres bilgilerini tutar.

| Alan Adı     | Veri Türü            | Açıklama                                                      |
|--------------|----------------------|---------------------------------------------------------------|
| **AddressId**| `int`                | **Primary Key**, Adres için benzersiz numara. |
| **UserId**   | `int`                | Kullanıcıyı ilişkilendiren ID. Bu alan, ilgili adresin hangi kullanıcıya ait olduğunu belirtir. |
| **AddressLine** | `varchar(255)`     | Adress (örneğin, cadde adı, sokak numarası vb.). Bu alan, kullanıcının adresinin tam metnini içerir. |
| **City**     | `varchar(100)`       | Şehir adı.  |
| **PostalCode** | `varchar(10)`       | Posta kodu.|

---


### 3. **ShipmentStatus (Kargo Durumu)**

Kargo takibinde kullanılan kargo durumlarını tutar (Örneğin: "Teslim Edildi", "Yolda", "Şubede").

| Alan Adı      | Veri Türü        | Açıklama                                                    |
|---------------|------------------|-------------------------------------------------------------|
| **StatusId**  | `int`            | **Primary Key**, Kargo durumunun benzersiz ID'si.|
| **StatusName**| `varchar(50)`    | Kargo durumunun adı. Örneğin: "Yolda", "Teslim Edildi", "Şubede" gibi kargo durumları burada saklanır. |
| **UpdatedAt** | `DATETIME`       | Kargo durumunun son güncellenme tarihi. Bu alan, durumun ne zaman güncellendiğini gösterir. |

---


### 4. **Shipments (Kargolar)**

Bu tablo, her bir kargonun gönderici ve alıcı bilgilerini, kargo fiyatını ve durumunu içerir.

| Alan Adı     | Veri Türü            | Açıklama                                                  |
|--------------|----------------------|-----------------------------------------------------------|
| **ShipmentId**| `int`               | **Primary Key**, Kargo için benzersiz numara.  |
| **SenderId** | `int`                | **Foreign Key**, Gönderen kullanıcı ID'si. Kargonun göndereni ile ilgili bilgileri tutar. |
| **ReceiverId**| `int`               | **Foreign Key**, Alıcı kullanıcı ID'si. Kargonun alıcısını belirtir. |
| **Weight**   | `DECIMAL(5,2)`       | Kargonun ağırlığı. Kargo ağırlığı kilogram cinsinden saklanır. |
| **Size**     | `DECIMAL(5,2)`       | Kargonun boyutları. Kargo paketinin boyutları burada saklanır. |
| **Price**    | `DECIMAL(10,2)`      | Kargo ücreti. Kargo ücretini ifade eder. |
| **StatusId** | `int`                | **Foreign Key**, Kargo durumu ID'si. Kargonun güncel durumunu belirler. |
| **CreatedAt**| `DATETIME`           | Kargonun oluşturulma tarihi. Kargonun sisteme kaydedildiği tarihi belirtir. |

---


### 5. **ShipmentTracking (Kargo Takibi)**

Kargonun her bir hareketi ve durumu bu tabloda yer alır. Kargo her hareket ettiğinde bir kayıt oluşturulur.

| Alan Adı      | Veri Türü        | Açıklama                                                   |
|---------------|------------------|------------------------------------------------------------|
| **TrackingId**| `int`            | **Primary Key**, Kargo takibi için benzersiz numara. |
| **ShipmentId**| `int`            | **Foreign Key**, Kargo ID'si. Takip edilen kargonun ID'sini belirtir. |
| **Location**  | `varchar(100)`   | Kargonun bulunduğu konum. Kargonun hangi şehir veya şubede olduğunu belirtir. |
| **StatusId**  | `int`            | **Foreign Key**, Kargo durumu ID'si. |
| **Timestamp** | `DATETIME`       | Kargo hareketinin zamanını gösterir. |

---


### 6. **PaymentMethods (Ödeme Yöntemleri)**

Kargo ücretinin ödenmesi için geçerli olan ödeme yöntemlerini tutar.

| Alan Adı      | Veri Türü        | Açıklama                                                   |
|---------------|------------------|------------------------------------------------------------|
| **PaymentMethodId**| `int`        | **Primary Key**, Ödeme yöntemi için benzersiz numara. |
| **MethodName**| `varchar(50)`    | Ödeme yönteminin adı. Örneğin: "Kredi Kartı", "Nakit" gibi seçenekler burada saklanır. |

---


### 7. **Payments (Ödemeler)**

Kargoların ödeme işlemlerine ait detayları içerir.

| Alan Adı      | Veri Türü        | Açıklama                                                   |
|---------------|------------------|------------------------------------------------------------|
| **PaymentId** | `int`            | **Primary Key**, Ödeme için benzersiz numara.  |
| **ShipmentId**| `int`            | **Foreign Key**, Ödeme yapılan kargo ID'si. Kargo ile ilişkilendirilmiş ödeme kaydını belirtir. |
| **PaymentMethodId**| `int`       | **Foreign Key**, Ödeme yöntemi ID'si. Kullanılan ödeme yöntemini belirtir. |
| **Amount**    | `DECIMAL(10,2)`  | Ödeme tutarı. Kargo ücretinin ödendiği miktarı belirtir. |
| **PaidAt**    | `DATETIME`       | Ödemenin yapıldığı tarih. Ödemenin alındığı zamanı gösterir. |

---


### 8. **Branches (Şubeler)**

Kargo işlemlerinin yapılacağı şubeleri tanımlar. Şubeler, kargo alımı, teslimatı ve işlem süreçlerinin yapıldığı yerlerdir.

| Alan Adı      | Veri Türü        | Açıklama                                                   |
|---------------|------------------|------------------------------------------------------------|
| **BranchId**  | `int`            | **Primary Key**, Şube için benzersiz numara.  |
| **BranchName**| `varchar(100)`   | Şubenin adı. Bu alanda şubenin ismi saklanır. |
| **AddressId** | `int`            | **Foreign Key**, Şubenin adres bilgileri için bağlantılı ID. Bu sütun, şubenin adresinin saklandığı adres tablosuyla ilişkilidir. |
| **PhoneNumber**| `varchar(15)`    | Şube telefon numarası. Bu alanda şubenin iletişim telefon numarası yer alır. |

---

# Relationships

- **User -> Address**: Bir kullanıcının 1 adresi olabilir. (1:1)
- **User -> Shipment (Sender)**: Bir kullanıcı (Gönderen) birden fazla kargo gönderebilir. (1:n)
- **User -> Shipment (Receiver)**: Bir kullanıcı (Alıcı) birden fazla kargo alabilir. (1:n)
- **Shipment -> ShipmentStatus**: Her kargo bir kargo durumuna sahiptir. (n:1)
- **Shipment -> Payment**: her kargo sadece bir ödeme kaydıyla ilişkilidir. (1:1)
- **Shipment -> ShipmentTracking**: Her kargo birden fazla takip kaydına sahip olabilir. (1:n)
- **ShipmentTracking -> ShipmentStatus**: Bir  kargo için sadece bir durumla ilişkilidir.(1:1)
- **Payment -> PaymentMethod**: Her ödeme bir ödeme yöntemiyle ilişkilidir. (n:1)
- **Branch -> Address**: Her şube bir adresle ilişkilidir. (1:1)
</br>

# ER Diagram 

</br>

![diagram](https://github.com/siyahgezegen/Cargo-Tracking/blob/main/diagram.jpg)
