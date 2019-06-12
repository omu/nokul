---
author(s):
  - İrfan Subaş (@isubas)
---

Dynamic Select
==============

Uygulamanızda `selectbox` türü inputlar kullanarak ilişkisel verileri görüntüleme ve seçebilme işlemlerini hızlı ve
kolay bir şekilde yapılması sağlayan yardımcı bir js modülüdür.

Temel görevi yukarıda belirtilen seçim işlemleri yapabilmek için yazmanız gereken `change` event'larını ve `ajax`
isteklerini parametrik olarak yönetmenizi sağlamaktır.

Yukarıda anlatılan görevini örneklememiz gerekirse; sayfanızda `Ülkeler`, `Şehirler` ve `İlçeler` adında 3 adet
selectbox türünde input'unuzun olduğunu varsayalım. Burada sizinde tahmin edebileceğiniz gibi ülkenin şehirleri,
şehirlerin ise ilçeleri var. Bir ülke seçildiğinde ona bağlı şehirlerin `Şehirler` selectbox'ın görüntülenmesi
gerekiyor, bu arada eğer `İlçeler` selectbox'ında veri varsa bununda sıfırlanması gerekiyor, aynı durum il seçimi içinde
geçerli.

Sayfamıza bu işlevselliği kazandırmak için aşağıda karşılaştırmalı iki örnek var.

```erb
<div class='form-group col-sm-6'>
  <%= select_tag(:country_id,
                  options_from_collection_for_select(Country.all, :id, :name),
                  class: 'form-control') %>
</div>
<div class='form-group col-sm-6'>
  <%= select_tag(:city_id,
                 [],
                 disabled: true,
                 class: 'form-control') %>
</div>
<div class='form-group col-sm-6'>
  <%= select_tag(:district_id,
                 [],
                 disabled: true,
                 class: 'form-control') %>
</div>
```

Örnek 1. DynamicSelect Kullanmadan
----------------------------------

```js

$(document).ready(function() {
  $("#country_id").change(function() {
    var country_id = $(this).val();
    if (country_id) {
      var path = '/api/v1/counties' + country_id + '/cities'
      $.getJSON(path, function(response){
        var options = '';
        $.each(response, function (index, value) {
          options += '<option value="' + value.id + '">' + value.name + '</option>';
        })
        $("#city_id").html(options);
        $('#city_id').attr("disabled", false);
      })
    }
    else {
      $("#city_id, #district_id").html('')
      $("#city_id").prepend("<option value='' selected='selected'>Place Holder</option>");
      $("#city_id, #district_id").attr('disabled', true)
    }
  });

  $("#city_id").change(function() {
    var city_id = $(this).val();
    if (city_id) {
      var path = '/api/v1/cities' + city_id + '/district'
      $.getJSON(path, function(response){
        var options = '';
        $.each(response, function (index, value) {
          options += '<option value="' + value.id + '">' + value.name + '</option>';
        })
        $("#district_id").html(options);
        $("#district_id").prepend("<option value='' selected='selected'>Place Holder</option>");
        $('#district_id').attr("disabled", false);
      })
    }
    else {
      $("#district_id").html('')
      $("#district_id").attr('disabled', true)
    }
  });
});

```

Örnek 2. DynamicSelect Kullanarak
---------------------------------

```js
$(document).ready(function() {
  var parameters = [
    {
      el: '#country_id', // Zorunlu
      target: '#city_id', // Zorunlu
      params: { 'country_id': '#country_id' }, // Kaynağa parametre geçirilecekse zorunlu
      source: '/api/locations/countries/:country_id/cities/', // Zorunlu
      reset_selectors: '#city_id, #district_id', // Opsiyonel
      placeholder: 'Şehir Seçiniz', // Opsiyonel
      after_initialize: function(){ // Opsiyonel
        var el = $(this['el'])
        if(el.val() !== '') el.trigger('change', "<%= params[:city_id]%>")
      }
    },
    {
      el: '#city_id',
      target: '#district_id',
      params: { 'city_id': '#city_id' },
      source: '/api/locations/cities/:city_id/districts',
      reset_selectors: '#district_id',
      placeholder: 'İlçe Seçiniz'
    }
  ]
  var dynamicSelectHelper = new DynamicSelect(parameters)
  dynamicSelectHelper.init()
});
```

