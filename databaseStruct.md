## Veritabanı Yapısı

Proje içerisindeki tablolar ve yapıları aşşağıdaki gibidir.

### 1. **Users (Kullanıcılar)**

Bu tablo, kargo şirketinin sistemine kaydedilen kullanıcıları tutar. Her kullanıcının türü (Gönderen, Alıcı) ve kişisel bilgileri yer alır.

| Alan Adı        | Veri Türü      | Açıklama                                                                                                 |
| --------------- | -------------- | -------------------------------------------------------------------------------------------------------- |
| **UserId**      | `int`          | **Primary Key**, Kullanıcı için benzersiz numara.                                                        |
| **Name**        | `varchar(100)` | Kullanıcının adı.                                                                                        |
| **Surname**     | `varchar(100)` | Kullanıcının Soyadı.                                                                                     |
| **PhoneNumber** | `varchar(15)`  | **UNIQUE**, Kullanıcının telefon numarası (benzersiz).                                                   |
| **Email**       | `varchar(100)` | **UNIQUE**, Kullanıcının e-posta adresi (benzersiz).                                                     |
| **CreatedAt**   | `DATETIME`     | Kullanıcının oluşturulma tarihi. Bu sütun, kullanıcı kaydının oluşturulduğu tarihi otomatik olarak alır. |

---

### 2. **Addresses (Adresler)**

Bu tablo, kullanıcıların adres bilgilerini tutar.

| Alan Adı        | Veri Türü      | Açıklama                                                                                             |
| --------------- | -------------- | ---------------------------------------------------------------------------------------------------- |
| **AddressId**   | `int`          | **Primary Key**, Adres için benzersiz numara.                                                        |
| **AddressLine** | `varchar(255)` | Adress (örneğin, cadde adı, sokak numarası vb.). Bu alan, kullanıcının adresinin tam metnini içerir. |
| **CityId**      | `char(2)`      | **Foreign Key**. City tablosu için.                                                                  |
| **PostalCode**  | `varchar(10)`  | Posta kodu.                                                                                          |

---

### 3. **ShipmentStatus (Kargo Durumu)**

Kargo takibinde kullanılan kargo durumlarını tutar (Örneğin: "Teslim Edildi", "Yolda", "Şubede").

| Alan Adı       | Veri Türü     | Açıklama                                                                                               |
| -------------- | ------------- | ------------------------------------------------------------------------------------------------------ |
| **StatusId**   | `int`         | **Primary Key**, Kargo durumunun benzersiz ID'si.                                                      |
| **StatusName** | `varchar(50)` | Kargo durumunun adı. Örneğin: "Yolda", "Teslim Edildi", "Şubede" gibi kargo durumları burada saklanır. |

---

### 4. **Shipments (Kargolar)**

Bu tablo, her bir kargonun gönderici ve alıcı bilgilerini, kargo fiyatını ve durumunu içerir.

| Alan Adı              | Veri Türü       | Açıklama                                                                                  |
| --------------------- | --------------- | ----------------------------------------------------------------------------------------- |
| **ShipmentId**        | `int`           | **Primary Key**, Kargo için benzersiz numara.                                             |
| **SenderId**          | `int`           | **Foreign Key**, Gönderen kullanıcı ID'si. Kargonun göndereni ile ilgili bilgileri tutar. |
| **ReceiverId**        | `int`           | **Foreign Key**, Alıcı kullanıcı ID'si. Kargonun alıcısını belirtir.                      |
| **Weight**            | `DECIMAL(5,2)`  | Kargonun ağırlığı. Kargo ağırlığı kilogram cinsinden saklanır.                            |
| **Price**             | `DECIMAL(10,2)` | Kargo ücreti. Kargo ücretini ifade eder.                                                  |
| **CreatedAt**         | `DATETIME`      | Kargonun oluşturulma tarihi. Kargonun sisteme kaydedildiği tarihi belirtir.               |
| **Length**            | `DECIMAL(5,2)`  | Kargonun uzunluğu.                                                                        |
| **Width**             | `DECIMAL(5,2)`  | Kargonun genişliği.                                                                       |
| **Height**            | `DECIMAL(5,2)`  | Kargonun yüksekliği.                                                                      |
| **DimensionalWeight** | `DECIMAL(5,2)`  | Boyusal ağırlık.ücret hesabı için kullanılıyor(trigger ile otomatik hesaplanıyor)         |

