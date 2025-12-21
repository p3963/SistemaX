/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package include;

/**
 *
 * @author piero.trentanove
 */
import java.util.Scanner;

public class PasswordGenerator {

	/* Nel metodo Main chiediamo in input all'utente la lunghezza 
	 * della Password che si vuole generare */
	public static String Password() {
//		Scanner in= new Scanner(System.in);
//		System.out.println("Inserire la lunghezza della Password che si vuole generare");
		int passwordSize = 8;
		return getNewPassword(passwordSize);
	}
	
	/* Metodo statico getNewPassword che riceve in input la lunghezza della password
	 * scelta dall'utente e dato un alfabeto genera in modo casuale la password*/
	public static String getNewPassword(int passwordSize) {
	    //alphabet contiene tutti i possibili caratteri che comporranno la Password
		String alphabet = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz?!<>-*[]{}/";
		int alphabetLength = alphabet.length();
		String password = "";
		for (int i = 0; i < passwordSize; i++) {
		    // Scelgo una delle lettere dell'alfabeto.
		    int randomIndexCharInAlphabet = (int)(Math.random()*alphabetLength);
		    password += alphabet.charAt(randomIndexCharInAlphabet);
		}
		return password;
	}
}
 