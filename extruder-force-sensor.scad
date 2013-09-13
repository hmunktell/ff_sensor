// File: extruder-force-sensor.scad
// Author: Mark Heywood alias Airtripper
// Airtripper Extruder Filament Force Sensor Bracket
// by Airtripper May 2013
// Copyright © 2013 Airtripper
// http://www.airtripper.com
// Licensed Attribution-NonCommercial-ShareAlike 3.0 Unported. 
// Last edit: 12/09/2013


//++++++++++++++ Select Part To View ++++++++++++++++++

//-- Select Part To View --//

view_part = 1;	// [0:nothing, 1:assembled, 2:load_cell, 3:bowden_bracket, 4:load_cell_bracket, 5:bottom_stepper_bracket, 6:top_stepper_bracket, 7:full_load_cell_bracket, 8:extruder, 9:idler, 10:strut, 11:axle, 12:tube_bracket]

//-- END Select Part To View --//


//----------------------------------------------------------
//--------------- START CONFIGURATION ----------------------
//----------------------------------------------------------

fd = 2.30;		// Filament size for bracket

//------ START Load Cell Configuration-------//

lcl = 80;		// (80) Load cell length
lch = 12.7;		// (12.7) Load cell height
lcw = 12.7;		// (12.7) Load cell width
lclhs = 4;		// (4) Left side screw holes size - screws 1 & 2 (load cell bracket side)
lcrhs = 4;		// (4) Right side screw holes size (load cell stepper bracket side)
lchle = 5;		// (5) Measure from left edge to center of first screw hole (load cell bracket side)
lchln = 15;		// (15) Measure from first screw hole center to second screw hole center (load cell bracket side)
lchcd = 40;		// (40) Measure distance between the second & third hole centers
lchrc = 15; 	// (15) Measure distance between the center of the third and fourth screw hole (load cell stepper bracket side)

//----- END Load Cell Configuration -----//




//---- START Load Cell Bracket Configuration ----//

// Configuration for part 4:load_cell_bracket
lcbhs = 4.5;	// (4.5) Bracket screw hole size for load cell attachment
lcbfh = 8;		// (8) Bracket screw hole size for attachment to printer
lcbss = 46;		// (46) Bracket fixing screw holes distance apart, hole center to hole center
lcbbss = 4.5;	// (4.5) Bowden bracket attachment screw size
lcbbssh = 8.4;	// (8.4) Bowden bracket attachment screw Hex head size

//-- END Load Cell Bracket Configuration--//




//---- START Stepper Motor Bottom Bracket Configuration----//

// Configuration for part 5:bottom_stepper_bracket
smw = 44;	// NEMA 17 stepper motor case width

// Stepper motor bottom bracket load cell attachment acrew size
sbsd = 3.5;		// (M3 = 3.5)(M4 = 4.5) Screw size
sbsdh = 7.5;	// (M3 = 7.5)(M4 = 8.8) Screw Hex head size

//-- END Stepper Motor Botton Bracket Configuration --//




//---- START Stepper Motor Top Bracket Configuration----//

// Configuration for part 6:top_stepper_bracket
// Stepper motor Top bracket load cell attachment acrew size
stbsd = 3.5;		// (M3 = 3.5)(M4 = 4.5) Screw size
stbsdh = 7.5;	// (M3 = 7.5)(M4 = 8.8) Screw Hex head size

//-- END Stepper Motor Top Bracket Configuration --//


//----------------------------------------------------------
//---------------- END CONFIGURATION -----------------------
//----------------------------------------------------------

//++++++++++++++++++++ Model View, Positioning and Rotation ++++++++++++++++++++

if (view_part == 1) {	// Assembled view
	translate([45.5+lchle,-3+(lcw-12.7),44]) rotate([90,0,-90]) extruder();
	translate([lchle+lchln+lchcd-7.5,-(smbw/2)-9.25+(lcw/2),lch]) rotate([0,0,0]) bottom_stepper_bracket();
	translate([25+lchle+lchln+lchcd-7.5,-(smbw/2)-9.25+(lcw/2),18+lch]) rotate([0,-90,0]) top_stepper_bracket();
	translate([0,0,0]) rotate([0,0,0]) load_cell();
	translate([21+lchle,26+(lcw/2),-42]) rotate([0,-90,90]) load_cell_bracket();
	translate([21+lchle,-2.7+(lcw-12.7),-22]) rotate([0,-90,90]) bowden_bracket();
}
if (view_part == 2) {
	translate([0,0,0]) rotate([0,0,0]) load_cell();
}

if (view_part == 3) {
	translate([-55,-5,32]) rotate([-90,0,0]) bowden_bracket();
}

if (view_part == 4) {
	translate([(-20-lcbss)/2,-17.5,32]) rotate([-90,0,0]) load_cell_bracket();
}

if (view_part == 5) {
	translate([30,-12.5,0]) rotate([0,0,90]) bottom_stepper_bracket();
}

