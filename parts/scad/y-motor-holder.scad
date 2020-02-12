use <4040_mount_bracket.scad>

$fn=64;
n17_side = 42.3;
n17_hole_distance = 31;
n17_hole_from_side = 5.65;
n17_hole_from_bottom = 5.65;
n17_screw_d = 3.2;
n17_screw_head_d = 6.2;
n17_screw_head_h = 8;
p_thck = 22.5;
p_width = 42.3;
p_length = 42.3;

// GT2  belt
// Distance from profile edge to y carriage = 28
// Distance from y carriage  to belt= 17
// Distance from edge = 28 - 17 = 11
gt2_edge_offset=11;
gt2_teeth = 16;
// This is belt thickness minus the teeths
gt2_belt_h = 0.63;

gt2_pulley_d = gt2_teeth*2/PI;

// center to outer edge
gt2_ctoe = gt2_pulley_d/2 + gt2_belt_h;

// belt to holder top
gt2_btht=p_width/2-gt2_ctoe;

central_hole_d=24;

belt_side_hole_d= 15;

//bearing
b_id = 5;
b_od = 14;
b_thck = 5;

// profile
pr_side=40;
pr_slot = 8;
pr_wall = 4.5;
// mount bracket
mb_tick = 10;
arm_l = pr_side/2;
// x offset
mb_x_offset = gt2_btht - mb_tick + gt2_edge_offset;
echo("mb_x_offset: ", mb_x_offset);

module rotate_about_pt(a, v, pt) {
    translate(pt)
        rotate(a,v)
            translate(-pt)
                children();   
}


module motor_mount(){
    difference() {
        union(){
            cube([p_width, p_length, p_thck]);
            translate([n17_side/2, p_length/2 , -b_thck])
                cylinder( h = b_thck+0.2, r1 = b_id+5, r2 = b_id*3, center = false);
            translate([p_width-mb_x_offset,p_length,0])
                cube([mb_x_offset, 15, p_thck]);
        }
        
        // Belt side hole
        rotate([90,0,0])
        translate([p_width/2,p_thck/2,-p_length/2])
            cylinder( h = p_length/2+0.1, d= belt_side_hole_d);

        // Upper hole
        rotate([0,90,0])
        // translate([p_width/2,p_thck/2,-p_length/2])
            translate([-p_thck/2,p_width/2,p_length/2+0.1])
            cylinder( h = p_length/2+0.1, d= belt_side_hole_d);
        
         // central hole
        translate([n17_side/2, p_length/2 , b_thck])
            cylinder( h = p_thck, d = central_hole_d, center = false);
            
           // bearing socket
        translate([n17_side/2, p_length/2 , -0.1])
            cylinder( h = b_thck+0.2, d = b_od, center = false);
            
         // shaft hole
        translate([n17_side/2, p_length/2 , -p_thck/2])
            cylinder( h = p_thck*2, d = b_id+1, center = false);
        
        
        // Up/Down cross hole
        //#rotate([0,90,0])
        //translate([-p_width/2,p_thck,-0.1])
        //    cylinder( h = p_length+0.2, d= belt_side_hole_d);
        
        // Screw Holes
         translate([n17_hole_from_side, n17_hole_from_bottom, -p_thck/2])
            cylinder( h = p_thck*2, d=n17_screw_d, center=false);
         translate([n17_hole_from_side+n17_hole_distance, n17_hole_from_bottom,  -p_thck/2])
            cylinder( h = p_thck*2, d=n17_screw_d, center=false);
         translate([n17_hole_from_side, n17_hole_from_bottom+n17_hole_distance, -p_thck/2])
            cylinder( h = p_thck*2, d=n17_screw_d, center=false);
        translate([n17_hole_from_side+n17_hole_distance, n17_hole_from_bottom + n17_hole_distance,  -p_thck/2])
            cylinder( h = p_thck*2, d=n17_screw_d, center=false);
        
        // Screw Head
        translate([n17_hole_from_side, n17_hole_from_bottom, -0.1])
            cylinder( h = n17_screw_head_h+0.1, d=n17_screw_head_d, center=false);
        translate([n17_hole_from_side+n17_hole_distance, n17_hole_from_bottom,-0.1])
            cylinder( h = n17_screw_head_h+0.1, d=n17_screw_head_d, center=false);
        translate([n17_hole_from_side, n17_hole_from_side+n17_hole_distance, -0.1])
            cylinder( h = n17_screw_head_h+0.1, d=n17_screw_head_d, center=false);
        translate([n17_hole_from_side+n17_hole_distance, n17_hole_from_side+n17_hole_distance, -0.1])
            cylinder( h = n17_screw_head_h+0.1, d=n17_screw_head_d, center=false);
        
       
        // cut right corners
        // translate([p_width/2 - 5, 13, -p_thck/2])
        //    cube([p_width, 50 , p_thck*2]);
      
        rotate_about_pt(45, 0, [0, 0, 0])
            translate([-2, -10, -p_thck/2])
                cube([5, 20, p_thck*2]);
        
        translate([p_width,0,0])
            rotate_about_pt(-45, 0, [0, 0, 0])
                translate([-2, -10, -p_thck/2])
                    cube([5, 20, p_thck*2]);
        // translate([0, p_length,0])
        //     rotate_about_pt(-45, 0, [0, 0, 0])
        //         translate([-2, -10, -p_thck/2])
        //             cube([5, 20, p_thck*2]);
            
        translate([p_width, p_length,0])
        rotate_about_pt(45, 0, [0, 0, 0])
        translate([-2, -10, -p_thck/2])
            cube([20, 40, p_thck*2]);
        /*
            */
        
        /*
        translate([p_width/2-5, p_length,0])
        rotate_about_pt(45, 0, [0, 0, 0])
        translate([-2, -10, -p_thck/2])
        cube([5, 20, p_thck*2]);
        
        translate([p_width,13,0])
        rotate_about_pt(45, 0, [0, 0, 0])
        translate([-2, -10, -p_thck/2])
        cube([5, 20, p_thck*2]);
        */
    }
}

