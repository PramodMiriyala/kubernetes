## YAML

-   This is data representation format
-   YAML uses key value or name value pairs to represent data
-   values can be of following types
    -   simple/scalar
        -   text
        -   number
        -   bool
    -   complex
        -   list/array
        -   map/dictionary/object
-   YAML syntax is heavily inspired from python and json (javascript object notation)
-   YAML files will have extension of `.yaml` or `.yml`
-   yaml basic syntax

```
key: &lt;value&gt;
```

-   Sample YAML

```yaml
---
title: "Venom The Last Dance" # Text
year: 2024 # number
budget: 110.5 # number
imaxRelease: yes # boolean
genre: # list
  - Action
  - Adventure
  - Fantasy
  - Sci-Fi
starcast: # object
  Venom: Tom Hardy # Text
  Military Member: Chiwetel Ejiofor # Text
  Scientist: Juno Temple # Text
```

---
