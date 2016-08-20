cellSize = 32.5;
numberCellLength = 2;
numberCellWidth = 3;
totalCells = numberCellLength*numberCellWidth;
height = 5;
buffer = 3;
xBankLength = 2*buffer + numberCellLength*cellSize;
yBankLength = 2*buffer + numberCellWidth*cellSize;
screwSize = 2.9;
screwLength = 5;
screwHeadLength = 3;
screwHeadDiameter = 4.2;
boltDiameter = 5;
boltHeight = 10;

module lidConstructor(){
  //cut the corners while drawing the shape out
  difference(){
    cube([xBankLength, yBankLength, height]);
    cube([3*buffer, 3*buffer, height]);
    translate([xBankLength - 3*buffer, 0, 0])
      cube([3*buffer, 3*buffer, height]);
    translate([xBankLength - 3*buffer, yBankLength-3*buffer, 0])
      cube([3*buffer, 3*buffer, height]);
    translate([0, yBankLength - 3*buffer, 0])
      cube([3*buffer, 3*buffer, height]);
    screwTapping();
  }

  translate([3*buffer, 3*buffer, 0])
    cylinder(r=3*buffer, height);
  translate([xBankLength-3*buffer,3*buffer,0])
    cylinder(r=3*buffer, height);
  translate([3*buffer,yBankLength-3*buffer,0])
    cylinder(r=3*buffer, height);
  translate([xBankLength-3*buffer,yBankLength-3*buffer,0])
    cylinder(r=3*buffer, height);
}

module screwHead(){
  union(){
    cylinder(h = screwLength, d = screwSize, $fn = 40);
    cylinder(h = screwHeadLength, d = screwHeadDiameter, $fn = 40);
  }
}

module screwTapping(){
  // these two cut exterior screwhead holes in the lid
  for(x = [0:numberCellLength - 1]){
    translate([buffer + cellSize + (cellSize*x), buffer, height - screwLength])
      screwHead();
    translate([buffer + cellSize + (cellSize*x), yBankLength - buffer, height - screwLength])
      screwHead();
  }

  for(y = [0:numberCellWidth - 1]){
    translate([buffer, buffer + cellSize + (cellSize*y), height - screwLength])
      screwHead();
    translate([xBankLength - buffer, buffer + cellSize + (cellSize*y), height - screwLength])
      screwHead();
    
    // this cuts the bolt terminal holes
    translate([buffer + cellSize/2, buffer + cellSize/2, 0])
      cylinder(d = boltDiameter, h = boltHeight, $fn = 20);
    translate([xBankLength - buffer - cellSize/2, buffer + cellSize/2, 0])
      cylinder(d = boltDiameter, h = boltHeight, $fn = 20);
  }
}

lidConstructor();