if (view_part == 6) {
	translate([30,-20,0]) rotate([0,0,90]) top_stepper_bracket();
}
if (view_part == 7) {
	translate([-66,-23,32]) rotate([-90,0,0]) load_cell_bracket();
	translate([-46,12,32]) rotate([-90,0,0]) bowden_bracket();
	translate([-46,8,0]) color("red") cube([4,3,32]);	// fill bracket hook joint
	//%translate([-67,-20,0]) cube([134,40,50]);	// Centering guide box
}
if (view_part == 8) {
	translate([0,0,0]) rotate([0,0,-90]) extruder();
}
if (view_part == 9) {
	translate([0,0,0]) rotate([0,0,0]) idler();
}
if (view_part == 10) {
	translate([0,0,0]) rotate([0,0,0]) strut();
}
if (view_part == 11) {
	translate([0,0,0]) rotate([0,0,0]) axle();
}
if (view_part == 12) {
	translate([15,-15,0]) rotate([0,0,90]) tube_bracket();
}

//+++++++++++++ END - Model View, Positioning and Rotation +++++++++++++++++

//######################### Bowden Bracket ##########################

//bowden_bracket();

module bowden_bracket() {
	difference() {
		union() {
			difference() {
				union() {
					// Main bracket body and logo
					translate([0,0,0]) color("red") cube([95,32,9]);
					translate([52,18,8]) rotate([0,0,180]) scale([0.6,0.6,1]) airtripper();
					translate([52,18.25,7.5]) rotate([0,0,180]) scale([0.6,0.6,1]) airtripper();
					// bracket attachment hook
					translate([0,0,-2.5]) color("red") cube([3,32,3]);
				}
				// Make the rounded curve on the right edge of the bracket
				translate([67,-90,-1]) rotate([0,0,0]) color("red") cylinder(15, r=100, $fn=500);
			}
			// Add push fit module and supports
			translate([97,6,-2]) rotate([90,0,0]) bsp_push_fit();
			translate([97,-6,-2]) rotate([0,0,10]) color("red") cube([5,37,14]);
			translate([100.2,5,-2]) rotate([0,0,22]) color("red") cube([5,25,14]);
			difference() {
				union() {
					// Support flange
					translate([71,29,-2]) rotate([0,0,0]) color("red") cube([25,3,14]);
				}
				translate([60,28,-8]) rotate([0,25,0]) color("red") cube([21,5,14]);
				translate([65,28,4]) rotate([0,-25,0]) color("red") cube([21,5,14]);
				
			}
		}
		// Bowden bracket screw holes
		translate([10,6,-1]) rotate([0,0,0])color("red") cylinder(50, r=lcbbss/2, $fn=100);
		translate([10,26,-1]) rotate([0,0,0])color("red") cylinder(50, r=lcbbss/2, $fn=100);
	}
}



//###################### Load Cell Bracket ################################

//load_cell_bracket();

module load_cell_bracket() {
	difference() {
		union() {
			// Bracket main body
			translate([0,0,0]) color("red") cube([20+lcbss,32,10]);	// Back plate
			translate([20,0,0]) color("red") cube([20,32,35]);	// Load cell attachment block
			translate([40,0,0]) color("red") cube([5,32,25.5-(lcw/2)]);	// Load cell edge guide
			difference() {
				translate([40,21-lchln-lclhs,0]) color("red") cube([2,50,35]);	// Load cell spacer
				translate([39,-32,-1]) color("red") cube([4,32,37]);	// Load cell spacer -y edge chop
				translate([39,32,-1]) color("red") cube([4,60,37]);	// Load cell spacer +y edge chop
			}
			translate([21,0,0]) rotate([0,-45,0]) color("red") cube([10,32,10]);	// Bottom inner corner bevel
			translate([44,0,0]) rotate([0,-45,0]) color("red") cube([10,32,10]);	// Top inner corner bevel
		}
			// Bracket screw holes for printer attachment
			translate([10,16,-1]) color("red") cylinder(12, r=lcbfh/2, $fn=100);	// Bottom hole
			translate([10+lcbss,16,-1]) color("red") cylinder(12, r=lcbfh/2, $fn=100);	// Top hole
			// Screw hole for load cell attachment
			translate([10,21,26]) rotate([0,90,0])color("red") cylinder(50, r=lcbhs/2, $fn=100);
			// Screw holes for attaching bowden feed bracket
			translate([30,6,-1]) rotate([0,0,0])color("red") cylinder(50, r=lcbbss/2, $fn=100);
			translate([30,26,-1]) rotate([0,0,0])color("red") cylinder(50, r=lcbbss/2, $fn=100);
			translate([30,6,-1]) rotate([0,0,0])color("red") cylinder(10, r=lcbbssh/2, $fn=6);	// Hex screw head
			translate([30,26,-1]) rotate([0,0,0])color("red") cylinder(10, r=lcbbssh/2, $fn=6);	// Hex screw head
			// Anchor point for bowden bracket
			translate([19,-1,32]) color("red") cube([4,34,4]);
	}
}



