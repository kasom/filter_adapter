$fn=120;

// true for 4" blower mount
blower_mount=false;

// true for 120mm fan
fan_mount=true;

blower_dia=103;

fan_size=120;
hole_dia=115;
base_dia=160;
base_thickness=1.2;
base_inner_thickness=2.0;
thickness=1.0;
height=8;
margin=0.5;
fan_edge_dia=10;

if (blower_mount) {
    difference() {
        union() {
            linear_extrude(base_inner_thickness) {
                circle(d=hole_dia);
            }
            linear_extrude(height) {
                circle(d=blower_dia+thickness*2);
            }
        }
        
        translate([0,0,-0.2]) linear_extrude(height+0.5) circle(d=blower_dia+margin);
    }
}

difference() {
    union() {
        linear_extrude(base_inner_thickness) {
            circle(d=base_dia-margin);
        }

        linear_extrude(height) {
                circle(d=hole_dia-margin);
        }
        
        if (fan_mount) {
            linear_extrude(base_thickness) {
                translate([fan_size/2,fan_size/2,0]) circle(d=fan_edge_dia);
                translate([fan_size/2,fan_size/-2,0]) circle(d=fan_edge_dia);
                translate([fan_size/-2,fan_size/-2,0]) circle(d=fan_edge_dia);
                translate([fan_size/-2,fan_size/2,0]) circle(d=fan_edge_dia);
                square(size=fan_size+fan_edge_dia/sqrt(2), center=true);
            }
        }
    }
    
    union() {
        translate([0,0,-0.2]) {
            linear_extrude(height+0.4) {
                    circle(d=hole_dia-margin-thickness*2);
            }
        }
        if (fan_mount) {
            translate([0,0,-0.2]) {
                linear_extrude(0.6) {
                    difference() {
                        offset(r=2) {
                            square(fan_size,center=true);
                        }
                        offset(r=1) {
                            square(fan_size,center=true);
                        }
                    }
                }
            }
        }
    }
}