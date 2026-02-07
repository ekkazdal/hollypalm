# hollypalm

A new Flutter project.

## 🏗️ Mimari Yaklaşım ve Dosya Yapısı

Proje, ölçeklenebilirliği, test edilebilirliği ve bakım kolaylığını sağlamak amacıyla **MVVM (Model-View-ViewModel)** mimarisi ve **Feature-First (Özellik Bazlı)** klasörleme yapısı ile geliştirilmiştir.

### Katmanlar

*   **Presentation Layer (`lib/_features/*/presentation`)**:
    *   Kullanıcı arayüzü (View) ve durum yönetimi (ViewModel) bu katmanda bulunur.
    *   Her özellik (Home, Product Detail vb.) kendi klasöründe izole edilmiştir.
    *   View, sadece veriyi göstermekle yükümlüdür; iş mantığı içermez.
    *   ViewModel, servislerden veriyi alır, işler ve View'ın dinlediği bir State'e dönüştürür.
*   **Data Layer (`lib/_features/*/data`)**:
    *   API yanıt modelleri (`Response Models`) ve Enums burada tanımlanır.
    *   Bu katman, dış dünyadan gelen verinin uygulama içinde kullanılan modellere dönüştürüldüğü yerdir.
*   **Core Layer (`lib/_core`)**:
    *   **Services**: API haberleşmesini sağlayan soyutlamalar (ör. `ShopifyServices`).
    *   **Base**: `BaseViewModel` gibi katmanlar arası ortak yapıtaşları.
    *   **Utils**: Tema, sabitler ve yardımcı fonksiyonlar.

### Klasör Hiyerarşisi
- `_features/`: Modüller (Home, Product Detail).
- `_core/`: Paylaşılan çekirdek yapı (Network, Theme, Base classes).
- `app/`: Uygulama konfigürasyonu, DI (Service Locator) ve Rotalama.

---

## ⚡ Riverpod Kullanım Gerekçesi

Bu projede State Management çözümü olarak **Riverpod** tercih edilmiştir.

1.  **AsyncNotifierProvider & AsyncValue**:
    *   Ağ isteklerinin (Network Requests) asenkron doğasını yönetmek için idealdir.
    *   `Loading`, `Error` ve `Data` durumlarını (states) manuel flag'ler yerine `AsyncValue` pattern'i ile tip güvenli bir şekilde yönetmeyi sağlar.
2.  **Test Edilebilirlik**:
    *   Provider'ların override edilebilmesi sayesinde, entegrasyon ve birim testlerinde mock servislerin enjekte edilmesi kolaylaşır.
3.  **Dependency Injection ile Uyumluluk**:
    *   `GetIt` ile servis katmanını yönetirken, Riverpod ile UI katmanındaki reaktif durum yönetimi verimli bir şekilde ayrıştırılmıştır.
4.  **Performans**:
    *   Sadece ilgili widget'ların yeniden çizilmesini (rebuild) sağlayarak performans optimizasyonu sunar.

---

## 🛍️ Shopify API Entegrasyon Stratejisi

Shopify entegrasyonu, ağır SDK'ler yerine **Doğrudan GraphQL** kullanılarak optimize edilmiştir.

*   **GraphQL Kullanımı**:
    *   REST yerine GraphQL tercih edilerek, sadece ihtiyaç duyulan verilerin çekilmesi sağlanmıştır (Over-fetching önlenmiştir).
    *   Örnek: Ürün listesinde sadece resim, başlık ve fiyat çekilirken; detayda varyantlar ve açıklamalar çekilir.
*   **Dio & Custom Service**:
    *   Ağ istekleri için `Dio` kütüphanesi yapılandırılmış, üzerine `ShopifyGraphQLService` katmanı inşa edilmiştir.
    *   `ShopifyServices` sınıfı, ham GraphQL sorgularını (`queries`) ve mutasyonlarını (`mutations`) barındırır ve bunları tip güvenli Dart modellerine (`Response Models`) dönüştürür.
*   **Sepet Yönetimi**:
    *   Sepet oluşturma (`cartCreate`) ve satır ekleme (`cartLinesAdd`) işlemleri atomik mutasyonlarla yönetilir.

---

UX (Kullanıcı Deneyimi) Kararları

Kullanıcı deneyimini en üst düzeyde tutmak için aşağıdaki tasarım kararları uygulanmıştır:

*   **Optimistik UI ve Yüklenme Durumları**:
    *   Görseller yüklenirken boşluk hissini yok etmek için placeholder konteynerler ve yüklenme indikatörleri kullanılır (`Image.network` loadingBuilder).
    *   API istekleri sırasında kullanıcıya anlık geri bildirim vermek için `AsyncLoading` durumları aktif olarak kullanılır.
*   **Hata Yönetimi (Graceful Degradation)**:
    *   Görsel yüklenemediğinde veya veri çekilemediğinde uygulama çökmez; kullanıcıya "image not supported" ikonu veya bilgilendirici hata mesajları gösterilir.
*   **Özel Tasarım Sistemi (HollyTheme)**:
    *   Standart Material bileşenleri yerine, markaya özgü `HollyText` ve `HollyColor` yapıları kullanılarak tutarlı bir tipografi ve renk paleti sağlanmıştır.
*   **Varyant Gösterimi**:
    *   Ürün kartlarında varyantlar (renk/seçenek) sadece metin olarak değil, varsa görselleriyle birlikte yatay bir liste olarak sunularak kullanıcının ürünü keşfetmesi kolaylaştırılmıştır.


    EKSTRA OLARAK FARKLI DİLLER İÇİN OLASI DİL DOSYASI Assets klasöründe mevcuttur.