//######################## Stepper Motor Bracket ##################################

//Top Stepper Motor Bracket

smbwa = 2.5;	// default 2.5 - For adjusting stepper motor clamp side thickness
smbw = 17+smw+(smbwa*2);	// default 17

//top_stepper_bracket();

module top_stepper_bracket() {
	difference() {
		// Main bracket body
		translate([0,0,0]) color("yellow") cube([40,smbw,25]);
		translate([-2.5,8.5+smbwa,-1]) color("yellow") cube([36,smw,27]);
		translate([8,-1,-1]) color("yellow") cube([36,6+(smbwa/2),27]);
		translate([8,smbw-5-(smbwa/2),-1]) color("yellow") cube([36,6+(smbwa/2),27]);
		// Bracket screw holes to clamp stepper motor
		translate([-1,4.25+(smbwa/2),5]) rotate([0,90,0]) color("yellow") cylinder(10, r=stbsd/2, $fn=50);
		translate([-1,4.25+(smbwa/2),20]) rotate([0,90,0]) color("yellow") cylinder(10, r=stbsd/2, $fn=50);
		translate([-1,smbw-4.25-(smbwa/2),5]) rotate([0,90,0]) color("yellow") cylinder(10, r=stbsd/2, $fn=50);
		translate([-1,smbw-4.25-(smbwa/2),20]) rotate([0,90,0]) color("yellow") cylinder(10, r=stbsd/2, $fn=50);
		// Hex nut capture sockets
		translate([6,4.25+(smbwa/2),5]) rotate([0,90,0]) color("yellow") cylinder(10, r=stbsdh/2, $fn=6);
		translate([6,4.25+(smbwa/2),20]) rotate([0,90,0]) color("yellow") cylinder(10, r=stbsdh/2, $fn=6);
		translate([6,smbw-4.25-(smbwa/2),5]) rotate([0,90,0]) color("yellow") cylinder(10, r=stbsdh/2, $fn=6);
		translate([6,smbw-4.25-(smbwa/2),20]) rotate([0,90,0]) color("yellow") cylinder(10, r=stbsdh/2, $fn=6);
		// Holes in the side and top of bracket
		translate([33,20+smbwa,12.5]) rotate([0,90,0]) color("yellow") cylinder(10, r=5, $fn=100);	// Top
		translate([33,40+smbwa,12.5]) rotate([0,90,0]) color("yellow") cylinder(10, r=5, $fn=100);	// Top
		translate([29,-1,12.5]) rotate([-90,0,0]) color("yellow") cylinder(62+smbwa, r=3, $fn=100);	// Side
		//translate([18,-1,12.5]) rotate([-90,0,0]) color("yellow") cylinder(62, r=3, $fn=100);	// Side
		
	}
}

//Bottom Stepper Motor Bracket

//bottom_stepper_bracket();

module bottom_stepper_bracket() {

	difference() {
		union() {
			translate([0,0,0]) color("yellow") cube([25,smbw,15]);
			translate([10,(smbw/2)+9.25-6,0]) color("yellow") cube([lchrc+lchle,12,10]);
		}
		translate([-1,8.5+smbwa,10]) color("yellow") cube([27,smw,10]);
		// Stepper bracket clamp screw holes
		translate([5,4.25+(smbwa/2),-1]) color("yellow") cylinder(20, r=stbsd/2, $fn=50);
		translate([20,4.25+(smbwa/2),-1]) color("yellow") cylinder(20, r=stbsd/2, $fn=50);
		translate([5,smbw-4.25-(smbwa/2),-1]) color("yellow") cylinder(20, r=stbsd/2, $fn=50);
		translate([20,smbw-4.25-(smbwa/2),-1]) color("yellow") cylinder(20, r=stbsd/2, $fn=50);
		// Bracket and load cell attachment screw holes
		translate([7.5,(smbw/2)+9.25,-15]) color("black") cylinder(30, r=sbsd/2, $fn=50);
		translate([7.5+lchrc,(smbw/2)+9.25,-15]) color("black") cylinder(30, r=sbsd/2, $fn=50);
		translate([7.5,(smbw/2)+9.25,5]) color("yellow") cylinder(6, r=sbsdh/2, $fn=6);
		translate([7.5+lchrc,(smbw/2)+9.25,5]) color("yellow") cylinder(6, r=sbsdh/2, $fn=6);
		
	}
	//translate([12.5,30,-15]) color("black") cylinder(15, r=1.75, $fn=50);
}



//##################################################################
//################## EXTRA MODULE SECTION ##########################
//##################################################################


//####### BSP Push Fit Fitting Bracket for Bowden Bracket ##########

//bsp_push_fit();


module bsp_push_fit() {
	bsp = 10;
	x_nuj = 0;
	
