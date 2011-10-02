
float[] numbers;
Date[] dates;
String[] splits;
String[] titles; 
String[] dateTitles; 
String[] telNums; 

String daddy = "714-854-5459";

SimpleDateFormat df; 
Date firstDate;
Date lastDate; 

float durMin, durMax; 
float plotX1, plotY1;
float plotX2, plotY2;


//-------------------------------------------------------------------------------------------------------


void setup() {

  size(1300, 800);
  colorMode(HSB);
  background(50, 122, 200, 200);
  smooth();
  rectMode (CORNERS); 


  // Corners of the plotted time series
  plotX1 = 100;
  plotX2 = width - 10;
  plotY1 = 100;
  plotY2 = height/3;

  df = new SimpleDateFormat ("MM/dd/yyyy"); 

  //Load the CSV
  String[] input = loadStrings("512024242409-0.csv");

  dateTitles = new String [input.length -1]; 
  titles = new String [input.length - 1]; 
  numbers = new float[input.length - 1]; 
  dates = new Date [input.length - 1]; 
  telNums = new String [input.length - 1]; 
  

  //Convert the Strings into floats 
  for (int i =  1; i < input.length; i++) {  //start at 1 instead of 0 because of dataset
    noStroke();
    splits = input[i].split(",");
    numbers[i - 1] = float(splits[6]);
    titles [i - 1] = splits[6];
    dateTitles [i-1] = (splits[2]); 
    telNums [i-1] = splits [4];
    //println (telNums); 
    try {
      dates[i - 1] = df.parse(splits[2]);
    } 
    catch (Exception e) {
    }
  }

  firstDate = dates[0]; 
  lastDate = dates[dates.length -1];

  durMin = 0; 
  durMax = max(numbers);
}


//-------------------------------------------------------------------------------------------------------

void draw() {
  fill(50, 122, 255, 200); 
  rect (plotX1, plotY1, plotX2, plotY2);
  //strokeWeight (5); 
  drawGraph();
}


//-------------------------------------------------------------------------------------------------------

void drawGraph() {

  int oneHour = 1000 * 60 * 60;
  int oneDay = oneHour * 24;
  int oneWeek = oneDay * 7;

  for (int row = 0; row < numbers.length; row++) {

    float x = map (dates[row].getTime(), firstDate.getTime(), lastDate.getTime(), plotX1+10, plotX2-10);
    float y = map (numbers[row], durMin, durMax, plotY2-10, plotY1+10); 
    fill(200, 50, 70, 100);
    ellipse (x, y, plotX2/numbers.length+8, plotX2/numbers.length+8); 
    point(x, y); 
    fill (0); 
    textSize(plotX2/numbers.length+5);

    pushMatrix(); 
    translate (x, plotY2); 
    rotate (HALF_PI); 
    text(dateTitles[row], 0, 0); 
    popMatrix(); 


    if (telNums[row] == daddy) {
    ellipse (x, y, plotX2/numbers.length+20, plotX2/numbers.length+20); 
    println ("yay"); 
    } else {
    println ("boo"); 
    }

    //text(dateTitles[row], x+(plotX2/numbers.length), plotY2);
    //text(titles[row], x+(plotX2/numbers.length), y);
    //float locDate = map(dates[row].getTime(), firstDate.getTime(), lastDate.getTime(), 0, width);
    //colorMode(HSB);
    //stroke(20+(i*2), 200, 24, 100);
    //fill(20);
    //float loc = map (i, 0, 187, 10, width-10); 
    //rect(locDate, 20, (width-20)/numbers.length, (numbers[row]));
  }

}







