---
author: M. Serhat Dundar
---

Rake Tasks
==========

- [OPTIONAL]. `setup` or `seed` already does it, but if you want to externally create YOKSIS references, departments,
  country codes etc. inside your app, run the specific tasks alone:

  ```bash
  rake -T # lists all available rake tasks, see ones categorized under import or fetch
  ```

- `fetch` prefix has used for API operations, `import` prefix has used for local CSV importing operations.
