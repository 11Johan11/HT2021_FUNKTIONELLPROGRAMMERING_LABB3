# Laboration 3: Funktionell Programmering - Interpreter för Imperativt Språk MAP

## Kurs: Funktionell Programmering - Hösten 2021

## Inledning
Det här repositoriet innehåller min lösning på den tredje laborationen i kursen Funktionell Programmering. Uppgiften fokuserade på att utveckla en interpreter för det enkla imperativa språket MAP, med hjälp av Haskell. Laborationen gav träning i att stegvis utveckla och testa komplexa program.

## Uppgiftsbeskrivning
Laborationen innebar att skapa en interpreter för språket MAP som hanterar variabler, aritmetiska och Booleska uttryck samt kontrollstrukturer:
1. **Hantera Variabler och Tillstånd**: Skapa en omgivning för att lagra variabler och deras värden.
2. **Aritmetiska Uttryck**: Implementera en funktion för att utvärdera aritmetiska uttryck.
3. **Booleska Uttryck**: Utveckla en funktion för att utvärdera Booleska uttryck och relationella operatorer.
4. **Kontrollstrukturer**: Skapa datatyper och funktioner för att hantera if-satser, loopar och sekventiell exekvering.
5. **Testfall**: Testa de olika konstruktionerna med exempel och verifiera korrekt beteende.

## Tekniska Detaljer
- **Programspråk**: Haskell.
- **Datatyper**: Definierade för att hantera olika delar av MAP-språket, inklusive uttryck, variabler och kommandon.
- **Interpreter**: En funktion som tar ett MAP-uttryck och ett tillstånd och returnerar ett nytt tillstånd baserat på uttrycket.
- **Rekursiv Design**: Användning av rekursion för att hantera kontrollstrukturer.

## Bedömning och Krav
- Korrekt implementering av interpreter för MAP.
- Kod måste vara välorganiserad och följa funktionell programmeringsstil.
- Adekvat dokumentation och namngivning enligt kursens standarder.
- Programmet måste kompilera och köra korrekt i en Haskell-miljö.

## Inlämning
Uppgiften bedömdes som godkänd eller underkänd baserat på korrekt implementering och dokumentation av de krävda funktionerna.

