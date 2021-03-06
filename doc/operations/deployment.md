---
author(s):
  - M. Serhat Dundar (@msdundar)
---

Dokku
=====

Nadiren dahi olsa uygulamanın deploy edildiği makinaya operatör olarak erişmeniz gerekebilir. Makinaya erişim sağlamadan
önce **geçerli bir sebebiniz** olduğundan emin olun. Ne yaptığınızdan emin değilseniz [sistem
grubu](https://github.com/orgs/omu/teams/ops) ile iletişime geçin. Dokku instance'ına erişmenin sıkça kullanılan iki
yolu vardır.

dokku-cli ile (tercih edilen)
-----------------------------

```bash
gem install dokku-cli
git remote add beta dokku@app.omu.sh:nokul
```

Daha sonra `--remote-beta` ile komutları çalıştırabilirsiniz:

```bash
dokku run rails c --remote=beta
dokku run rake some_namespace:some_rake_task --remote=beta
```

Operatör olarak
---------------

```bash
ssh op@193.140.28.240
dokku enter nokul web
```

Local Dokku Deployment
----------------------

```bash
vagrant up paas --provider=virtualbox
RAILS_MASTER_KEY=xxxxxxxxx vagrant provision paas # only on the first deploy
git push --no-verify dokku <branch_adı>:master
dokku run rails db:seed SAMPLE_DATA=true
```