Yukarıdaki örneklerde de görüldüğü gibi `DynamicSelect` yardımcı js mödülü kullanılarak çok daha az kodla ve anlaşılır
bir şekilde bu işlevselliği kazandırmış olduk.

DynamicSelect Parametreleri ve Kullanımı
----------------------------------------

### Genel Parametre Yapısı

```js
{
  el: '#city_id',
  target: '#district_id',
  params: { 'city_id': '#city_id' },
  source: '/api/cities/:city_id/districts',
  reset_selectors: '#reset',
  label_attribute: 'name',
  value_attribute: 'id',
  placeholder: 'Placeholder',
  after_initialize: function(){
    console.log(this.target)
    console.log(this.source)
  }
}
```

- **el** `change` event'ının tanımlanacağı elementin hangisi olacağını belirlemek için kullanılan parametredir.
  **Doldurulması zorunludur.**

- **target** `change` event'ının tetiklenmesi sonrasında bu olaydan etkilenecek elementin belirlenmesini sağlayan
  parametredir. **Doldurulması zorunludur.**

- **params** `source` belirlenirken kullanılmak istenen parametrelerin belirlenmesi sağlayan, object türünde değer alan
  bir parametredir. `source` alanına parametre geçirmek isteniyorsa **Doldurulması zorunludur.**

   **Örnek:**

   ```js
    params: {
      source_alanında_kullanılacak_key: değeri_kullanılacak_elementin_seçicisi
    }
  ```

  `source` alanında `:source_alanında_kullanılacak_key` olarak parametre geçirilebilir.

- **source** Ajax isteğin yapılacağı kaynağı belirlemek için kullanılan parametredir. `source` alanına parametre
  geçirilmek isteniyorsa `params` parametresi kullanılmalıdır. **Doldurulması zorunludur.**

- **reset_selectors** `change` event esnasında resetlenmesini istediğiniz elementlerin belirlenebildiği parametredir.
  **Opsiyoneldir.**

  Resetleme işleminde aşağıdaki kod parçacığı çalıştırılır.

  ```js
    elements.html('')
    elements.attr('disabled', true)
  ```

- **label_attribute** Ajax isteği sonucunda dönen json datasındaki hangi niteliğin option text'i olarak görüntülenmesi
  gerektiğini belirleyen parametredir. Varsayılan olarak `name` niteliği belirlenmiştir. `name` dışında farklı bir
  niteliğin görüntülenmesi gerekiyorsa, bu parametre kullanılmalıdır.

- **value_attribute** Ajax isteği sonucunda dönen json datasındaki hangi niteliğin option değeri olarak görüntülenmesi
  gerektiğini belirleyen parametredir. Varsayılan olarak `id` niteliği belirlenmiştir. `id` dışında farklı bir niteliğin
  option değeri olarak belirlenmesi gerekiyorsa, bu parametre kullanılmalıdır.

- **placeholder** `selectbox`'lara placeholder eklemek için kullanılan parametredir. Bu parametreye verilen değer
  `target` elementi içindir. **Opsiyoneldir.**

- **after_initialize** İlgili elemente `change` event'ı tanımlandıktan sonra yapılmasını istediğiniz işlemleri bir
  fonksiyon halinde belirterek çalıştırmanızı sağlar. `after_initialize` değer olarak her zaman bir fonksiyon bekler.
  Fonksiyon içerisinde `this` ile parametre değerlerine erişebilirsiniz. **Opsiyoneldir.**
