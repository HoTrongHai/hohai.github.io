+++
title = 'Clean Code (Part 2)'
date = 2023-11-03
+++

### Comments

> Don’t comment bad code—rewrite it.

```java
// Check to see if the employee is eligible for full benefits
if ((employee.flags & HOURLY_FLAG) && (employee.age > 65))
```

or

```java
if (employee.isEligibleForFullBenefits())
```

### Classes

```java
public class Sql {
    public Sql(String table, Column[] columns)
    public String create()
    public String insert(Object[] fields)
    public String selectAll()
    public String findByKey(String keyColumn, String keyValue)
    public String select(Column column, String pattern)
    public String select(Criteria criteria)
    public String preparedInsert()
    private String columnList(Column[] columns)
    private String valuesList(Object[] fields, final Column[] columns)
    private String selectWithCriteria(String criteria)
    private String placeholderList(Column[] columns)
}
```

- Reason to change - `Sql` will change when adding new type. - Modify `select` to support subqueries
  **Violate SRP**

- Solution:

```java
abstract public class Sql {
    public Sql(String table, Column[] columns)
    abstract public String generate();
}
public class CreateSql extends Sql {
    public CreateSql(String table, Column[] columns)
    @Override public String generate()
}
public class SelectSql extends Sql {
    public SelectSql(String table, Column[] columns)
    @Override public String generate()
}
public class InsertSql extends Sql {
    public InsertSql(String table, Column[] columns, Object[] fields)
    @Override public String generate()
    private String valuesList(Object[] fields, final Column[] columns)
}
public class SelectWithCriteriaSql extends Sql {
    public SelectWithCriteriaSql(
        String table, Column[] columns, Criteria criteria)
    @Override public String generate()
}
public class SelectWithMatchSql extends Sql {
    public SelectWithMatchSql(
        String table, Column[] columns, Column column, String pattern)
    @Override public String generate()
}
public class FindByKeySql extends Sql {
    public FindByKeySql(
        String table, Column[] columns, String keyColumn, String keyValue)
    @Override public String generate()
}
public class PreparedInsertSql extends Sql {
    public PreparedInsertSql(String table, Column[] columns)
    @Override public String generate() {
        private String placeholderList(Column[] columns)
    }
    public class Where {
        public Where(String criteria)
        public String generate()
    }
    public class ColumnList {
        public ColumnList(Column[] columns)
        public String generate()
    }
}
```

### Seperate of main

```javascript
// Seperate of main: the main only care the config (how to setting config to run)
function main() {
  function build() {
    return new Builder();
  }

  function run() {
    const configObj = build().create();
    const app = new Application(configObj);
    app.run();
  }

  return run;
}

class Builder {
  create() {
    return new ConfigObject("A", "B");
  }
}

class ConfigObject {
  constructor(setting1, setting2) {
    this.setting1 = setting1;
    this.setting2 = setting2;
  }
}

// Seperate of concern: the application only care the ConfigObject
class Application {
  constructor(configObj) {
    this.configObj = configObj;
  }

  run() {
    console.log("App running with config: ", this.configObj);
  }
}

main()();

main()();
```

![](./SeperateOfConcern.pdf)
