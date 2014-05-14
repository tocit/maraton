        library(XML)
        library(stringr)
        
        jmeno  <- character()
        cislo  <- character()
        cas  <- character()
        cas_cip  <- character()
        tempo  <- character()
        narodnost  <- character()
        kategorie  <- character()
        klub  <- character()
        umisteni_celkove <- character()
        umisteni_kategorie  <- character()
        umisteni_pohlavi  <- character()
        
        
        for (i in 7267:12500) {
                url  <- paste("http://www.runczechresults.com/cs/Results/ResultDetail?BIB=", i, "&rid=10", sep="")
                
                html  <- htmlTreeParse(url, useInternalNodes=TRUE, encoding="utf-8")
                jmeno  <- append(jmeno, xpathSApply(html, "//h1", xmlValue))
                cislo  <- append(cislo, xpathSApply(html, "//h1/span", xmlValue))
                cas  <- append(cas, xpathSApply(html, '//body/div/table[1]/tr/td[2]', xmlValue)[1])
                cas_cip  <- append(cas_cip, xpathSApply(html, '//body/div/table[1]/tr/td[2]', xmlValue)[2])
                tempo  <- append(tempo, xpathSApply(html, '//body/div/table[1]/tr/td[2]', xmlValue)[3])
                narodnost  <- append(narodnost, xpathSApply(html, '//body/div/table[2]/tr/td[2]', xmlValue)[1])
                kategorie  <- append(kategorie, xpathSApply(html, '//body/div/table[2]/tr/td[2]', xmlValue)[2])
                klub  <- append(klub, xpathSApply(html, '//body/div/table[2]/tr/td[2]', xmlValue)[3])
                umisteni_celkove  <- append(umisteni_celkove, xpathSApply(html, '//body/div/table[3]/tr/td[2]', xmlValue)[1])
                umisteni_pohlavi  <- append(umisteni_pohlavi, xpathSApply(html, '//body/div/table[3]/tr/td[2]', xmlValue)[2])
                umisteni_kategorie  <- append(umisteni_kategorie, xpathSApply(html, '//body/div/table[3]/tr/td[2]', xmlValue)[3])
                print(i)
                print(jmeno[i])
        }
        
