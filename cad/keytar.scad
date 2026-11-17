// Guitarra Matbit — Arturia MiniLab MkII (bottom view). Units: millimetres.
// V4: SOCKET ONLY. NO NECK, neither printable nor illustrative.
// PROTOTYPE: screws, case clearances, materials and load capacity NOT VERIFIED.
// X left-to-right; Y top-to-bottom on underside; Z points AWAY from controller.
// Export: openscad -o assembly_socket.stl -D 'mode="assembly_socket"' cad/keytar.scad
mode="preview_socket"; $fn=48;

keyboard_x=355; keyboard_y=221; keyboard_z=32; // 32 mm is photo annotation, NOT verified
mount_top=[[23,117],[125,117],[225,117],[310,117]];
mount_bottom=[[25,162],[126,162],[225,162],[311,162]];
// Eleven PHOTO-ONLY reference points (disabled as holes until measured).
large_top=[[11,8],[125,10],[238,12],[345,9]];
large_middle=[[12,110],[238,109],[346,112]];
large_bottom=[[10,213],[124,216],[237,215],[348,212]];
use_unverified_large_holes=false; // NEVER true without real measurements
small_hole_d=5.5; large_hole_d=6.5; // provisional clearance, not screw threads

plate_t=5.5; rail_w=17; brace_w=16;
seam_x=169; left_x0=14; right_x1=350;
rail_rows=[12,117,162,209];
join_left_x=160; join_right_x=178;
join_boss_d=12; join_boss_h=8; join_insert_d=4.1; // M3 heat-set insert: verify manufacturer
join_pilot_depth=6; join_hole_d=3.5; join_clip_t=4;

// Real metal strap buttons with owner's #6 x 25mm screws (NOT printed).
// Printed pilot dimensions only; no rated strength or safety approval.
strap_rear_x=-26; strap_rear_y=141;
strap_front_x=359; strap_front_y=142;
strap_boss_d=26; strap_boss_h=35;
strap_screw_nominal_d=3.5; strap_screw_length=25;
strap_pilot_d=2.7; strap_pilot_depth=27;

// User's wooden bar is 50 x 31mm; bar itself is not in any mesh.
wood_width=50; wood_thickness=31;
wood_clearance=0.6; // EACH SIDE, fit test before final use
wood_socket_depth=70; // PROVISIONAL overall length including 7mm stop
wood_wall=10; wood_floor=9; wood_stop=7; wood_cap_t=6;
wood_crossbolt_d=5.5; wood_crossbolt_x=[27,50]; // M5 provisional, drill wood, NOT keyboard
wood_lid_pilot_d=2.5; wood_lid_clearance_d=3.5; wood_lid_fastener_x=[15,57]; // M3 provisional
socket_root_x=301; socket_root_y=86; socket_angle=-18;

function all_large()=concat(large_top,large_middle,large_bottom);
function channel_w()=wood_width+2*wood_clearance;
function socket_w()=channel_w()+2*wood_wall;
function socket_h()=wood_floor+wood_thickness+2*wood_clearance;
function bolt_center_z()=wood_floor+wood_thickness/2+wood_clearance;
function lid_y()=channel_w()/2+wood_wall/2;

