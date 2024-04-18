+++
title = 'SOLID Principles'
date = 2023-10-03
+++

### Single Responsibility

- The class only have one reason to **change**

```js
class Payroll {
  payFor(employee: Employee) {}
}

class Employee {
  CalcPay() {}
  ReportHours() {}
  WriteEmploye() {}
}
```

- How many reason does this class have to **change** ?
- How many sources of **change** ?
  Then the `Employee` class should have 3 different responsibilities.
  3 methods should be long 3 classes

```js
class Payroll {
  payFor(employee: Employee) {}
}

class Employee {
  CalcPay() {}
}

class ReportWrite {
  writeReport(employee: Employee) {}
}

class EmployeeRepository {
  save(employee: Employee) {}
}
```