	difference() {
		union() {
			//translate([0,3,0]) cube([3,11,26]);
			difference() {
				translate([3+x_nuj-3,7,15]) rotate([0,90,0]) cylinder(12+3, r=(bsp/2)+5.5, $fn=100);
				translate([11+x_nuj-3,7,19.5]) rotate([0,90,0]) cylinder(15+3, r=1.5, $fn=50);
			}
			difference() {
				translate([3+x_nuj,0,-5]) cube([12,14,18]);
				translate([2+x_nuj,-1,-7]) rotate([0,50,0]) cube([10,16,26]);
			}
		}
		translate([8+x_nuj,7,15]) rotate([0,90,0]) cylinder(8, r=(bsp/2), $fn=100);
		translate([-1,7,15]) rotate([0,90,0]) cylinder(19, r1=fd/2, $fn=30);
		translate([-1,7,15]) rotate([0,90,0]) cylinder(4, r1=fd+0.2, r2=fd/2, $fn=30);
		translate([11.2+x_nuj,7,-1]) rotate([0,0,0]) cylinder(15, r=1.75, $fn=50);	// M3 Screw hole
		translate([11.2+x_nuj,7,7]) rotate([0,0,30]) cylinder(5, r=3.5, $fn=6);	// M3 Screw hex nut hole
		translate([11.2+x_nuj,5.3,-1]) cube([6,3.4,15]);
		translate([11.2+x_nuj,7,-4]) rotate([0,0,0]) cylinder(5, r=3.5, $fn=50);
		translate([11.2+x_nuj,7,0.99]) rotate([0,0,0]) cylinder(3, r1=3.5, r2=1.75, $fn=50);
	}
}


// ################### Airtripper Bowden Extruder Body ##############################

// Revision 3b

module extruder() {
	difference() {
		union() {
			// Extruder base
			translate([0,0,1.5]) cube([42,42,3], center = true);

			// Bearing supports between screw columns and shaft bearing
			rotate([0,0,45]) translate([0,11,13]) cube([3,22,26], center = true);
			rotate([0,0,315]) translate([0,-11,13]) cube([3,22,26], center = true);
			difference() {
				translate([-3,0,22]) cylinder(8,r1=4, r2=4, $fn=50, center = true);
				rotate([0,90,0]) translate([-17,0,-10]) cylinder(8,r=4, $fn=50);
			}
			difference() {
				translate([0,0,3]) cylinder(22,r1=13.5, r2=6.3, $fn=100);	// rev. 3
				rotate([0,0,45]) translate([8,0,13]) cube([15,30,26.5], center = true);	// rev. 3
				rotate([0,0,315]) translate([8,0,13]) cube([15,30,26.5], center = true);	// rev. 3
			}
			// M3 Screw columns for stepper attachment
			translate([-15.5,15.5,0]) cylinder(26,r=4, $fn=50);	// rev. 3
			translate([-15.5,15.5,18]) cylinder(8,r1=4,r2=6, $fn=50);	// rev. 3
			translate([-15.5,-15.5,0]) cylinder(23.5,r=4, $fn=50);	// rev. 3
			translate([-15.5,-15.5,17.5]) cylinder(6,r1=4,r2=5, $fn=50);	// rev. 3
			translate([15.5,-15.5,3]) cylinder(1.5,r=3.5, $fn=50);	// rev. 3

		}
		union() {
			// Stepper shaft, gear insert and bearing cut-out
			translate([0,0,9.8]) cylinder(20,r1=13, r2=5, $fn=50, center = true);	// rev. 3
			translate([0,0,22]) cylinder(5,r=5, $fn=50, center = true);
			translate([0,0,27]) cylinder(8	,r=4, $fn=50, center = true);
			translate([0,0,25.5]) cylinder(2,r1=5, r2=4, $fn=50, center = true);
			translate([0,0,10.5]) cylinder(8	,r=7, $fn=100);	// rev. 2
			translate([0,0,18.5]) cylinder(3.5,r1=7, r2=3.5, $fn=50);	// rev. 2

			// Reduce wall and screw shaft for strut placement
			translate([-15.5,-15.5,23.5]) cylinder(5,r=3, $fn=30);
			translate([-12.5,-15.5,25.5]) cube([12,9,4], center = true);
			translate([-11.4,-11.4,27.9]) rotate([25,0,315]) cube([5,10,5], center = true);

			// M3 screw holes
			for(r=[1:4]) {
				rotate([0,0,r*360/4]) translate([15.5,15.5,-1]) cylinder(40,r=1.75, $fs=.1);
			}
			translate([-15.5,15.5,22.1]) cylinder(4,r=3.3, $fn=30);	// rev. 3
			translate([15.5,15.5,1.5]) cylinder(4,r=3.25, $fs=.1);	// rev. 3
		}
	}
	// Filament in-feed bracket
	difference() {
		union() {
			translate([8.75,-20,3]) rotate([0,0,90]) infeed_block();	// rev. 3
			translate([-12,-17,3]) rotate([0,0,-12]) cube([14,2,16]);	// rev. 3
		}

	}
	// Bowdon out-feed tube holder
	difference() {
		union() {
			translate([4.8,14,13]) cube([8,14,26], center = true);
			translate([-5.5,12.5,13]) cube([13.5,3,26], center = true);	// rev. 3
			translate([3.3,21.1+1.5,13]) cube([11,6,26], center = true);	// rev. 3
		}
		union() {
			// Tube and filament holes
			translate([4.8,24+15,15]) rotate([90,0,0]) cylinder(40, r=1.15, $fn=25);	// rev. 2, 3
			translate([5.3,16,15]) rotate([90,0,5]) cylinder(10, r1=0.4, r2=3, $fn=25);	// rev. 3

			// Insert and idler clearance
			translate([0,0,9.9]) cylinder(20,r1=13, r2=5, $fn=50, center = true);	// rev. 3

			// M3 bolt holes for idler preloader
			translate([3,17,20.5]) rotate([0,90,12]) cylinder(10, r=2.75, $fn=25);	// rev. 3
			translate([3,17,9.5]) rotate([0,90,12]) cylinder(10, r=2.75, $fn=25);	// rev. 3
			translate([-0.5,17,20.5]) rotate([0,90,0]) cylinder(10, r=2, $fn=25);
			translate([-0.5,17,9.5]) rotate([0,90,0]) cylinder(10, r=2, $fn=25);

			// just a hole
			translate([-3.5,15.5,9.5]) rotate([90,0,0]) cylinder(6, r=3.5, $fn=25);	// rev. 3
			translate([-3.5,15.5,20.5]) rotate([90,0,0]) cylinder(6, r=3.5, $fn=25);	// rev. 3

			// Bowden filament guide in-feed Cut off
			translate([11,7.5,14]) rotate([0,0,35]) cube([8,4,28], center = true);	// rev. 3
			translate([4.5,8.5,25]) cube([10,4,10], center = true);	// rev. 3
		}
	}
	
}


