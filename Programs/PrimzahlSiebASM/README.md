Konzepz

Analyse der Aufgabenstellung:

Das Zeil der aufgabe ist es eim Primzahlsieb in Assembly zu schreiben, welches die Primzahlen von 2 bis 1000 berechnet. Zunächst soll jedoch erstmal das Konzept in Pseudocode oder Java entwickelt werden. Zudem soll erarbeitet werden, wie genau man seinen Speicher verwaltet.

Die idee ist,
- Jede Zahl bekommt einen Speicherplatz zugewiesen
- Dieser Speicherplatz enthält eine Statuswert (1/0 | True/false)
- Die Teilbarkeit der einzelnen Zahlen wird überprüft und sämtliche vielfache einer Zahl werden somit auf false gesetzt
- am ende sind alle Zahlen den den wert 1 im speicher haben, Primzahlen

Programmstruktur java:

public class PrimzahlSieb {
	public static void main(String[] args) {
		boolean[] sieb = new boolean[1001];
		
		int i = 2;
		
		while (i <= 1000) {
			sieb[i] = true;
			++i;
		}
		i = 2;
		while (i <= 1000) {
			if (sieb[i] == true) {
				int c = i + 1;
				while (c <= 1000) {
					if (c % i == 0) {
						sieb[c] = false;
					}
					++c;
				}
			}
			++i;
		}
		i = 2;
		while (i <= 1000) {
			if(sieb[i] == true) {
				System.out.println(i);
			}
			++i;
		}
	}
}

Speicherstruktur:

Die Zahl wird durch den Index des speichers beschreiben währen im speicher selbst nur der Wert 1 oder 0 also Primzahl oder nicht steht.