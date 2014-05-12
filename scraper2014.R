require(devtools)
require(XML)
require(relenium)
require(stringr)
require(jsonlite)

vysledky  <- readHTMLTable("all.html", encoding="utf-8")

vysledky  <- vysledky[[1]]


vysledky(names)

names(vysledky)  <- c("poradi", "cislo", "jmeno", "klub", "narodnost", "kategorie", "cas", "skutecny_cas")

narodnost  <- xpathSApply(htmlParse("all.html"), "//img", xmlAttrs)

narodnost  <- narodnost[2,]

vysledky[5497:5505,]

narodnost[5502:5505]

narodnost2  <- c(narodnost[1:5501], NA, narodnost[5502:6038])

vysledky  <- cbind(vysledky, narodnost2)

export  <- data.frame(vysledky$skutecny_cas, vysledky$kategorie, vysledky$narodnost2)

names(export)  <- c("c", "k", "n")

export$c  <- as.difftime(as.character(export$c), "%X", units="mins")

export$c  <- as.numeric(export$c)

writeLines(toJSON(export), "vysledky2014.json")


range(export$c)

(410-125)/5

writeLines(toJSON(levels(export$n)), "filtr1.txt")

table(export$n)

# stary scaraper

umisteni_celkove <- character()
startovni_cislo  <- character()
jmeno  <- character()
klub  <- character()
narodnost  <- character()
kategorie  <- character()
cas  <- character()
cas_real  <- character()
tabulka  <- data.frame(2,4)

firefox <- firefoxClass$new()

counter  <- 0

firefox$get("http://www.tds-live.com/ns/index.jsp?pageType=1&id=6192&isStandAlone=true&frameborder=&locale=1029")
dalsi  <- firefox$findElementByLinkText("DALŠÍ >")

for (i in 1:604) {
        tail  <- tail(startovni_cislo, 10)
        repeat {
                counter  <- counter + 1
                html  <- firefox$getPageSource()
                tabulka  <- readHTMLTable(html, header=TRUE)[[6]]
                obrazky  <- xpathSApply(htmlParse(html), "//img", xmlAttrs)
                obrazky  <- sapply(obrazky, function(x) {
                        if (str_detect(x["src"], "grafica/flags/")) {return(x["alt"])}
                })
                obrazky  <- unlist(obrazky[!sapply(obrazky, is.null)])
                names(obrazky)  <- NULL
                narodnost  <- append(narodnost, obrazky)
                umisteni_celkove  <- append(umisteni_celkove, as.character(tabulka$Pořadí))
                startovni_cislo <- append(startovni_cislo, as.character(tabulka[ ,2]))
                jmeno  <- append(jmeno, as.character(tabulka[ ,3]))
                klub  <- append(klub, as.character(tabulka[ ,4]))
                kategorie  <- append(kategorie, as.character(tabulka[ ,6]))
                cas  <- append(cas, as.character(tabulka[ ,7]))
                cas_real  <- append(cas_real, as.character(tabulka[ ,8]))
                if (!identical(as.character(tabulka[ ,2]), tail)) break()
                if (counter > 20) {dalsi$click()}
                Sys.sleep(4)
        }
        dalsi$click()        
}

narodnost2  <- c(narodnost[1:5951], NA, narodnost[5952:7947]) 

length(unique(startovni_cislo))

vysledky  <- data.frame(
        jmeno,
        kategorie,
        klub,
        cas=as.difftime(cas, "%X", units="mins"),
        startovni_cislo,
        umisteni_celkove=as.numeric(umisteni_celkove),
        cas_real=as.difftime(cas_real, "%X", units="mins"))

vysledky2  <- cbind(vysledky, narodnost2)

write.csv(vysledky2, "vysledky2014.csv")

nrow(unique(vysledky))

vysledky3  <- unique(vysledky)

unique(vysledky2$startovni_cislo)
