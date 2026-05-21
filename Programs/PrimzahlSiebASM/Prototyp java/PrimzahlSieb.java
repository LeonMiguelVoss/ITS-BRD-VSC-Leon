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