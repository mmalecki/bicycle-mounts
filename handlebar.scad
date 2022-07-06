use <catchnhole/catchnhole.scad>;

module handlebar_mount (
  width,
  bolt = "M5",
  bolt_kind = "socket_head",
  bolt_countersink = 0.5,
  bolt_mount_length = 14, // Reasonable default for an M5 bolt.
  diameter = 26,          // Really hand-wavy default. We aim to be oversized for most handlebars.
  angle = 320,            // Reasonable default.
  thickness = 5.4         // Manufacturing-driven default. Get some layers in there, son.
) {
  rotate_facing = (360 - angle) / 2;

  difference () {
    union () {
      rotate_extrude (angle = angle) {
        translate([diameter / 2, 0]) square([thickness, width]);
      }

      translate([diameter / 2, 0]) {
        rotate([90, 0, -rotate_facing]) {
          translate([0, 0, -thickness])
            cube([bolt_mount_length, width, thickness]);
        }
      }

      rotate([0, 0, angle]) {
        translate([diameter / 2, 0]) {
          rotate([90, 0, rotate_facing]) {
            cube([bolt_mount_length, width, thickness]);
          }
        }
      }
    }

    translate([diameter / 2, 0]) {
      rotate([90, 0, -rotate_facing]) {
        translate([0, 0, -thickness]) {
          translate([bolt_mount_length / 2 + thickness / 4, width / 2, 0]){
            bolt(bolt,
              kind = bolt_kind,
              countersink = bolt_countersink,
              length = sin((360 - angle) / 2) * diameter + 2 * thickness
            );
            nutcatch_parallel(bolt);
          }
        }
      }
    }
  }
}
