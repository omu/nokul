# Rake Tasks

- [OPTIONAL]. `setup` or `seed` already does it, but if you want to externally create YOKSIS references, departments, country codes and academic staffs inside your app, run the tasks shown below:

```bash
rake yoksis:fetch_references
rake yoksis:fetch_academic_staff
rake yoksis:import_departments
rake yoksis:import_yoksis_country_codes
```

* `fetch` prefix has used for API operations, `import` prefix has used for local CSV importing operations.
