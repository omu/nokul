### Apache Directory Studio

Özellikle geliştirme aşamasında ApacheDS aracı, ağacı görmek ve düzenlemek için
kullanışlı bir araç.

Kurulum:

ApacheDS'nin çalışması için Java'ya ihtiyaç duyuluyor.

Oracle Java 8 kurulumu için:

```
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get install oracle-java8-installer
```

ApacheDS kurulumunu depolardan yapamıyoruz çünkü systemctl ile düzgün
çalışmıyor. [BUG](https://bugs.launchpad.net/ubuntu/+source/apache-directory-server/+bug/1676035)

[Download](https://directory.apache.org/studio/download/download-linux.html)
sayfasından 64 bit sürümü seçip indirip .tar.gz dosyasındakileri çıkarın.

```
cd Downloads
tar -xvzf *.tar.gz
sudo mv ApacheDirectoryStudio /opt/
sudo ln -s /opt/ApacheDirectoryStudio/ApacheDirectoryStudio /usr/local/bin/ApacheDirectoryStudio
```

### Şema Ekleme

eduPerson şemasını ekleme:

```
sudo cp /vagrant/şemalar/eduperson.schema /etc/ldap/schema
# ortalık kirlenmesin
cd /tmp
echo "include /etc/ldap/schema/eduperson.schema" > eduperson_schema.conf
```

şemanın indeksini öğrenme:

```
slapcat -f eduperson_schema.conf -F . -n 0 | grep eduperson,cn=schema
cn={0}eduperson,cn=schema,cn=config
```

ldif dosyası üret:

```
slapcat -f eduperson_schema.conf -F . -n0 -H ldap:///cn={0}eduperson,cn=schema,cn=config -l cn=eduperson.ldif
```


cn=eduperson.ldif dosyasının alt satırlarında bulunan aşağıdaki alanlar silinir:

```
structuralObjectClass:
entryUUID:
creatorsName:
createTimestamp:
entryCSN:
modifiersName:
modifyTimestamp:
```

dn ve cn alanlarındaki {0} kısımları silinmelidir.

şemayı ekle

```
sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f cn\=eduperson.ldif
```

Teyit:

```
sudo ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=schema,cn=config dn
```

### LDAP Arama Kuralları

[Tıklayın](https://support.google.com/a/answer/6126589)

