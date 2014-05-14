library(stringr)
library(jsonlite)

vysledky <- data.frame(cas=as.difftime(cas, "%X", units="mins"),
                        cas_cip=as.difftime(cas_cip, "%X", units="mins"),
                        cislo,
                        jmeno,
                        kategorie,
                        klub,
                        narodnost,
                        tempo=as.difftime(tempo, "%X", units="mins"),
                        umisteni_celkove=as.numeric(umisteni_celkove),
                        umisteni_kategorie=as.numeric(umisteni_kategorie),
                        umisteni_pohlavi=as.numeric(umisteni_pohlavi))

vysledky$jmeno <- sapply(str_split(vysledky$jmeno, "Číslo: "), function (x) {return(x[1])})


vysledky$cislo <- as.numeric(str_sub(vysledky$cislo, 8))

vysledky$kategorie  <- factor(str_trim(vysledky$kategorie))



export  <- data.frame(vysledky$cas_cip, vysledky$kategorie, vysledky$narodnost)

export  <- export[export$vysledky.cas_cip>0, ]

export  <- export[export$vysledky.kategorie!="REL", ]

export$vysledky.cas_cip  <- as.numeric(export$vysledky.cas_cip)

names(export)  <- c("c", "k", "n")

writeLines(toJSON(export), "vysledky2013_cip.json")

summary(export)

range(export$c)

writeLines(toJSON(levels(export$n)), "filtr1.txt")

vysledky2013  <- fromJSON("vysledky2013.json")

vysledky2013[vysledky2013$k=="REL", ]


v2014  <- fromJSON("vysledky2014.json")

nrow(v2014[v2014$c<180,])