---

### 5. **ShipmentTracking (Kargo Takibi)**

Kargonun her bir hareketi ve durumu bu tabloda yer alır. Kargo her hareket ettiğinde bir kayıt oluşturulur.

| Alan Adı       | Veri Türü      | Açıklama                                                                      |
| -------------- | -------------- | ----------------------------------------------------------------------------- |
| **TrackingId** | `int`          | **Primary Key**, Kargo takibi için benzersiz numara.                          |
| **ShipmentId** | `int`          | **Foreign Key**, Kargo ID'si. Takip edilen kargonun ID'sini belirtir.         |
| **Location**   | `varchar(100)` | Kargonun bulunduğu konum. Kargonun hangi şehir veya şubede olduğunu belirtir. |
| **StatusId**   | `int`          | **Foreign Key**, Kargo durumu ID'si.                                          |
| **Timestamp**  | `DATETIME`     | Kargo hareketinin zamanını gösterir.                                          |

---

### 6. **PaymentMethods (Ödeme Yöntemleri)**

Kargo ücretinin ödenmesi için geçerli olan ödeme yöntemlerini tutar.

| Alan Adı            | Veri Türü     | Açıklama                                                                               |
| ------------------- | ------------- | -------------------------------------------------------------------------------------- |
| **PaymentMethodId** | `int`         | **Primary Key**, Ödeme yöntemi için benzersiz numara.                                  |
| **MethodName**      | `varchar(50)` | Ödeme yönteminin adı. Örneğin: "Kredi Kartı", "Nakit" gibi seçenekler burada saklanır. |

---

### 7. **Payments (Ödemeler)**

Kargoların ödeme işlemlerine ait detayları içerir.

| Alan Adı            | Veri Türü  | Açıklama                                                                                        |
| ------------------- | ---------- | ----------------------------------------------------------------------------------------------- |
| **PaymentId**       | `int`      | **Primary Key**, Ödeme için benzersiz numara.                                                   |
| **ShipmentId**      | `int`      | **Foreign Key**, Ödeme yapılan kargo ID'si. Kargo ile ilişkilendirilmiş ödeme kaydını belirtir. |
| **PaymentMethodId** | `int`      | **Foreign Key**, Ödeme yöntemi ID'si. Kullanılan ödeme yöntemini belirtir.                      |
| **PaymentDate**     | `DATETIME` | Ödemenin yapıldığı tarih. Ödemenin alındığı zamanı gösterir.                                    |

---

### 3. **City (Şehirler)**

Addres tablosundaki veri tekrarını önlemek amacıyla oluşturuldu ('01',Adana)('25','Erzurum')

| Alan Adı | Veri Türü     | Açıklama                                                     |
| -------- | ------------- | ------------------------------------------------------------ |
| **code** | `char(2)`     | **Primary Key**, Şehir için plaka koduna özel benzersiz key. |
| **name** | `varchar(50)` | Şehrin adı.                                                  |

---

# Relationships

- **User -> Address**: Bir kullanıcının 1 adresi olabilir. (1:1)
- **User -> Shipment (Sender)**: Bir kullanıcı (Gönderen) birden fazla kargo gönderebilir. (1:n)
- **User -> Shipment (Receiver)**: Bir kullanıcı (Alıcı) birden fazla kargo alabilir. (1:n)
- **Shipment -> ShipmentStatus**: Her kargo bir kargo durumuna sahiptir. (n:1)
- **Shipment -> Payment**: her kargo sadece bir ödeme kaydıyla ilişkilidir. (1:1)
- **Shipment -> ShipmentTracking**: Her kargo birden fazla takip kaydına sahip olabilir. (1:n)
- **ShipmentTracking -> ShipmentStatus**: Bir kargo için sadece bir durumla ilişkilidir.(1:1)
- **Payment -> PaymentMethod**: Her ödeme bir ödeme yöntemiyle ilişkilidir. (n:1)
  </br>

# ER Diagram

</br>

![diagram](https://github.com/siyahgezegen/Cargo-Tracking/blob/main/diagram.jpg)
