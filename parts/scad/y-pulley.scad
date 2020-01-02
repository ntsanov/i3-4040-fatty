use <4040_mount_bracket.scad>

$fn = 64;

// plate
p_tck = 10;
p_width = 40;
profile_side=40;

holder_4040_offset = 7;
// x profile edge 
x_pe=p_width/2-holder_4040_offset-p_tck;

// GT2  belt
// Distance from profile edge to y carriage = 28
// Distance from y carriage  to belt= 17
// Distance from profile edge = 28 - 17 = 11
gt2_edge_offset=11;
gt2_teeth = 16;
// This is belt thickness minus the teeths
gt2_belt_h = 0.63;

gt2_pulley_d = gt2_teeth*2/PI;

// center to outer edge
gt2_ctoe = gt2_pulley_d/2 + gt2_belt_h;



// bearing
b_od = 14;
b_id = 5;
b_tck = 5;
b_y_off = -10;
// p_width/2 makes it on profile edge
//b_x_off = (11 - gt2_ctoe ) ;
b_x_off=x_pe-gt2_ctoe+gt2_edge_offset;

// shaft
shaft_length = 20;

module pulley_half() {
    difference(){
        union() {
            // Back plate
            translate([-p_width/2,-(p_width/2 + p_tck),0])
                cube([p_width, p_tck, shaft_length/2 + p_tck]);
            linear_extrude(height = 10, center = false, convexity = 10, twist = 0)
            difference() {
                    difference(){
                        square([p_width+24,p_width], center=true);
                        translate([p_width,0,0])
                        square(p_width, center=true);
                    }
                   
                translate([p_width,10,0])
                    rotate(60)
                    square([p_width, p_width*4],center=true);
                translate([0,p_width-15,0])
                    square([p_width*4, p_width], center=true);
            }
        }
        
        // Bearing socket
        translate([b_x_off, b_y_off ,p_tck - b_tck])
            cylinder(h = p_tck, d = b_od + 0.25, center=false );
        
        // Central shaft hole
        translate([b_x_off, b_y_off ,-p_tck/2])
           cylinder(h = p_tck*2, d = b_id+2, center=false );
        
        // Champhers 
        //  Outside
        //      top chamfer
        translate([p_width/2, 0, 0])
        rotate([0,45,0])
            cube([5, p_width*2, 5], center = true);
        
        //      front chamfer
        translate([0,p_width/2-15,0])
        rotate([45,-0,0])
            cube([p_width*4,5,5], center = true);
        
        //      slope chamfer
        translate([0,10,0])
        rotate([45, 0, -30])
            cube([p_width*2, 5, 5], center = true);
        
        //      bottom chamfer
        //translate([-p_width/2, 0, 0])
        //rotate([0,45,0])
       //     cube([5,p_width*2,5], center = true);
    }
}
translate([0,0,0])
difference(){

    union(){
    translate([(p_width-holder_4040_offset)/2  ,-p_width,0])
        //difference(){
            cube([holder_4040_offset ,p_width/2,shaft_length+2*p_tck], center=true);
        //}
    mirror([1,0,0])
        translate([0,0, shaft_length/2 + p_tck])
        mirror([1,0,0])
        mirror([0,0,1])
            pulley_half();
        translate([0, 0, -(shaft_length/2 + p_tck)])
            pulley_half();
    rotate([0,180,0])
        //!translate([-p_width/2+holder_4040_offset,-p_width+p_tck,0])
        translate([-(p_tck+3),-p_width+p_tck,0])
        difference(){
            mount_4040(shaft_length+p_tck*2);
           // Trim 45 grad from guide so it can be printed
            translate([26,-3,0])
            rotate([0,0,45])
                cube([4,4,shaft_length+p_tck*4], center=true);
        }
    }
                // M6 trough hole
            rotate([90,0,0])
            translate([-profile_side/2+3,0])
                #cylinder(h=80, d=6.2, center=true);
            // Screw head cut
            rotate([90,0,0])
            translate([-profile_side/2+3,0,p_width/2])
                #cylinder(h=5, d=14, center=true);
    // Extend chamfers
        // Right edge
        translate([p_width/2, -20, shaft_length/2+p_tck])
        rotate([0,45,0])
            cube([5, p_width*2, 5], center = true);
       // Left edge
        translate([p_width/2, -20, -shaft_length/2-p_tck])
        rotate([0,45,0])
            cube([5, p_width*2, 5], center = true);
       //    
 //       translate([p_width/2, -50, 0])
 //       rotate([0,0,45])
//            cube([5, 5, p_width*2], center = true);
    
        // diagonal cut
        translate([(p_width-holder_4040_offset)/2  ,-p_width-12,0])
            rotate([0,0,45])
            cube([80 ,p_width/2,shaft_length+4*p_tck], center=true);
}
