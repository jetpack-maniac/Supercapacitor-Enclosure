cellSize = 32.5;
numberCellLength = 2;
numberCellWidth = 3;
totalCells = numberCellLength*numberCellWidth;
height = 5;
buffer = 3;
xBankLength = 2*buffer + numberCellLength*cellSize;
yBankLength = 2*buffer + numberCellWidth*cellSize; 
screwSize = 3.5719;
screwLength = 10;
screwHeadLength = 3;
screwHeadDiameter = 4.2;

module bankCore(){
    //cut the corners while drawing the shape out
    difference(){
        cube([xBankLength,yBankLength,height]);
        cube([3*buffer,3*buffer,height]);
        translate([xBankLength-3*buffer,0,0]) cube([3*buffer,3*buffer,height]);
        translate([xBankLength-3*buffer,yBankLength-3*buffer,0]) cube([3*buffer,3*buffer,height]);
        translate([0,yBankLength-3*buffer,0]) cube([3*buffer,3*buffer,height]);
        screwTapping();
    }
    
    translate([3*buffer,3*buffer,0]) cylinder(r=3*buffer, height);
    translate([xBankLength-3*buffer,3*buffer,0]) cylinder(r=3*buffer, height);
    translate([3*buffer,yBankLength-3*buffer,0]) cylinder(r=3*buffer, height);
    translate([xBankLength-3*buffer,yBankLength-3*buffer,0]) cylinder(r=3*buffer, height);
}

module screwHead(){
    union(){
        cylinder(h = screwLength, d = screwSize);
        cylinder(h = screwHeadLength, d = screwHeadDiameter);
    }
    
}

module screwTapping(){
    for(x=[0:numberCellLength-1]){
        translate([buffer+cellSize+(cellSize*x),buffer,height-screwLength])
        screwHead();
        translate([buffer+cellSize+(cellSize*x),yBankLength-buffer,height-screwLength])
        screwHead();
    }

    for(y=[0:numberCellWidth-1]){
        translate([buffer,buffer+cellSize+(cellSize*y),height-screwLength])
        screwHead();
        translate([xBankLength-buffer,buffer+cellSize+(cellSize*y),height-screwLength])
        screwHead();
    }
}

bankCore();