// ########### Filament infeed pipe design module for the Airtripper Bowden Extruder ###############

//infeed_block();

infeed_choice = 2;

module infeed_block() {

	if (infeed_choice == 1) {
		difference() {
			union() {
				 polyhedron(
				  points=[ [0,0,0],[0,8,0],[2,8,0],[2,0,0], // the six points at base
							[-5,0,8],[-5,8,8],[7,0,8],[7,8,8],
							[-5,0,16],[-5,8,16],[7,0,16],[7,8,16]
							],
							
				  triangles=[ [0,3,1],[2,1,3],
							[4,0,1],[1,5,4],[7,2,3],[7,3,6],
							[1,2,5],[2,7,5],[4,6,0],[6,3,0],
							[11,9,5],[5,7,11],[10,11,7],[7,6,10],
							[5,9,8],[8,4,5],[4,8,10],[10,6,4],[8,9,11],[11,10,8]
							]          // each triangle side
													 // two triangles for square base
				 );
			}
			translate([8,4,12]) rotate([0,-90,0]) cylinder(22, r=1.3, $fn=60);
			translate([-1,4,12]) rotate([0,-90,0]) cylinder(5, r1=1.3, r2=2.2, $fn=60);
			
		}
	}


	if (infeed_choice == 2) {
		difference() {
			union() {
				 polyhedron(
				  points=[ [-3,0,-3],[-3,8,-3],[2,8,-3],[2,0,-3], // the six points at base
							[-12,0,6],[-12,8,6],[7,0,8],[7,8,8],
							[-5,0,16],[-5,8,16],[7,0,16],[7,8,16]
							],
							
				  triangles=[ [0,3,1],[2,1,3],
							[4,0,1],[1,5,4],[7,2,3],[7,3,6],
							[1,2,5],[2,7,5],[4,6,0],[6,3,0],
							[11,9,5],[5,7,11],[10,11,7],[7,6,10],
							[5,9,8],[8,4,5],[4,8,10],[10,6,4],[8,9,11],[11,10,8]
							]          // each triangle side
													 // two triangles for square base
				 );
				translate([-2,4,12]) rotate([0,-90,0]) cylinder(10, r=5.9, $fn=100);
				translate([1,4,12]) rotate([0,-90,0]) cylinder(3, r1=4, r2=5.9, $fn=100);
			}
			translate([8,4,12]) rotate([0,-90,0]) cylinder(22, r=1.3, $fn=25);
			translate([-2.9,4,12]) rotate([0,-90,0]) cylinder(12, r=2.15, $fn=60);
			translate([0,4,12]) rotate([0,-90,0]) cylinder(3, r1=1.3, r2=2.15, $fn=60);
		}
	}

}


// #################### Extruder Idler######################################

//idler();

