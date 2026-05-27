public class PrimzahlSieb {
    public static void main(String[] args) {

        boolean[] sieb = new boolean[1001];

        int i = 2;

        // Alle Zahlen als prim markieren
        while (i <= 1000) {
            sieb[i] = true;
            ++i;
        }
        i = 2;

        // Sieb 
        while (i <= 1000) {

            if (sieb[i]) {

                int t = i * i;
				while (t <= 1000) {
					sieb[t] = false;
					t += i;
				}
            }
            ++i;
        }

        // Ausgabe
        i = 2;
        while (i <= 1000) {
            if (sieb[i]) {
                System.out.println(i);
            }
            ++i;
        }
    }
}