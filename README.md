📂 Klasör Yapısı

lib/_features: Uygulamanın ana modüllerini (Features) barındırır.

presentation: Kullanıcı arayüzü (View) ve iş mantığı (ViewModel) katmanıdır. Her özellik (örn: home, product_detail), kendi View ve ViewModel dosyalarını içerir.

data: API yanıt modelleri (response) ve özelliklere özgü enum'ları (enums) içerir.

lib/_core: Proje genelinde paylaşılan altyapı kodlarını içerir.

base: BaseViewModel gibi temel sınıflar.

services: API çağrılarını yapan servisler (örn: ShopifyServices) ve genel uygulama servisleri.

network: Ağ katmanı yapılandırmaları.

utils: Ortak yardımcı fonksiyonlar ve sabitler.

lib/app: Uygulama konfigürasyonu, ServiceLocator (DI) ve rotalamayı (Routes) yönetir.

🛠️ Teknolojiler & Yaklaşımlar
State Management: flutter_riverpod (AsyncNotifierProvider kullanımı).
Dependency Injection: get_it ile servis yönetimi.
Mimari Desen: ViewModeller doğrudan servisler (_core/services) ile haberleşerek veriyi View katmanına taşır.

AYRICA FARKLI DİLLER İÇİN OLASI ENTEGRASYON DOSYASI Assets klasöründe mevcuttur.