module idler() {
	difference() {
		union() {
			difference() {
				translate([0,0,7]) cube([22,42,14], center = true);
				// Bearing housing
				//#translate([-6,0,8]) cube([10,50,20], center = true);
				translate([0,0,1]) cube([10,24,10], center = true);
				translate([-5,0,6]) rotate([0,90,0]) cylinder(10,r=12, $fn=60);
			}
			// Axle spacer
			translate([-8,0,6]) rotate([0,90,0]) cylinder(16,r=6, $fn=40);
			translate([0,0,3]) cube([16,12,6], center = true);
		}
		union() {
			// Bearing axle cut-out
			translate([-7.75,0,6]) rotate([0,90,0]) cylinder(15.5,r=4.25, $fn=40);
			translate([0,0,2]) cube([14.2,8.5,8], center = true);
			translate([-4.5,0,0]) rotate([0,20,0]) cube([6,8.5,8], center = true);
			translate([4.5,0,0]) rotate([0,-20,0]) cube([6,8.5,8], center = true);
			translate([-3.7,0,6]) rotate([0,90,0]) cylinder(7.4,r=12, $fn=60);
			// hook
			translate([-12,-15.5,6]) rotate([0,90,0]) cylinder(24,r=2, $fn=25);
			translate([0,-18.5,11]) cube([24,10,10], center = true);
			translate([9.5,-17,1]) cube([4,16,16], center = true);
			translate([-9.5,-17,1]) cube([4,16,16], center = true);
			translate([0,-21,0]) rotate([45,0,0]) cube([24,6,10], center = true);
			translate([-11,-12,9.6]) rotate([0,135,0]) cube([4,6,6], center = true);
			translate([11,-12,9.6]) rotate([0,45,0]) cube([4,6,6], center = true);
			// Bolt slots
			translate([6,20,7]) cube([3.5,10,16], center = true);
			translate([-6,20,7]) cube([3.5,10,16], center = true);
			translate([0,24,7]) rotate([154,0,0]) cube([24,10,26], center = true);
			translate([0,26.5,25]) rotate([145,0,0]) cube([24,10,26], center = true);
			translate([0,25.5,7]) cube([22,10,16], center = true);
			//Padding
			//translate([-9,-17,7]) cube([6,10,16], center = true);
		}
	}

}

// ###################### Extruder Strut ###################################

//strut();

module strut() {

	difference() {
		union() {
			translate([-15.5,0,0]) color("red") cylinder(6, r=5, $fn=30);
			translate([15.5,0,0]) color("red") cylinder(6, r=5, $fn=30);
			translate([-15.5,-3.5,0]) color("red") cube([31,7,6]);
		}
		union() {
			// Screw holes
			translate([-15.5,0,-1]) color("red") cylinder(5, r=1.75, $fn=30);
			translate([15.5,0,-1]) color("red") cylinder(5, r=1.75, $fn=30);
			translate([-15.5,0,3]) color("red") cylinder(5, r=3, $fn=30);
			translate([15.5,0,3]) color("red") cylinder(5, r=3, $fn=30);
		}
	}
}

// ################### Extruder Idler Axle ##################################

// axle();

module axle() {
	cylinder(14.25,r=3.80, $fn=40);
	// Support flange while printing
//	translate([-5,-0.5,0]) cube([10,1,0.5]);
//	translate([-0.5,-5,0]) cube([1,10,0.5]);
//	difference() {
//		cylinder(0.5,r=10, $fn=40);
//		translate([0,0,-1]) cylinder(3,r=5, $fn=40);
//	}
}

// ######################## 4mm Tube Bracket #################################

//tube_bracket();


module tube_bracket() {
		difference() {
			union() {
				translate([0,10,0]) cube([30,10,10]);	// Pipe bracket
				difference() {
					translate([5,0,0]) cube([10,30,3]);	// Screw bracket
					difference() {
						translate([10,15,-1]) rotate([0,0,0]) cylinder(5, r=20, $fn=100);
						translate([10,15,-1]) rotate([0,0,0]) cylinder(5, r=15, $fn=100);
					}
				}
			}
			translate([-1,15,5]) rotate([0,90,0]) cylinder(32, r=1.15, $fn=60);	// filament tube hole
			translate([-0.95,15,5]) rotate([0,90,0]) cylinder(11, r=2.14, $fn=60);	// Pipe hole infeed
			translate([20,15,5]) rotate([0,90,0]) cylinder(11, r=2.11, $fn=60);	// Pipe hole outfeed
			translate([10,15,5]) rotate([0,90,0]) cylinder(5, r1=2.2, r2=1.3, $fn=60);	// Infeed hole taper
			translate([10,25,-1]) rotate([0,0,0]) cylinder(5, r=2.2, $fn=60);	// Screw holes
			translate([10,5,-1]) rotate([0,0,0]) cylinder(5, r=2.2, $fn=60);	// Screw holes
			translate([-7,4.4,9]) rotate([0,0,45]) cube([15,15,5]);	// Pipe bracket direction mark
			difference() {
				translate([10,4.4,9]) rotate([0,0,0]) cube([25,25,7]);	// Pipe bracket direction mark
				translate([19.4,4.4,9]) rotate([0,0,45]) cube([15,15,5]);	// Pipe bracket direction mark
				translate([0,4.4,9]) rotate([0,0,0]) cube([25,25,7]);	// Pipe bracket direction mark
			}
		}
}


