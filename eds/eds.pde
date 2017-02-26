import processing.pdf.*;
import controlP5.*;
import java.io.BufferedReader;
import java.io.InputStreamReader;
ControlP5 cp5;
PImage cookie;
int borderStroke = 5;
PImage header;
PImage circle;
boolean editMode = true;
color blue = color(0, 139, 242);
color red = color(255, 10, 50);
PFont myFont;
PFont UIFont;
boolean hasFondant = true;
String myFrame;
void setup() {
 cookie = loadImage("cookie.jpg");
 header = loadImage("header.png");
 circle = loadImage("circle.png");
textMode(CENTER);
  size(1500,900);
  myFont = createFont("Reubenish", 70);
  UIFont = createFont("ariel", 24);
  buildUI();
 background(255);
}
void draw() {


  if(editMode){
     background(255);
    image(header, width/2, 155);
    image(circle, 1200, 300, 250, 250);
    imageMode(CENTER);
    image(cookie, width/2, 550, 500, 500);
    if(hasFondant){ 
      fill(blue);
      ellipse(width/2, 550, 400, 400);
      fill(color(7, 58, 179));
    } else { 
      fill(blue);
    }
    stroke(255);
    strokeWeight(1);
    textFont(myFont);
    textMode(CENTER);
    text(cp5.get(Textfield.class,"Line 1").getText().toUpperCase(), width/2,500);
    text(cp5.get(Textfield.class,"Line 2").getText().toUpperCase(), width/2,550);
    text(cp5.get(Textfield.class,"Line 3").getText().toUpperCase(), width/2,600);
  }
  fill(255, 222, 23);
  rect(0, 0, width, borderStroke); // Top
  rect(width-borderStroke, 0, borderStroke, height); // Right
  rect(0, height-borderStroke, width, borderStroke); // Bottom
  rect(0, 0, borderStroke, height); // Left
}
public void clear() {
  cp5.get(Textfield.class,"Line 1").clear();
  cp5.get(Textfield.class,"Line 2").clear();
  cp5.get(Textfield.class,"Line 3").clear();
}
public void Submit() {
   editMode=false;
   drawFinal(cp5.get(Textfield.class,"Line 1").getText(),cp5.get(Textfield.class,"Line 2").getText(), cp5.get(Textfield.class,"Line 3").getText());
   hideUI();
   //runScript(myFrame);
   cp5.get(Bang.class,"Again").show();
}

public void Again() {
  editMode=true;
  showUI();
  cp5.get(Bang.class,"Again").hide();
}
void drawFinal(String item, String item2, String price){ 
  int frameNumber = int(random(0, 1000));
  myFrame = "random"+frameNumber+".pdf"; 
  fill(255);
  rect(0, 0, width, height);
  beginRecord(PDF, myFrame); 
    ellipseMode(CENTER);
    stroke(0);
    ellipse(width/2, 150, 300, 300);
    fill(blue);
    stroke(0);
    strokeWeight(1);
    textFont(myFont);
    textAlign(CENTER);
    text(item.toUpperCase(), width/2, 100);
    text(item2.toUpperCase(), width/2, 150);
    text(price.toUpperCase(), width/2, 200);
  endRecord();
  save(myFrame);
}
void hideUI() { 
  cp5.get(Textfield.class,"Line 1").hide();
  cp5.get(Textfield.class,"Line 2").hide();
  cp5.get(Textfield.class,"Line 3").hide();
  cp5.get(Bang.class,"Submit").hide();
  cp5.get(Bang.class,"clear").hide();
}
void showUI(){ 
  cp5.get(Textfield.class,"Line 1").show();
  cp5.get(Textfield.class,"Line 2").show();
  cp5.get(Textfield.class,"Line 3").show();
  cp5.get(Bang.class,"Submit").show();
  cp5.get(Bang.class,"clear").show();
}
void buildUI(){ 
  cp5 = new ControlP5(this);
  cp5.addTextfield("Line 2")
     .setPosition(width/6,375)
     .setSize(200,40)
     .setFont(UIFont)
     .setColor(color(0))
     .setColorActive(color(255, 0, 0))
     .setColorBackground(color(255))
     .setColorForeground(color(255, 222, 23))
     .setColorBackground(color(255))
     .setColorLabel(color(0,0,0))
     ;
  cp5.addTextfield("Line 1")
     .setPosition(width/6,300)
     .setSize(200,40)
     .setFont(UIFont)
     .setColor(color(0))
     .setColorActive(color(255, 0, 0))
     .setColorBackground(color(255))
     .setColorForeground(color(255, 222, 23))
     .setColorBackground(color(255))
     .setColorLabel(color(0,0,0))
     ;   
  cp5.addTextfield("Line 3")
     .setPosition(width/6,450)
     .setSize(200,40)
     .setFont(UIFont)
     .setColor(color(0))
     .setColorActive(color(255, 0, 0))
     .setColorBackground(color(255))
     .setColorForeground(color(255, 222, 23))
     .setAutoClear(false)
     .setColorLabel(color(0,0,0))
     ;
  cp5.addBang("clear")
     .setPosition(width/6 + 125,550)
     .setSize(80,40)
     .setFont(UIFont)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;    
  cp5.addBang("Submit")
     .setPosition(width/6,550)
     .setSize(100,40)
     .setFont(UIFont)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;  
    cp5.addBang("Again")
     .setPosition(100,100)
     .setSize(80,40)
     .hide()
     .setFont(UIFont)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;  
}
void runScript(String filename){ 
  String commandToRun = "./convert.sh " + filename;
  File workingDir = new File(sketchPath(""));
  String returnedValues;
  try {
    Process p = Runtime.getRuntime().exec(commandToRun, null, workingDir);
    int i = p.waitFor();
    if (i == 0) {
      BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
      while ( (returnedValues = stdInput.readLine ()) != null) {
        println(returnedValues);
      }
    }
    else {
      BufferedReader stdErr = new BufferedReader(new InputStreamReader(p.getErrorStream()));
      while ( (returnedValues = stdErr.readLine ()) != null) {
        println(returnedValues);
      }
    }
  }
  catch (Exception e) {
    println("Error running command!");
    println(e);
    // e.printStackTrace(); // a more verbose debug, if needed
  }
}