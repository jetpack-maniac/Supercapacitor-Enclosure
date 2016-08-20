
cellSize = 32.5;
numberCellLength = 2;
numberCellWidth = 3;
totalCells = numberCellLength*numberCellWidth;
height = 80;
buffer = 3;
xBankLength = 2*buffer + numberCellLength*cellSize;
yBankLength = 2*buffer + numberCellWidth*cellSize;
screwSize = 3.4;
screwLength = 10;

module bankCore(){
  //cut the corners while drawing the shape out
  difference(){
      cube([xBankLength, yBankLength, height]);
      cube([3*buffer, 3*buffer, height]);
      translate([xBankLength - 3*buffer, 0, 0])
        cube([3*buffer, 3*buffer, height]);
      translate([xBankLength - 3*buffer, yBankLength - 3*buffer, 0])
        cube([3*buffer, 3*buffer, height]);
      translate([0, yBankLength - 3*buffer, 0])
        cube([3*buffer,3*buffer,height]);
      screwTapping();
    }

    translate([3*buffer, 3*buffer, 0])
      cylinder(r = 3*buffer, height);
    translate([xBankLength - 3*buffer, 3*buffer, 0])
      cylinder(r=3*buffer, height);
    translate([3*buffer, yBankLength-3*buffer, 0])
      cylinder(r=3*buffer, height);
    translate([xBankLength - 3*buffer, yBankLength - 3*buffer, 0])
      cylinder(r=3*buffer, height);
}

module cellConstructor(){
  for(x = [0:numberCellWidth - 1]){
    for(y = [0:numberCellLength - 1]){
      translate([buffer + (cellSize/2) + (cellSize*y), buffer + (cellSize/2) + (cellSize*x), buffer])
        cylinder(h = height-buffer, d = cellSize, $fn = 90);
    }
  }
}

module supportSkeletize(){
  //this cuts away extra areas to reduce print time
  for(x=[1:numberCellWidth-1]){
    for(y=[1:numberCellLength-1]){
      translate([buffer+cellSize+(cellSize*(y-1)),buffer+cellSize+(cellSize*(x-1)),buffer])
      cylinder(h = height-buffer, d = (cellSize/2)*0.70);
    }
  }
}

module screwTapping(){
  for(x=[0:numberCellLength-1]){
    translate([buffer+cellSize+(cellSize*x),buffer,height-screwLength])
    cylinder(h = screwLength, d = screwSize, $fn = 12);
    translate([buffer+cellSize+(cellSize*x),yBankLength-buffer,height-screwLength])
    cylinder(h = screwLength, d = screwSize, $fn = 12);
  }

  for(y=[0:numberCellWidth-1]){
    translate([buffer,buffer+cellSize+(cellSize*y),height-screwLength])
    cylinder(h = screwLength, d = screwSize, $fn = 12);
    translate([xBankLength-buffer,buffer+cellSize+(cellSize*y),height-screwLength])
    cylinder(h = screwLength, d = screwSize, $fn = 12);
  }
}

// Final Assembly!

difference(){
  bankCore();
  cellConstructor();
  supportSkeletize();
}