rotate_about_pt(180, 0, [p_width/2, p_length/2, 0])

difference() {
    union (){
        motor_mount();
        translate([p_length-mb_x_offset, p_width+mb_tick, p_thck/2])
        rotate([0,0,180])
        mount_4040(p_thck);
        translate([-7.5,p_length-5,p_thck/2])
        difference() {
            cube([15,15,p_thck],center=true);
            translate([-5,-3,0])
            rotate([0,0,135])
            cube([30,12,p_thck+1], center=true);
            
        }
        // translate([p_width-10,p_length+7.5,p_thck/2])
        // difference() {
        //     cube([15,15,p_thck],center=true);
        //     translate([10,10.9,0])
        //     rotate([0,0,45])
        //     cube([30,25,p_thck+1], center=true);
            
        // }

    }
    // Mounting screw
    translate([p_length-mb_x_offset-30,50,p_thck/2])
    rotate([90,0,0])
        cylinder( d = 6.2,  h=100, center=true);

    // Mounting screw head
    translate([p_length-mb_x_offset-30,35,p_thck/2])
    rotate([90,0,0])
        cylinder( d = 11.5, h=25, center=true);
}
//     }


// translate([p_length-mb_x_offset, p_width+mb_tick, p_thck/2])
//     rotate([0,0,180])
//     difference() {
// linear_extrude(height = p_thck, center = true, convexity = 10, twist = 0)
//         union() {
//             square([pr_side + mb_tick -5, mb_tick]);
        
//             // Arm to slot
//             translate([0, -arm_l, 0])
//                 square([mb_tick, arm_l]); 
            
//             // Slot insert
//             translate([mb_tick , -arm_l, 0])
//                 square([2, pr_slot/2]);
            
//             // slot guide
//             translate([pr_side/2 + mb_tick - pr_slot/2 , -4, 0])
//                 square([pr_slot, 4]);
//         }
//         translate([-mb_tick,0,0])
//         #cube(p_thck, center = true);
//         translate([pr_side/2+mb_tick,0,0])
//         rotate([90,0,0])
//             cylinder( d = 6.2,  100, center=true);
//     }