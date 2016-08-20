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

bankCore();