import java.io.*;
import java.util.*;

class split2 {
  void split(int divisor, String input, String base) throws Exception {
    BufferedReader br = null;
    List<PrintWriter>fplist = null;
    String line = "";
    int total = 0;
    int c_start = 0;
    int c_end = 0;
    int part = 0;
    int quotient = 0;
    int toomuch = 0;
    int cnt =0;

    br = new BufferedReader(new FileReader(input));
    while((line=br.readLine())!=null) {
      total++;
    }
    br.close();

    fplist = new ArrayList<PrintWriter>();
    for(int no=0;no<divisor;no++) {
      String file = String.format("%s%02d",base,no);
      PrintWriter pw = new PrintWriter(
                           new BufferedWriter(new FileWriter(file)));
      fplist.add(pw);
    }

    quotient = total / divisor;
    toomuch  = total % divisor;

    cnt = 0;
    br = new BufferedReader(new FileReader(input));
    while((line=br.readLine())!=null) {
      cnt++;
      if (cnt > c_end) {
        if (part < toomuch) {
          c_start = c_end + 1;
          c_end   = c_start + quotient;
        } 
        else {
          c_start = c_end + 1;
          c_end   = c_start + quotient - 1;
        }
        System.out.printf("Part[%d] Start[%08d] End[%08d] Cnt[%08d]\n",
                          part+1,c_start,c_end,c_end-c_start+1);
        part++;
      }
      fplist.get(part-1).printf("%s\n",line);
    }
    br.close();

    for(int no=0;no<divisor;no++) {
      fplist.get(no).close();
    }
  } 
  
  public static void main(String args[]) throws Exception {
    if (args.length != 3) {
      System.out.printf("Usage : split2 divisor input base\n");
      System.exit(1);
    }

    int    divisor = Integer.parseInt(args[0]);
    String input   = args[1];
    String base    = args[2];

    split2 obj = new split2();
    obj.split(divisor,input,base);
  }
}
