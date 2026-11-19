// MiniBerth — editable nominal geometry, dimensions in mm.
// X runs right from the SSD side, Y runs rearward, Z starts at the feet.
$fn = 64;
epsilon = 0.02;
module rounded_rect(w, h, r) {
    offset(r=r) square([w-2*r, h-2*r], center=true);
}
module bay(x, width, radius) {
    translate([x,68.5,9]) linear_extrude(51) rounded_rect(width,129,radius);
}
module end_windows(x, z, width, height, radius) {
    for (y = [4+epsilon,137+epsilon])
        translate([x,y,z]) rotate([90,0,0]) linear_extrude(4+2*epsilon)
            rounded_rect(width,height,radius);
}
module body() {
    minkowski() {
        translate([78,68.5,6]) linear_extrude(52) rounded_rect(154,135,3);
        sphere(r=1);
    }
}
union() {
    difference() {
        body();
        bay(11.5,15,1);
        bay(87.5,129,4);
        end_windows(11.5,34,15,36,4);
        end_windows(87.5,30,116,26,8);
        for (y = [42,95])
            translate([-epsilon,y,34]) rotate([90,0,90]) linear_extrude(156+2*epsilon)
                rounded_rect(36,14,6);
        for (x = [37.5:10:137.5])
            translate([x,68.5,5-epsilon]) linear_extrude(4+2*epsilon)
                rounded_rect(5.6,104,2.5);
    }
    for (x = [10,146], y = [10,127])
        translate([x,y,0]) cylinder(h=5+epsilon,r1=5,r2=8);
}
