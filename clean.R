library(stringr)
library(jsonlite)

vysledky <- data.frame(cas=as.difftime(cas, "%X", units="secs"),
                        cas_cip=as.difftime(cas_cip, "%X", units="secs"),
                        cislo,
                        jmeno,
                        kategorie,
                        klub,
                        narodnost,
                        tempo=as.difftime(tempo, "%X", units="secs"),
                        umisteni_celkove=as.numeric(umisteni_celkove),
                        umisteni_kategorie=as.numeric(umisteni_kategorie),
                        umisteni_pohlavi=as.numeric(umisteni_pohlavi))

vysledky$jmeno <- sapply(str_split(vysledky$jmeno, "Číslo: "), function (x) {return(x[1])})


vysledky$cislo <- as.numeric(str_sub(vysledky$cislo, 8))

vysledky$kategorie  <- factor(str_trim(vysledky$kategorie))

export  <- data.frame(vysledky$cas, vysledky$kategorie, vysledky$narodnost)

export  <- export[export$vysledky.cas>0, ]

export$vysledky.cas  <- as.numeric(export$vysledky.cas)

names(export)  <- c("c", "k", "n")

writeLines(toJSON(export), "vysledky2013.json")