// ################### Airtripper Logo #############################


// Module names are of the form poly_<inkscape-path-id>().  As a result,
// you can associate a polygon in this OpenSCAD program with the corresponding
// SVG element in the Inkscape document by looking for the XML element with
// the attribute id="inkscape-path-id".

// fudge value is used to ensure that subtracted solids are a tad taller
// in the z dimension than the polygon being subtracted from.  This helps
// keep the resulting .stl file manifold.
fudge = 0.1;

module poly_path3058(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-161.015630,25.769530],[-161.015630,-25.769530],[-150.609380,-25.769530],[-150.609380,25.769530]]);
  }
}

module poly_path3066(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[7.031250,25.769530],[7.031250,-25.769530],[17.437500,-25.769530],[17.437500,25.769530]]);
  }
}

module poly_path3074(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[171.632810,25.769530],[171.632810,-25.769530],[193.535150,-25.769530],[200.667449,-25.422325],[205.541010,-24.380860],[207.319672,-23.551365],[208.911584,-22.451626],[210.316743,-21.081641],[211.535150,-19.441410],[212.519501,-17.602275],[213.222616,-15.635715],[213.785150,-11.320320],[213.571988,-8.546250],[212.932577,-6.024881],[211.866915,-3.756212],[210.375000,-1.740240],[208.458960,-0.025258],[206.121060,1.340348],[203.361300,2.356577],[200.179680,3.023430],[203.260224,5.088880],[205.751950,7.347650],[208.331507,10.617194],[211.675780,15.714840],[217.968750,25.769530],[205.523430,25.769530],[198.000000,14.554680],[192.515620,6.978510],[190.995092,5.660166],[189.386710,4.833980],[187.250956,4.398935],[184.148430,4.253900],[182.039060,4.253900],[182.039060,25.769530]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[182.039060,-3.972660],[189.738280,-3.972660],[195.820287,-4.130841],[199.089840,-4.605470],[200.750946,-5.466779],[202.007810,-6.785160],[202.798799,-8.525371],[203.062500,-10.652350],[202.715301,-13.003390],[201.673820,-14.853520],[199.999483,-16.158661],[197.753900,-16.875000],[190.160150,-17.050780],[182.039060,-17.050780]]);
    }
  }
}

module poly_path3056(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-166.253910,25.769530],[-177.574220,25.769530],[-182.074220,14.062500],[-202.675790,14.062500],[-206.929690,25.769530],[-217.968750,25.769530],[-197.894540,-25.769530],[-186.890630,-25.769530]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-185.414070,5.378900],[-192.515630,-13.746100],[-199.476570,5.378900]]);
    }
  }
}

module poly_path3060(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-140.695320,25.769530],[-140.695320,-25.769530],[-118.792970,-25.769530],[-111.660671,-25.422325],[-106.787110,-24.380860],[-105.008449,-23.551365],[-103.416540,-22.451626],[-102.011381,-21.081641],[-100.792970,-19.441410],[-99.808623,-17.602275],[-99.105507,-15.635715],[-98.542970,-11.320320],[-98.756133,-8.546250],[-99.395547,-6.024881],[-100.461213,-3.756212],[-101.953130,-1.740240],[-103.869168,-0.025258],[-106.207065,1.340348],[-108.966822,2.356577],[-112.148440,3.023430],[-109.067905,5.088880],[-106.576180,7.347650],[-103.996619,10.617194],[-100.652350,15.714840],[-94.359380,25.769530],[-106.804690,25.769530],[-114.328130,14.554680],[-119.812500,6.978510],[-121.333027,5.660166],[-122.941410,4.833980],[-125.077171,4.398935],[-128.179690,4.253900],[-130.289070,4.253900],[-130.289070,25.769530]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-130.289070,-3.972660],[-122.589850,-3.972660],[-116.507839,-4.130841],[-113.238290,-4.605470],[-111.577180,-5.466779],[-110.320320,-6.785160],[-109.529331,-8.525371],[-109.265630,-10.652350],[-109.612827,-13.003390],[-110.654300,-14.853520],[-112.328645,-16.158661],[-114.574220,-16.875000],[-122.167970,-17.050780],[-130.289070,-17.050780]]);
    }
  }
}

module poly_path3062(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[-77.097660,25.769530],[-77.097660,-17.050780],[-92.390630,-17.050780],[-92.390630,-25.769530],[-51.433600,-25.769530],[-51.433600,-17.050780],[-66.691410,-17.050780],[-66.691410,25.769530]]);
  }
}

