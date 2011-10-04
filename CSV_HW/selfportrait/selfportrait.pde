
float[] numbers;
Date[] dates;
String[] splits;
String[] titles; 
String[] telNums; 


String daddy = "714-854-5459";

SimpleDateFormat df; 
SimpleDateFormat days; 
Date firstDate;
Date lastDate; 

int dateMin, dateMax; 
int dateInterval; 

float durMin, durMax; 
float plotX1, plotY1;
float plotX2, plotY2;

int currentColumn = 0; 
int columnCount; 

PFont plotFont; 


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

  plotFont = createFont("SansSerif", 20); 
  textFont(plotFont); 

  df = new SimpleDateFormat ("MM/dd/yyyy"); 
  //columnCount = data.getColumnCount(); 

  //Load the CSV
  String[] input = loadStrings("512024242409-0.csv");


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
    telNums [i-1] = splits [4];

    try {
      dates[i - 1] = df.parse(splits[2]);
    } 
    catch (Exception e) {
    }
    
  // dateDays[i] = toString.dateTitles[i];
    
  }

  //these are Dates 
  firstDate = dates[0]; 
  lastDate = dates[dates.length -1];

  //these are ints -- difference? 
  //dateMin = dates[0]; 
  //dateMax = dates[dates.length-1]; 
  dateInterval = 5; 


  durMin = 0; 
  durMax = max(numbers);
}


//-------------------------------------------------------------------------------------------------------

void draw() {
  fill(50, 122, 255, 200); 
  rect (plotX1, plotY1, plotX2, plotY2);
  //strokeWeight (5); 

  fill(0); 
  textSize(20); 
  String title = ("Sept 2010"); 
  text (title, plotX1, plotY1-10); 
  drawDate(); 
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

    /*  
     pushMatrix(); 
     translate (x, plotY2); 
     rotate (HALF_PI); 
     text(dateTitles[row], 0, 0); 
     popMatrix(); 
     */

    // conditional if; clean this up
    if (telNums[row].equals(daddy) == true ) {
      fill (255, 255, 255); 
      noStroke(); 
      ellipse (x, y, plotX2/numbers.length+8, plotX2/numbers.length+8);
    }
  }
}



//-------------------------------------------------------------------------------------------------------


void drawDate() {
  fill (0);
  textSize(10); 
  textAlign(CENTER, TOP); 
  for (int row = 0; row < dates.length; row++) {
      float x = map (dates[row].getTime(), firstDate.getTime(), lastDate.getTime(), plotX1, plotX2);
      text (dates[row].getDate(), x, plotY2 + 10); 
    if (dates[row].getDate() % dateInterval == 0) {
      stroke (224); 
      strokeWeight(1); 
      line (x, plotY1, x, plotY2); 
    }
  }
}

