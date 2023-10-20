public class Main {
   public static void main(String[] args) {
     Boolean isJavaFun = true;
     Boolean isHoleGood = false;
     System.out.println(isJavaFun);
     System.out.println(isHoleGood);
     double myDouble = 9.78d;
     int number = (int) myDouble;
     System.out.println(myDouble > number);
     String text = "luckyonyekwelu-udoka";
     System.out.println("the length of the text is:" + text.length());
     System.out.println(text.indexOf("kwe"));
     System.out.println(Math.min(5, 10));
     System.out.println(Math.sqrt(49));
     int randomNum =(int)(Math.random() * 101);
     System.out.println(randomNum);
     int i = 1;
     while (i < 7) {
      System.out.println(i);
      i++;
     }
     for (int t = 0; t <= 14; t = t + 2){
      System.out.println(t);
     }
     String[] car = {"volvo", "BMW", "Ford", "Mazda"};
     car[0] = "lucky";
     for (String y : car) {
      System.out.println(y);
     }
     

   }
 }
 