module poly_path3064(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-44.648440,25.769530],[-44.648440,-25.769530],[-22.746100,-25.769530],[-15.613801,-25.422325],[-10.740240,-24.380860],[-8.961578,-23.551365],[-7.369666,-22.451626],[-5.964507,-21.081641],[-4.746100,-19.441410],[-3.761749,-17.602275],[-3.058634,-15.635715],[-2.496100,-11.320320],[-2.709262,-8.546250],[-3.348672,-6.024881],[-4.414335,-3.756212],[-5.906250,-1.740240],[-7.822290,-0.025258],[-10.160190,1.340348],[-12.919950,2.356577],[-16.101570,3.023430],[-13.021026,5.088880],[-10.529300,7.347650],[-7.949742,10.617194],[-4.605470,15.714840],[1.687500,25.769530],[-10.757820,25.769530],[-18.281250,14.554680],[-23.765630,6.978510],[-25.286157,5.660166],[-26.894540,4.833980],[-29.030294,4.398935],[-32.132820,4.253900],[-34.242190,4.253900],[-34.242190,25.769530]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-34.242190,-3.972660],[-26.542970,-3.972660],[-20.460962,-4.130841],[-17.191410,-4.605470],[-15.530304,-5.466779],[-14.273440,-6.785160],[-13.482451,-8.525371],[-13.218750,-10.652350],[-13.565949,-13.003390],[-14.607430,-14.853520],[-16.281767,-16.158661],[-18.527350,-16.875000],[-26.121100,-17.050780],[-34.242190,-17.050780]]);
    }
  }
}

module poly_path3068(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[27.316400,25.769530],[27.316400,-25.769530],[44.015620,-25.769530],[51.855441,-25.576135],[56.390620,-24.996100],[58.515355,-24.245704],[60.459928,-23.154751],[62.224338,-21.723240],[63.808590,-19.951170],[65.115937,-17.867044],[66.049768,-15.499485],[66.610079,-12.848494],[66.796870,-9.914070],[66.366175,-5.545880],[65.074210,-1.933600],[63.118614,0.953630],[60.697260,3.146480],[58.020965,4.680186],[55.300780,5.589840],[50.739233,6.143566],[44.507810,6.328120],[37.722650,6.328120],[37.722650,25.769530]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[37.722650,-17.050780],[37.722650,-2.425780],[43.417960,-2.425780],[48.550758,-2.627914],[51.644530,-3.234380],[53.494601,-4.271465],[54.896480,-5.765630],[55.779754,-7.628884],[56.074210,-9.773440],[55.661103,-12.339819],[54.421870,-14.414070],[52.549780,-15.899384],[50.238280,-16.699220],[42.750000,-17.050780]]);
    }
  }
}

module poly_path3070(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[75.410150,25.769530],[75.410150,-25.769530],[92.109370,-25.769530],[99.949191,-25.576135],[104.484370,-24.996100],[106.609105,-24.245704],[108.553678,-23.154751],[110.318088,-21.723240],[111.902340,-19.951170],[113.209687,-17.867044],[114.143518,-15.499485],[114.703829,-12.848494],[114.890620,-9.914070],[114.459925,-5.545880],[113.167960,-1.933600],[111.212364,0.953630],[108.791010,3.146480],[106.114715,4.680186],[103.394530,5.589840],[98.832983,6.143566],[92.601560,6.328120],[85.816400,6.328120],[85.816400,25.769530]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[85.816400,-17.050780],[85.816400,-2.425780],[91.511710,-2.425780],[96.644508,-2.627914],[99.738280,-3.234380],[101.588351,-4.271465],[102.990230,-5.765630],[103.873504,-7.628884],[104.167960,-9.773440],[103.754853,-12.339819],[102.515620,-14.414070],[100.643530,-15.899384],[98.332030,-16.699220],[90.843750,-17.050780]]);
    }
  }
}

module poly_path3072(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[123.503900,25.769530],[123.503900,-25.769530],[161.718750,-25.769530],[161.718750,-17.050780],[133.910150,-17.050780],[133.910150,-5.625000],[159.785150,-5.625000],[159.785150,3.058590],[133.910150,3.058590],[133.910150,17.085930],[162.703120,17.085930],[162.703120,25.769530]]);
  }
}

module airtripper() {
	poly_path3058(2);
	poly_path3066(2);
	poly_path3074(2);
	poly_path3056(2);
	poly_path3060(2);
	poly_path3062(2);
	poly_path3064(2);
	poly_path3068(2);
	poly_path3070(2);
	poly_path3072(2);
}


//##################################################################
//#################### HARDWARE SECTION ############################
//##################################################################


//##################### Load Cell Model ############################


//load_cell();

module load_cell() {
	difference() {
		// Load Cell Bar
		translate([0,0,0]) color("silver") cube([lcl,lcw,lch]);
		// Left side load cell holes
		translate([lchle,lcw/2,-1]) color("silver") cylinder(lch+2, r=lclhs/2, $fn=50);
		translate([lchle+lchln,lcw/2,-1]) color("silver") cylinder(lch+2, r=lclhs/2, $fn=50);
		// Right side load cell holes
		translate([lchle+lchln+lchcd,lcw/2,-1]) color("silver") cylinder(lch+2, r=lcrhs/2, $fn=50);
		translate([lchle+lchln+lchcd+lchrc,lcw/2,-1]) color("silver") cylinder(lch+2, r=lcrhs/2, $fn=50);
	}
}



