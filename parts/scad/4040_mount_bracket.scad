// profile
pr_side=40;
pr_slot = 8;
pr_wall = 4.5;
// mount bracket
mb_tick = 10;
arm_l = pr_side/2;


module mount_4040(width){
    linear_extrude(height = width, center = true, convexity = 10, twist = 0)
    union() {
        square([pr_side + mb_tick -5, mb_tick]);
       
        // Arm to slot
        translate([0, -arm_l, 0])
            square([mb_tick, arm_l]); 
        
        // Slot insert
        translate([mb_tick , -arm_l, 0])
            square([2, pr_slot/2]);
        
        // slot guide
        translate([pr_side/2 + mb_tick - pr_slot/2 , -3, 0])
            square([pr_slot, 3]);
    }
}

mount_4040(40);