#/bin/bash
#Find Potential company/product/etc. name
#Eventually search for outstanding company/product

wget -O essai_fisker_lapresse.txt https://auto.lapresse.ca/guide-auto/fisker/201903/19/01-5218827-fisker-devoile-un-vus-electrique-concurrent-du-modele-y.php

#filter special characters
sed 's/[āáǎà]/a/g; s/[ĀÁǍÀ]/A/g; s/[ēéěè]/e/g; s/[ĒÉĚÈ]/E/g; s/[īíǐì]/i/g; s/[ĪÍǏÌ]/I/g; s/[ōóǒò]/o/g; s/[ŌÓǑÒ]/O/g; s/[ūúǔùǖǘǚǜ]/u/g; s/[ŪÚǓÙǕǗǙǛ]/U/g; s/ĉç/c/g; s/ĈÇ/C/g' essai_fisker_lapresse.txt

awk '/Fisker/' essai_fisker_lapresse.txt > fisker.tmp && mv fisker.tmp essai_fisker_lapresse.txt

#sed -i 'y/āáǎàēéěèīíǐìōóǒòūúǔùǖǘǚǜĀÁǍÀĒÉĚÈĪÍǏÌŌÓǑÒŪÚǓÙǕǗǙǛ/aaaaeeeeiiiioooouuuuüüüüAAAAEEEEIIIIOOOOUUUUÜÜÜÜ/' essai_fisker_lapresse.txt > fisker.tmp && mv fisker.tmp essai_fisker_lapresse.txt
#cat essai_fisker_lapresse.txt | iconv -f utf8 -t ascii//TRANSLIT//IGNORE > fisker.tmp && mv fisker.tmp essai_fisker_lapresse.txt

#keep words starting with capital letter and sort them
grep -oP "\b[A-Z]+\w*" essai_fisker_lapresse.txt > fisker.tmp && mv fisker.tmp essai_fisker_lapresse.txt
sort essai_fisker_lapresse.txt | uniq > fisker.tmp && mv fisker.tmp essai_fisker_lapresse.txt

#toLowerCase
tr '[:upper:]' '[:lower:]' < essai_fisker_lapresse.txt > fisker.tmp && mv fisker.tmp essai_fisker_lapresse.txt

#delete common words from the french words file
awk 'FNR==NR{ array[$0];next}
 { if ( $1 in array ) next
   print $1}
' "liste_francais.txt" "essai_fisker_lapresse.txt" > fisker.tmp && mv fisker.tmp essai_fisker_lapresse.txt

#filter again with people names, cities, etc.
#...

#save output file
grep -v --file=liste_francais.txt > fisker.tmp && mv fisker.tmp essai_fisker_lapresse.txt