module rectangle(x0,x1,y0,y1,height,z=0) {
  translate([x0,y0,z]) cube([x1-x0,y1-y0,height]);
}
module rails(x0,x1) {
  for(y=rail_rows) rectangle(x0,x1,y-rail_w/2,y+rail_w/2,plate_t);
}
module upright(x) { rectangle(x-brace_w/2,x+brace_w/2,3.5,217.5,plate_t); }
module screw_holes(points) {
  for(p=points) translate([p[0],p[1],-1]) cylinder(d=small_hole_d,h=plate_t+2);
}
module unverified_holes(points) {
  if(use_unverified_large_holes)
    for(p=points) translate([p[0],p[1],-1]) cylinder(d=large_hole_d,h=plate_t+2);
}
module boss(x,y) { translate([x,y,0]) cylinder(d=strap_boss_d,h=strap_boss_h); }
module boss_pilot(x,y) {
  translate([x,y,strap_boss_h-strap_pilot_depth])
    cylinder(d=strap_pilot_d,h=strap_pilot_depth+1);
}
module rear_horn() {
  linear_extrude(height=plate_t+3)
    hull() {
      translate([strap_rear_x,strap_rear_y]) circle(d=strap_boss_d);
      translate([23,117]) circle(d=22);
      translate([25,162]) circle(d=22);
    }
}
module front_horn() {
  linear_extrude(height=plate_t+3)
    hull() {
      translate([strap_front_x,strap_front_y]) circle(d=strap_boss_d);
      translate([310,117]) circle(d=22);
      translate([311,162]) circle(d=22);
    }
}
module join_boss(x,y) {
  translate([x,y,plate_t]) cylinder(d=join_boss_d,h=join_boss_h);
}
module join_insert_pilot(x,y) {
  // Blind; no hole passes into the keyboard case.
  translate([x,y,plate_t+join_boss_h-join_pilot_depth])
    cylinder(d=join_insert_d,h=join_pilot_depth+1);
}
module left_blank() {
  union() {
    rails(left_x0,seam_x);
    upright(23); upright(125);
    rear_horn(); boss(strap_rear_x,strap_rear_y);
    for(y=rail_rows) join_boss(join_left_x,y);
  }
}
module mount_left() {
  difference() {
    left_blank();
    screw_holes([mount_top[0],mount_top[1],mount_bottom[0],mount_bottom[1]]);
    unverified_holes([for(p=all_large()) if(p[0]<seam_x) p]);
    for(y=rail_rows) join_insert_pilot(join_left_x,y);
    boss_pilot(strap_rear_x,strap_rear_y);
  }
}
module root_plate() {
  // Wide triangular path connects socket floor to two mounting rows.
  linear_extrude(height=plate_t+5)
    polygon([[262,118],[286,65],[327,52],[354,76],[358,113],
             [324,171],[291,172],[283,147]]);
}
module right_blank() {
  union() {
    rails(seam_x,right_x1);
    upright(225); upright(310);
    root_plate(); front_horn(); boss(strap_front_x,strap_front_y);
    for(y=rail_rows) join_boss(join_right_x,y);
  }
}
module socket_frame() {
  // Positive solid U, blind backstop at x=0, open at x=depth.
  // Three-sided mechanical cup, not a free-floating decorative hole.
  rectangle(0,wood_socket_depth,-socket_w()/2,socket_w()/2,wood_floor);
  rectangle(0,wood_socket_depth,-socket_w()/2,-channel_w()/2,socket_h());
  rectangle(0,wood_socket_depth,channel_w()/2,socket_w()/2,socket_h());
  rectangle(0,wood_stop,-channel_w()/2,channel_w()/2,socket_h());
}
module socket_bolt_bores() {
  for(x=wood_crossbolt_x)
    translate([x,-socket_w()/2-1,bolt_center_z()])
      rotate([-90,0,0]) cylinder(d=wood_crossbolt_d,h=socket_w()+2);
}
module socket_lid_pilots() {
  for(x=wood_lid_fastener_x,y=[-lid_y(),lid_y()])
    translate([x,y,socket_h()-13]) cylinder(d=wood_lid_pilot_d,h=14);
}
module socket_cradle() {
  difference() {
    socket_frame();
    socket_bolt_bores();
    socket_lid_pilots();
  }
}
module socket_cap() {
  difference() {
    rectangle(0,wood_socket_depth,-socket_w()/2,socket_w()/2,wood_cap_t);
    for(x=wood_lid_fastener_x,y=[-lid_y(),lid_y()])
      translate([x,y,-1]) cylinder(d=wood_lid_clearance_d,h=wood_cap_t+2);
  }
}
module socket_placed() {
  translate([socket_root_x,socket_root_y,plate_t]) rotate([0,0,socket_angle]) children();
}
module socket_base_right() {
  difference() {
    union() { right_blank(); socket_placed() socket_cradle(); }
    screw_holes([mount_top[2],mount_top[3],mount_bottom[2],mount_bottom[3]]);
    unverified_holes([for(p=all_large()) if(p[0]>=seam_x) p]);
    for(y=rail_rows) join_insert_pilot(join_right_x,y);
    boss_pilot(strap_front_x,strap_front_y);
  }
}
module join_clip() {
  // Four clips bridge the two halves, using 8 blind M3 inserts in bosses.
  difference() {
    hull() {
      translate([join_left_x,0,0]) cylinder(d=12,h=join_clip_t);
      translate([join_right_x,0,0]) cylinder(d=12,h=join_clip_t);
    }
    for(x=[join_left_x,join_right_x])
      translate([x,0,-1]) cylinder(d=join_hole_d,h=join_clip_t+2);
  }
}
module wood_fit_coupon() {
  // Section test, NOT a second neck and NOT an installation-ready socket.
  difference() {
    rectangle(0,16,-socket_w()/2,socket_w()/2,socket_h());
    rectangle(-1,17,-channel_w()/2,channel_w()/2,socket_h()+1,wood_floor);
  }
}
module screw_fit_coupon() {
  difference() {
    rectangle(0,84,0,18,plate_t);
    for(i=[0:4]) translate([9+16*i,9,-1]) cylinder(d=3+0.5*i,h=plate_t+2);
  }
}
module join_clips_placed() {
  // 0.6mm air gap for a readable non-fused STL assembly.
  for(y=rail_rows) translate([0,y,plate_t+join_boss_h+0.6]) join_clip();
}
module assembly_socket() {
  mount_left(); socket_base_right(); join_clips_placed();
  socket_placed() translate([0,0,socket_h()+1]) socket_cap();
  // No wooden neck, printed neck, or imaginary extension in this file.
}
module preview_case() {
  color([0.73,0.79,0.82,0.6])
    difference() {
      rectangle(0,keyboard_x,0,keyboard_y,1,-2);
      rectangle(3,keyboard_x-3,3,keyboard_y-3,3,-3);
    }
}
module preview_screw_map() {
  color([0.96,0.65,0.10]) for(p=all_large())
    translate([p[0],p[1],-0.8]) cylinder(d=large_hole_d,h=0.7);
  color([0.10,0.45,0.96]) for(p=concat(mount_top,mount_bottom))
    translate([p[0],p[1],-0.8]) cylinder(d=small_hole_d-0.7,h=0.7);
}
module preview_socket() {
  preview_case();
  color([0.85,0.18,0.14]) { mount_left(); socket_base_right(); }
  color([0.15,0.33,0.65]) join_clips_placed();
  color([0.95,0.73,0.21]) socket_placed()
    translate([0,0,socket_h()+1]) socket_cap();
  preview_screw_map();
}

if(mode=="mount_left") mount_left();
else if(mode=="socket_base_right") socket_base_right();
else if(mode=="socket_cap") socket_cap();
else if(mode=="wood_fit_coupon") wood_fit_coupon();
else if(mode=="screw_fit_coupon") screw_fit_coupon();
else if(mode=="join_clip") join_clip();
else if(mode=="assembly_socket") assembly_socket();
else if(mode=="preview_socket") preview_socket();
else echo("Unknown mode: ",mode);
