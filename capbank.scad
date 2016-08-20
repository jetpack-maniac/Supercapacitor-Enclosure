
cellSize = 32.5;
numberCellLength = 3;
numberCellWidth = 2;
totalCells = numberCellLength*numberCellWidth;
height = 80;
buffer = 3;
    
module bankCore(){
    xBankLength = 2*buffer + numberCellLength*cellSize;
    yBankLength = 2*buffer + numberCellWidth*cellSize; 

    //cut the corners while drawing the shape out
    difference(){
        cube([xBankLength,yBankLength,height]);
        cube([3*buffer,3*buffer,height]);
        translate([xBankLength-3*buffer,0,0]) cube([3*buffer,3*buffer,height]);
        translate([xBankLength-3*buffer,yBankLength-3*buffer,0]) cube([3*buffer,3*buffer,height]);
        translate([0,yBankLength-3*buffer,0]) cube([3*buffer,3*buffer,height]);
    }
    
    translate([3*buffer,3*buffer,0]) cylinder(r=3*buffer, height);
    translate([xBankLength-3*buffer,3*buffer,0]) cylinder(r=3*buffer, height);
    translate([3*buffer,yBankLength-3*buffer,0]) cylinder(r=3*buffer, height);
    translate([xBankLength-3*buffer,yBankLength-3*buffer,0]) cylinder(r=3*buffer, height);
}

module cellConstructor(){
    for(x=[0:numberCellWidth-1]){
        for(y=[0:numberCellLength-1]){
            translate([buffer+(cellSize/2)+(cellSize*y),buffer+(cellSize/2)+(cellSize*x),buffer])
            cylinder(h = height-buffer, d = cellSize);
        }
     }
}

module supportSkeletize(){
    //this cuts away extra areas to reduce print time   
    for(x=[1:numberCellWidth-1]){
        for(y=[1:numberCellLength-1]){
            translate([buffer+(cellSize*1.5)+(cellSize*y),buffer+(cellSize*1.5)+(cellSize*x),buffer])
            cylinder(h = height-buffer, d = (cellSize/2)*0.9);
        }
    }
}

difference(){
    bankCore();
    cellConstructor();
    supportSkeletize();
}