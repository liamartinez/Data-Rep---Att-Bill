
float[] numbers;
Date[] dates;
String[] splits;
String[] titles; 

SimpleDateFormat df; 
Date firstDate;
Date lastDate; 

float durMin, durMax; 
float plotX1, plotY1;
float plotX2, plotY2;

int currentColumn = 0; 
int columnCount; 


void setup() {

  size(1500, 800);
  colorMode(HSB);
  background(50, 122, 200, 200);
  smooth();
  rectMode (CORNERS); 
  textMode (CENTER); 

  // Corners of the plotted time series
  plotX1 = 10;
  plotX2 = width - plotX1;
  plotY1 = 100;
  plotY2 = height/3;

  df = new SimpleDateFormat ("MM/dd/yyy"); 

  //Load the CSV
  String[] input = loadStrings("512024242409-0.csv");
 
  titles = new String [input.length - 1]; 
  numbers = new float[input.length - 1]; 
  dates = new Date [input.length - 1]; 
  columnCount = 32; 


  //Convert the Strings into floats 
  for (int i =  1; i < input.length; i++) {  //start at 1 instead of 0 because of dataset
    noStroke();
    splits = input[i].split(",");
    numbers[i - 1] = float(splits[6]);
    titles [i - 1] = splits[6];
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


void draw() {
  fill(255); 
  rect (plotX1, plotY1, plotX2, plotY2);
  strokeWeight (5); 

   
  
  drawGraph();
}




void drawGraph() {

  int oneHour = 1000 * 60 * 60;
  int oneDay = oneHour * 24;
  int oneWeek = oneDay * 7;

  for (int row = 0; row < numbers.length; row++) {

    float x = map (dates[row].getTime(), firstDate.getTime(), lastDate.getTime(), plotX1+10, plotX2-10);
    float y = map (numbers[row], durMin, durMax, plotY2-10, plotY1+10); 
    fill(20);
    ellipse (x, y, plotX2/numbers.length, plotX2/numbers.length); 
    point(x, y); 
    fill (255,50,50); 
   textSize(plotX2/numbers.length);
   text(titles[row], x+(plotX2/numbers.length), y);
   println (titles[row]); 
    //float locDate = map(dates[row].getTime(), firstDate.getTime(), lastDate.getTime(), 0, width);
    //colorMode(HSB);
    //stroke(20+(i*2), 200, 24, 100);
    //fill(20);
    //float loc = map (i, 0, 187, 10, width-10); 
    //rect(locDate, 20, (width-20)/numbers.length, (numbers[row]));
  }
}








