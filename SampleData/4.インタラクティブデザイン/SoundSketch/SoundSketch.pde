import processing.sound.*;//Import Sound Libraries
AudioIn in;
Amplitude amp;

import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress RemoteLocation;

void setup() {
  size(500, 500);
  fill(0, 0, 255);
  noStroke();
  in = new AudioIn(this, 0);
  in.start();
  amp = new Amplitude(this);
  amp.input(in);

  OscProperties oscProperties = new OscProperties();
  oscP5 = new OscP5(this,oscProperties);
  RemoteLocation = new NetAddress("127.0.0.1",7000);

}

void draw() {
  background(0);
  int scale = 3;//Scale diameter
  float diameter = map(amp.analyze(), 0.0, 1.0, 0.0, width*scale);
  ellipse(width/2, height/2, diameter, diameter);
  
  OscMessage Message = new OscMessage("/Sound");
  Message.add(amp.analyze());
  oscP5.send(Message, RemoteLocation); 

}