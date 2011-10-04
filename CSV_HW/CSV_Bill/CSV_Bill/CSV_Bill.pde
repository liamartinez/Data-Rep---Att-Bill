
/*

Static CSV HW for Data Rep
Lia Martinez, 08/04/2011

*/


float[] numbers;
Date[] dates;
String[] splits;
String[] titles; 
String[] telNums; 
String [] days; 
String [] files; 

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

String [] months = new String[] {
  "AUGUST 2010", "SEPTEMBER 2010", "OCTOBER 2010", "NOVEMBER 2010", 
  "DECEMBER 2010", "JANUARY 2011", "FEBRUARY 2011", "MARCH 2011", "APRIL 2011", "MAY 2011", 
  "JUNE 2011", "JULY 2011", "AUGUST 2011"
};

//-------------------------------------------------------------------------------------------------------


void setup() {
  size(1300, 500);
  colorMode(HSB);
  smooth();
  rectMode (CORNERS); 

  // Corners 
  plotX1 = 100;
  plotX2 = width - 60;
  plotY1 = 150;
  plotY2 = height-150;

  plotFont = createFont("SansSerif", 20); 
  textFont(plotFont); 

  df = new SimpleDateFormat ("MM/dd/yyyy"); 
  dateInterval = 5; 
  durInterval = 10; 

  //initialize files
  files = new String [13]; 
  for (int i = 0; i < files.length; i++) {
    files[i] = ("512024242409-"+i+".csv");
    println("loading " + files[i]);
  } 

  currentFile = 0;
  countFile = 12;
}


//-------------------------------------------------------------------------------------------------------

void draw() {
  background(50, 122, 180, 200);
  noFill();
  stroke(244); 
  strokeWeight (1);
  rectMode (CORNERS);
  rect (plotX1-15, plotY1, plotX2+15, plotY2);

  //write the static text
  mainText(); 
  
  //Load the CSV
  setupStrings (files[currentFile]);

  //Draw the graph
  drawGraph(months[currentFile]);
}


//-------------------------------------------------------------------------------------------------------

void drawGraph(String title) {

  drawDuration();
  drawDate(); 

  rectMode (CENTER);
  noStroke(); 
  
  //display the month title
  textAlign(LEFT, BOTTOM);
  textSize(15); 
  text (title, plotX1-10, plotY1-5); 

  for (int row = 0; row < numbers.length; row++) {

    float x = map (dates[row].getTime(), firstDate.getTime(), lastDate.getTime(), plotX1, plotX2);
    float y = map (numbers[row], durMin, durMax, plotY2-10, plotY1+10); 
    fill(200, 50, 70, 100);
    point(x, y); 
    fill (0); 
    textSize(plotX2/numbers.length+5);

    // change the color of rect depending on who called
    if (telNums[row].equals(daddy) == true ) {
      fill(150, 150, 255, 200);
    } 
    else if (telNums[row].equals(mommy) == true) {
      fill(250, 150, 255, 200);
    } 
    else {
      fill(240, 200);
    }
    rect (x, y, plotX2/numbers.length+5, plotX2/numbers.length);
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
}


//-----------------------------------------------------------------------------------------------------------------------------------------

void mainText() {
  //main title
  textAlign(CENTER);
  rectMode(CORNER); 
  textSize(15); 
  fill (0); 
  text ("CALLS MADE PER DAY VS. CALL DURATION", width/2, 70);

  //calls to mom
  textSize (13); 
  text ("CALLS TO MOM", width/2 - 75, 90); 
  fill(250, 150, 255, 200);
  noStroke(); 
  rect (width/2-22, 79, 17,13);
  
  //calls to dad
  fill(0); 
  text ("CALLS TO DAD", width/2+50, 90); 
  fill(150, 150, 255, 200);
  rect (width/2+100, 79, 17,13);
  
  //instructions
  textSize (8); 
  fill(0); 
  text("USE YOUR LEFT AND RIGHT ARROW KEYS TO SWITCH MONTHS", width-175, height-30); 
  

}
//---------------------------------------------------------------------------------------------------------

void keyPressed() { 
  if (key == CODED) {
  if (keyCode == LEFT) {
    currentFile --;
    if (currentFile < 0) {
      currentFile = countFile - 1;
    } 
  } 
  else if (keyCode == RIGHT) {
    currentFile++;
    if (currentFile == countFile) {
      currentFile = 0;
    }
  }
  }
}


