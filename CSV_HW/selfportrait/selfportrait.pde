
float[] numbers;
Date[] dates;
String[] splits;
String[] titles; 
String[] telNums; 
String [] days; 
String [] files; 
String []months; 

String daddy = "714-854-5459";
String mommy = "567-251-2655";

SimpleDateFormat df; 
Date firstDate;
Date lastDate; 

int dateMin, dateMax; 
int dateInterval; 
int durInterval;
int currentFile;
int countFile; 

float durMin, durMax; 
float plotX1, plotY1;
float plotX2, plotY2;

PFont plotFont; 


//-------------------------------------------------------------------------------------------------------


void setup() {

  size(1300, 500);
  colorMode(HSB);

  smooth();
  rectMode (CORNERS); 

  // Corners 
  plotX1 = 100;
  plotX2 = width - 60;
  plotY1 = 100;
  plotY2 = height-200;

  plotFont = createFont("SansSerif", 20); 
  textFont(plotFont); 

  df = new SimpleDateFormat ("MM/dd/yyyy"); 
  dateInterval = 5; 
  durInterval = 20; 



  //initialize files
  files = new String [13]; 
  for (int i = 0; i < files.length; i++) {
    files[i] = ("512024242409-"+i+".csv");
    println(files[i]);
  } 

  //initialize months
  //months = new String [13];
  String [] months = {
    "August 2010", "September 2010", "October 2010", "November 2010", 
    "December 2010", "January 2011", "February 2011", "March 2011", "April 2011", "May 2011", 
    "June 2011", "July 2011", "August 2011"
  };

  println (months[2]); 

  currentFile = 0;
  countFile = 12;
}


//-------------------------------------------------------------------------------------------------------

void draw() {
  background(50, 122, 200, 200);
  noFill();
  stroke(244); 
  strokeWeight (1);
  rectMode (CORNERS);
  rect (plotX1-15, plotY1, plotX2+15, plotY2);

  //Load the CSV
  setupStrings (files[currentFile]);


  drawGraph("August 2010");
}


//-------------------------------------------------------------------------------------------------------

void drawGraph(String title) {

  drawDuration();
  drawDate(); 

  textAlign(LEFT, BOTTOM); 
  rectMode (CENTER);
  textSize(20); 
  text (title, plotX1, plotY1-10); 
  noStroke(); 

  for (int row = 0; row < numbers.length; row++) {

    float x = map (dates[row].getTime(), firstDate.getTime(), lastDate.getTime(), plotX1, plotX2);
    float y = map (numbers[row], durMin, durMax, plotY2-10, plotY1+10); 
    fill(200, 50, 70, 100);
    //ellipse (x, y, plotX2/numbers.length+8, plotX2/numbers.length+8); 
    point(x, y); 
    fill (0); 
    textSize(plotX2/numbers.length+5);


    // conditional; clean this up
    if (telNums[row].equals(daddy) == true ) {
      fill(150, 150, 255, 200); 
      rect (x, y, plotX2/numbers.length+5, plotX2/numbers.length);
    } 
    else if (telNums[row].equals(mommy) == true) {
      fill(250, 150, 255, 200); 
      rect (x, y, plotX2/numbers.length+5, plotX2/numbers.length);
    } 
    else {
      fill(240, 200); 
      rect (x, y, plotX2/numbers.length+5, plotX2/numbers.length);
    }
  }
}



//-------------------------------------------------------------------------------------------------------


void drawDate() {
  fill (0);

  textAlign(CENTER, TOP); 
  rectMode (CENTER); 
  for (int row = 0; row < dates.length; row++) {
    float x = map (dates[row].getTime(), firstDate.getTime(), lastDate.getTime(), plotX1, plotX2);
    textSize(10); 
    text (days[row], x, plotY2 + 10);

    if (days[row].equals("SUN")) {
      text (dates[row].getDate(), x, plotY2 + 20); 
      stroke (215); 
      strokeWeight(1);        
      line (x, plotY1, x, plotY2);
    }
  }
}


//---------------------------------------------------------------------------------------------------------

void drawDuration() {
  fill (0);
  textSize (10); 
  textAlign (RIGHT, CENTER); 

  for (float i = durMin; i < durMax; i += durInterval) {
    float y = map (i, durMin, durMax, plotY2, plotY1);
    stroke (215); 
    strokeWeight(1);      
    text (floor(i), plotX1 - 20, y);
    //line (plotX1 - 5, y, plotX1+5, y);
  }
}


//---------------------------------------------------------------------------------------------------------

void setupStrings (String file) {

  String[] input = loadStrings(file);


  titles = new String [input.length - 1]; 
  numbers = new float[input.length - 1]; 
  dates = new Date [input.length - 1]; 
  telNums = new String [input.length - 1]; 
  days = new String [input.length -1]; 


  //Convert the Strings into floats 
  for (int i =  1; i < input.length; i++) {  //start at 1 instead of 0 because of dataset
    noStroke();
    splits = input[i].split(",");
    numbers[i - 1] = float(splits[6]);
    titles [i - 1] = splits[6];   
    telNums [i-1] = splits [4];
    days [i-1] = splits[1]; 
    try {
      dates[i - 1] = df.parse(splits[2]);
    } 
    catch (Exception e) {
    }
  }

  //these are Dates 
  firstDate = dates[0]; 
  lastDate = dates[dates.length -1];

  durMin = 0; 
  durMax = max(numbers);
  println (max(numbers));
}

//---------------------------------------------------------------------------------------------------------

void keyPressed() { 
  if (key == '[') {
    currentFile --;
    if (currentFile < 0) {
      currentFile = countFile - 1;
    } 
    println ("currentfile is " + currentFile);
  } 
  else if (key == ']') {
    currentFile++;
    println ("currentfile is " + currentFile);
    if (currentFile == countFile) {
      currentFile = 0;
    }
  }
}




