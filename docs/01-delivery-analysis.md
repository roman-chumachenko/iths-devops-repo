# DevOps-analys: Almqvist Logistik AB

## 1. Flödet
Ett team på nio personer förvaltar ett bokningssystem för godstransporter. Den nuvarande processen för att få ut en ändring från beslut till drift omfattar regelbundna planeringsmöten, kodning, en manuell kodgranskningskö (pull request), manuell paketering, driftsättning i en begränsad testmiljö, manuell testning, väntan på ett månatligt релизно-fönster (releasefönster) samt en manuell driftsättningsprocess i produktion.

## 2. Värdeflödeskarta
| Steg | Bearbetningstid | Väntetid | Rätt första gången |
| :--- | :--- | :--- | :--- |
| Utveckling | 3 d | — | 60% |
| Granskning | 20 min (0,04 d) | 4 d | 100% |
| Bygge för hand | 45 min (0,09 d) | — | 100% |
| Test | 2 d | 3 d (testmiljön upptagen) | 60% (40% omtag) |
| Vänta på releasefönstret | — | 11 d | 100% |
| Driftsättning | 4 h (0,5 d) | — | 75% (var fjärde release problematisk) |
| **Summa** | **cirka 5,6 d** | **18 d** | — |

* **Total ledtid:** cirka 23,6 arbetsdagar (nästan 5 veckor).
* **Andel värdeskapande tid:** 5,6 / 23,6 ≈ 24%.

## 3. De tre största väntetiderna
1. **Releasefönstret (11 dagar):** Nästan hälften av den totala ledtiden. Ändringar hålls kvar artificiellt till månadens sista torsdag, och inget aktivt arbete bedrivs under denna period.
2. **Granskningskön (4 dagar):** Uppgiften väntar i fyra dagar på granskning trots att själva granskningen bara tar 20 minuter. Detta skapar en klassisk flaskhals vid ingången.
3. **Upptagen testmiljö (3 dagar):** Det enda exemplaret av testmiljön är blockerat av föregående release, vilket gör att nya tester blir stående.

## 4. DORA-måtten för det här flödet
* **Driftsättningsfrekvens:** 12 gånger per år (ett releasefönster per månad). *Uppskattning baserad på regelverket för releasefönster.*
* **Tid från ändring till drift:** Cirka 24 arbetsdagar. *Beräknat utifrån den totala summan av bearbetningstid och väntetid i värdeflödeskartan.*
* **Andel misslyckade ändringar:** Cirka 25%. *Uppskattning: var fjärde release kräver åtgärder dagen efter.*
* **Återställningstid:** Ett dygn eller mer. *Uppskattning som baseras på 6 timmars manuell återställning plus fördröjning eftersom felen ofta upptäcks först dagen efter.*

## 5. Bedömning mot kvalitetskriterierna
* **Utveckling – Automatisering av bygge:** *Uppfylls inte.* Bygget av paketet görs manuellt av en utvecklare (tar 45 minuter).
* **Utveckling – Automatisk testning:** *Uppfylls delvis.* Tester körs, men processen är bunden till manuell styrning och en gemensam testmiljö.
* **Utveckling – Spårbarhet:** *Uppfylls delvis.* Manuella processer för kodgranskning och paketering försvårar helhetssökbarheten för ändringar.
* **Utveckling – Miljöisolering:** *Uppfylls inte.* Testmiljön existerar i ett enda exemplar och blockeras ständigt av andra uppgifter.
* **Drift – Frekvens på deploys:** *Uppfylls inte.* Driftsättningen är knuten till sällsynta releasefönster (1 gång i månaden).
* **Drift – Återställningshastighet:** *Uppfylls inte.* Återställningen görs för hand och tar upp till 6 timmar.
* **Drift – Övervakning och larm:** *Uppfylls inte.* Problem upptäcks ofta av användare eller dagen efter istället för proaktivt.
* **Drift – Incidentkultur:** *Uppfylls inte.* Frekventa manuella fel och lång återställningstid pekar på en brist på "blameless post-mortem"-kultur och automatiserad återställning.

## 6. Vad jag skulle ändra först, och varför
I första hand bör en automatisk CI/CD-pipeline för bygge och testkörning vid varje push införas, eftersom borttagandet av väntetiderna för manuellt bygge och automatisering av testningen undanröjer de kritiska flaskhalsarna med 3 dagars kötid i testmiljön samt 45 minuters manuellt arbete, vilket direkt kapar den totala leveranscykeln.

## 7. Kort analys av testfallet för Almqvist Logistik AB

Kärnproblemet: 
Det tar 23,6 arbetsdagar (nästan 5 veckor) att få ut en ändring i produktion. 
Det faktiska arbetet (bearbetningstiden) tar bara 5,6 dagar, medan resten av tiden består av dödtid (väntetid) då uppgifterna bara ligger stilla.   

De största flaskhalsarna:
* Releasefönstret (11 dagar): Koden hålls kvar artificiellt i nästan en halv månad för en gemensam release.   
* Granskningskön (4 dagar): Själva kodgranskningen tar bara 20 minuter, men uppgiftingen väntar i fyra dagar på att bli gjord.   
* Upptagen testmiljö (3 dagar): Det finns bara en enda testmiljö som blockeras av föregående release.   

DORA-mått: 
* Låg leveransfrekvens (1 gång i månaden) 
* Svag stabilitet (var fjärde release är problematisk och kräver en tidskrävande manuell återställning på upp till 6 timmar).   

### Slutsats: 
Problemet är inte att utvecklarna kodar långsamt (3 dagar), utan att processen är fylld av manuella moment, flaskhalsar och köer. Det är precis dessa hinder vi kommer att bygga bort med automatisering i kommande moduler. 
