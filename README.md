## README

This report demostrates how to generate a PDF report using `Quarto`. It utilizes both `R` and `Python` in a single document via `reticulate` package.  Configuration file named `config.yml` is required. See template below,

```json
default: 
  DB_HOST: # host url
  DB_USER: # username
  DB_PSWD: # password
  DB_NAME: # database
```

The following packages are required to run source code.  

R Packages

```
dplyr  
reticulate  
ggplot2 
```

Python Packages

```
IPython
tabulate
```


