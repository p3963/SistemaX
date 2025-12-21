/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package include;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 *
 * @author piero.trentanove
 */
public class DFormat {
    private static String data;
    public DFormat() {
    }

    public static String getData() {
        return data;
    }

    public void setData(String data) {
        //Date currentDate = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd", Locale.ITALY);
        String formattedDate = formatter.format(data);
        //System.out.println(formattedDate); // Output: 03/08/2025 12:00:00 (or similar)
        this.data = formattedDate;
    }
}