import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.TimeUnit;

import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;

Oscil      wave;
// keep track of the current Frequency so we can display it
Frequency  currentFreq;

// This project was inspired by 'The Coding Train' - https://github.com/CodingTrain/Rainbow-Code/tree/master/CodingChallenges/CC_78_Simple_Particle_System

public Table table;
public Table table2;
public Table table3;
int[] tempArray;

Particle p;

int temp;
int size;
int velocity;

int red; 
int green; 
int blue;

ArrayList<Particle> particles = new ArrayList<Particle>();

void setup() {
  size(600, 400);
  surface.setResizable(true);
  table = loadTable("new_data.csv", "header");
  table2 = loadTable("new_data_2.csv", "header");
  table3 = loadTable("new_data_3.csv", "header");
  thread("readData");
  thread("readData2");
  thread("readData3");

  minim = new Minim(this);
  out   = minim.getLineOut();
  currentFreq = Frequency.ofPitch( "A4" );
  wave = new Oscil( currentFreq, 0.6f, Waves.TRIANGLE );
  wave.patch( out );
  thread("sound");
}

void draw() {
  background(0);
  addTemperatureParticles();
}

void addTemperatureParticles() {
  analyzeData();
  particles.add(new Particle(width/2, height/2+20, red, green, blue, size, velocity));

  for (int i = 0; i < particles.size(); i++) {
    Particle part = particles.get(i);
    part.update();
    part.show();
    if (part.finished ()) {
      particles.remove(i);
    }
  }
}

void analyzeData() {
  if (temp < 0) {
    red = 0; 
    green = 220;
    blue = 255;
  } else if (temp < 10) {
    red = 0; 
    green = 119;
    blue = 255;
  } else if (temp < 15) {
    red = 255; 
    green = 140;
    blue = 0;
  } else if (temp < 30) {
    red = 255; 
    green = 0;
    blue = 0;
  } else {
    red = 0; 
    green = 0;
    blue = 0;
  }
}

void readData() {
  for (TableRow row : table.rows()) {  
    temp = row.getInt("temp");   
    //print(temp);
    sleep();
  }
}

void readData2() {
  for (TableRow row : table2.rows()) {  
    size = row.getInt("NOx(GT)");   
    //print(size);
    sleep();
  }
}

void readData3() {
  for (TableRow row : table3.rows()) {  
    velocity = row.getInt("C6H6(GT)");   
    sleep();
  }
}

void sound(){ 
      for (TableRow row : table.rows()) {
        int id = row.getInt("temp");
         if (id > 6){
           sleep();
           currentFreq = Frequency.ofPitch( "A4" );
         }
         if (id > 8){
           sleep();
           currentFreq = Frequency.ofPitch( "B4" );
         }
         if (id > 10){
           sleep();
           currentFreq = Frequency.ofPitch( "C#5" );
         }
         if (id > 12){
           sleep();
           currentFreq = Frequency.ofPitch( "D5" );
         }
         if (id > 14){
           sleep();
           currentFreq = Frequency.ofPitch( "E5" );
         }
         if (id > 16){
           sleep();
           currentFreq = Frequency.ofPitch( "F#5" );
         }
         if (id > 20) {
           sleep();
           currentFreq = Frequency.ofPitch( "G#5" );
         }
         if (id > 24) {
           sleep();
           currentFreq = Frequency.ofPitch( "A5" );
         }
         if (id > 28){
           sleep();
           currentFreq = Frequency.ofPitch( "B5" );
         }
         if (id > 32) {
           sleep();
           currentFreq = Frequency.ofPitch( "C#6" );
         }
         if (id > 34) {
           sleep();
           currentFreq = Frequency.ofPitch( "E6" );
         }
         wave.setFrequency( currentFreq );
         //System.out.print(currentFreq);
      }
    }

void sleep() {
  try {
    Thread.sleep(50);
  }
  catch(InterruptedException e) {
    System.out.println("got interrupted!");
  }
}