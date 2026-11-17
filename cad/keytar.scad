// Guitarra Matbit / Arturia MiniLab MkII. ALL UNITS IN MILLIMETERS.
// PROTOTYPE ONLY. Dimensions of mounting screws and metal bar are NOT validated.
// Coordinate frame: underside view, X left->right, Y top->bottom, Z away from keyboard.
// Export: openscad -o part.stl -D 'mode="metal_base_right"' cad/keytar.scad
mode="preview_metal"; $fn=32;
keyboard_x=355; keyboard_y=221; keyboard_z=50;
mount_top=[[23,117],[125,117],[225,117],[310,117]];
mount_bottom=[[25,162],[126,162],[225,162],[311,162]];
// EIGHT owner-measured interior positions above are preserved EXACTLY.
 // Additional perimeter/interior candidates traced from photos are ESTIMATES ONLY.
 // Some screw heads are hidden by markings; candidates are NOT drilling coordinates.
large_top=[[11,8],[125,10],[238,12],[345,9]];
large_middle=[[12,110],[238,109],[346,112]];
large_bottom=[[10,213],[124,216],[237,215],[348,212]];
use_unverified_large_holes=false; // MUST remain false until measured on actual keyboard
small_hole_d=5.5; // PROVISIONAL passage diameter: NOT thread/head measurement
large_hole_d=6.5; // PROVISIONAL; currently not used for cutting
mount_hole_d=small_hole_d;
join_hole_d=3.5; lap_hole_d=4.5;
plate_t=4.5; rail_w=18; brace_w=16; left_x0=14; seam_x=170; right_x1=354;
// Strap anchors: not approved for load bearing until physical testing.
// Replace strap slots with thick blind-screw mounts for #6 x25mm strap buttons.
strap_rear_x=-29; strap_rear_y=145; strap_front_x=359; strap_front_y=139;
strap_extra_t=3; strap_boss_d=23; strap_boss_h=33;
strap_screw_nominal_d=3.5; strap_screw_length=25;
strap_pilot_d=2.7; strap_pilot_depth=27;
metal_bar_w=25; // PLACEHOLDER rectangular metal profile
metal_bar_t=3;  // PLACEHOLDER rectangular metal profile
metal_clearance=0.6;
socket_len=72; socket_wall=9; socket_floor=5; cap_t=5; socket_stop_t=7;
neck_x=308; neck_y=87; neck_angle=-18; neck_t=12;
neck_len=375; head_len=35; neck_start_w=48; neck_end_w=31;
first_joint=50; second_joint=220; joint_lap=20; neck_bolt_offset=11;
function getw(u)=neck_start_w+(neck_end_w-neck_start_w)*u/neck_len;
module cubexy(x0,x1,y0,y1,h,z=0) {
  translate([x0,y0,z]) cube([x1-x0,y1-y0,h]);
}
module vertical_brace(cx) {
  // A provisional frame across the 4 y rows. Check interference with rubber feet.
  cubexy(cx-brace_w/2,cx+brace_w/2,3,219,plate_t);
}
module mount_rails(x0,x1) {
  for(y=[117,162]) cubexy(x0,x1,y-rail_w/2,y+rail_w/2,plate_t);
  for(y=[10,212]) cubexy(x0,x1,y-7,y+7,plate_t);
}
function all_large()=concat(large_top,large_middle,large_bottom);
function left_large()=[for(p=all_large()) if(p[0]<seam_x) p];
function right_large()=[for(p=all_large()) if(p[0]>=seam_x) p];
module large_mount_candidate_holes(pts) {
  // Disabled by default: photo-only locations MUST be measured before activation.
  if(use_unverified_large_holes)
    for(p=pts) translate([p[0],p[1],-1]) cylinder(d=large_hole_d,h=plate_t+25);
}
module keyboard_screw_holes(points) {
  for(p=points) translate([p[0],p[1],-1]) cylinder(d=mount_hole_d,h=plate_t+23);
}
module join_screw_holes(x) {
  for(y=[10,117,162,212]) translate([x,y,-1]) cylinder(d=join_hole_d,h=plate_t+23);
}
// Solid strap button mounts with BLIND pilot holes.
module strap_boss(cx,cy) {
  translate([cx,cy,0]) cylinder(d=strap_boss_d,h=strap_boss_h);
}
module strap_pilot(cx,cy) {
  translate([cx,cy,strap_boss_h-strap_pilot_depth])
    cylinder(d=strap_pilot_d,h=strap_pilot_depth+1);
}
module rear_horn() {
  linear_extrude(height=plate_t+strap_extra_t)
  hull() {
    translate([-29,134]) circle(r=12);
    translate([-29,157]) circle(r=12);
    translate([23,117]) circle(r=15);
    translate([25,162]) circle(r=15);
  }
}
module front_horn() {
  linear_extrude(height=plate_t+strap_extra_t)
  hull() {
    translate([327,117]) circle(r=13);
    translate([360,129]) circle(r=15);
    translate([359,151]) circle(r=15);
    translate([312,162]) circle(r=12);
  }
}
module mount_left() {
  difference() {
    union() { mount_rails(left_x0,seam_x); vertical_brace(12); vertical_brace(125); rear_horn(); strap_boss(strap_rear_x,strap_rear_y); }
    keyboard_screw_holes([mount_top[0],mount_top[1],mount_bottom[0],mount_bottom[1]]);
    large_mount_candidate_holes(left_large());
    join_screw_holes(161);
    strap_pilot(strap_rear_x,strap_rear_y);
  }
}
module root_gusset() {
  linear_extrude(height=plate_t+3)
    polygon(points=[[272,108],[308,72],[327,64],[355,77],[356,113],
                    [327,151],[306,170],[285,170],[296,139]]);
}
module mount_right_blank() {
  union() { mount_rails(seam_x,right_x1); vertical_brace(238); vertical_brace(346); root_gusset(); front_horn(); strap_boss(strap_front_x,strap_front_y); }
}
module mount_right() {
  difference() {
    mount_right_blank();
    keyboard_screw_holes([mount_top[2],mount_top[3],mount_bottom[2],mount_bottom[3]]);
    large_mount_candidate_holes(right_large());
    join_screw_holes(179);
    strap_pilot(strap_front_x,strap_front_y);
  }
}
module join_clip() {
  difference() {
    cubexy(152,188,-8,8,3.5);
    for(x=[161,179]) translate([x,0,-1]) cylinder(d=join_hole_d,h=6);
  }
}
module neck_prism() {
  difference() {
    linear_extrude(height=neck_t) polygon(points=[
      [0,-neck_start_w/2],[neck_len,-neck_end_w/2],
      [neck_len+head_len,-22],[neck_len+head_len,22],
      [neck_len,neck_end_w/2],[0,neck_start_w/2]]);
    for(u=[90:34:350]) translate([u,-26,neck_t-0.7]) cube([1.2,52,1.4]);
  }
}
module neck_region(a,b,z0,z1) {
  intersection() { neck_prism(); cubexy(a,b,-35,35,z1-z0,z0); }
}
module neck_lap_holes(j) {
  for(u=[j-neck_bolt_offset,j+neck_bolt_offset])
    translate([u,0,-2]) cylinder(d=lap_hole_d,h=neck_t+4);
}
module neck_piece(which) {
  difference() {
    union() {
      if(which==0) {
        neck_region(0,first_joint-joint_lap,0,neck_t);
        neck_region(first_joint-joint_lap,first_joint+joint_lap,0,neck_t/2);
      }
      if(which==1) {
        neck_region(first_joint-joint_lap,first_joint+joint_lap,neck_t/2,neck_t);
        neck_region(first_joint+joint_lap,second_joint-joint_lap,0,neck_t);
        neck_region(second_joint-joint_lap,second_joint+joint_lap,0,neck_t/2);
      }
      if(which==2) {
        neck_region(second_joint-joint_lap,second_joint+joint_lap,neck_t/2,neck_t);
        neck_region(second_joint+joint_lap,neck_len+head_len,0,neck_t);
      }
    }
    if(which==0 || which==1) neck_lap_holes(first_joint);
    if(which==1 || which==2) neck_lap_holes(second_joint);
  }
}
module neck_placed() {
  translate([neck_x,neck_y,plate_t]) rotate([0,0,neck_angle]) children();
}
module integrated_root() {
  difference() {
    union() { mount_right_blank(); neck_placed() neck_piece(0); }
    keyboard_screw_holes([mount_top[2],mount_top[3],mount_bottom[2],mount_bottom[3]]);
    large_mount_candidate_holes(right_large());
    join_screw_holes(179);
    strap_pilot(strap_front_x,strap_front_y);
  }
}
module integrated_full_right() {
  difference() {
    union() { mount_right_blank(); neck_placed() neck_prism(); }
    keyboard_screw_holes([mount_top[2],mount_top[3],mount_bottom[2],mount_bottom[3]]);
    large_mount_candidate_holes(right_large());
    join_screw_holes(179);
    strap_pilot(strap_front_x,strap_front_y);
  }
}
function channel_w()=metal_bar_w+2*metal_clearance;
function socket_w()=channel_w()+2*socket_wall;
function socket_h()=socket_floor+metal_bar_t-0.2;
module socket_cradle() {
  difference() {
    cubexy(0,socket_len,-socket_w()/2,socket_w()/2,socket_h());
    // Fixed 7mm inner end stop: metal slides in from the outer end.
    cubexy(socket_stop_t,socket_len+1,-channel_w()/2,channel_w()/2,socket_h()+1,socket_floor);
    for(x=[19,53],y=[-socket_w()/2+socket_wall/2,socket_w()/2-socket_wall/2])
      translate([x,y,-1]) cylinder(d=lap_hole_d,h=socket_h()+4);
  }
}
module socket_cap() {
  difference() {
    cubexy(0,socket_len,-socket_w()/2,socket_w()/2,cap_t);
    for(x=[19,53],y=[-socket_w()/2+socket_wall/2,socket_w()/2-socket_wall/2])
      translate([x,y,-1]) cylinder(d=lap_hole_d,h=cap_t+2);
  }
}
module socket_placed() {
  translate([neck_x,neck_y,plate_t]) rotate([0,0,neck_angle]) children();
}
module metal_base_right() {
  difference() {
    union() { mount_right_blank(); socket_placed() socket_cradle(); }
    keyboard_screw_holes([mount_top[2],mount_top[3],mount_bottom[2],mount_bottom[3]]);
    large_mount_candidate_holes(right_large());
    join_screw_holes(179);
    strap_pilot(strap_front_x,strap_front_y);
  }
}
module fit_coupon() {
  difference() {
    cube([100,20,plate_t]);
    for(i=[0:5]) translate([11+i*16,10,-1])
      cylinder(d=3+i*0.5,h=plate_t+2);
  }
}
module join_clips_placed() { for(y=[117,162]) translate([0,y,plate_t]) join_clip(); }
module assembly_integrated() {
  mount_left(); integrated_root();
  neck_placed() neck_piece(1); neck_placed() neck_piece(2);
  join_clips_placed();
}
module assembly_metal() {
  mount_left(); metal_base_right(); join_clips_placed();
  // Deliberate 0.4mm exploded viewing gap avoids overlapping/coplanar STL surfaces.
  socket_placed() translate([0,0,socket_h()+0.4]) socket_cap();
  // Metal stock is intentionally EXCLUDED (not an STL printable component).
}
// VISUALIZATION ONLY. Approximate external metal shaft is not a printable component.
// 1 mm gap at socket mouth prevents mesh overlap / coplanar faces.
module assembly_metal_visual() {
  assembly_metal();
  socket_placed() cubexy(socket_len+1,neck_len+head_len,
    -metal_bar_w/2,metal_bar_w/2,metal_bar_t,socket_floor);
}
module preview_case() { color([0.8,0.8,0.8,0.28]) cubexy(0,keyboard_x,0,keyboard_y,keyboard_z,-keyboard_z); }
module preview_screws() {
  // Amber heads are photographic estimates for auditing, not machined holes.
  color([0.86,0.60,0.13]) for(p=all_large())
    translate([p[0],p[1],plate_t+0.8]) cylinder(d=large_hole_d,h=0.9);
  color([0.12,0.35,0.85]) for(p=concat(mount_top,mount_bottom))
    translate([p[0],p[1],-0.4]) cylinder(d=mount_hole_d-0.5,h=0.4);
}
module bridges_placed() { for(y=[10,117,162,212]) translate([0,y,plate_t]) join_clip(); }
module preview_integrated() {
  preview_case();
  color([0.85,0.25,0.2]) {
    mount_left(); integrated_root();
    neck_placed() neck_piece(1);
    neck_placed() neck_piece(2);
    bridges_placed();
  }
  preview_screws();
}
module preview_metal() {
  preview_case();
  color([0.83,0.25,0.18]) { mount_left(); metal_base_right(); bridges_placed(); }
  color([0.95,0.7,0.2]) socket_placed()
    translate([0,0,socket_h()]) socket_cap();
  color([0.5,0.58,0.64,0.65]) socket_placed()
    cubexy(8,255,-metal_bar_w/2,metal_bar_w/2,metal_bar_t,socket_floor);
  preview_screws();
}
if(mode=="mount_left") mount_left();
else if(mode=="mount_right") mount_right();
else if(mode=="integrated_root") integrated_root();
else if(mode=="integrated_mid") neck_piece(1);
else if(mode=="integrated_tip") neck_piece(2);
else if(mode=="integrated_full_right") integrated_full_right();
else if(mode=="metal_base_right") metal_base_right();
else if(mode=="metal_socket_cap") socket_cap();
else if(mode=="join_clip") join_clip();
else if(mode=="fit_coupon") fit_coupon();
else if(mode=="assembly_integrated") assembly_integrated();
else if(mode=="assembly_metal") assembly_metal();
else if(mode=="assembly_metal_visual") assembly_metal_visual();
else if(mode=="preview_integrated") preview_integrated();
else if(mode=="preview_metal") preview_metal();
else echo("Unknown mode",mode);
