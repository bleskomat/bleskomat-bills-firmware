spaceBetweenPrintedParts=5;

plateWidth=84.8;
plateHeight=250;
plateThickness=4;

screwTypeOneDiameter=3;
screwTypeOneRadius=screwTypeOneDiameter / 2;
screwTypeTwoDiameter=2.5;
screwTypeTwoRadius=screwTypeTwoDiameter / 2;

// Mounts for parts (e.g screen and coin acceptor):
partMountWallThickness=2;
screenMountHeight=3.2;
coinAcceptorLeftMountHeight=6.1;
coinAcceptorRightMountHeight=6.4;

screwTopSpaceBetween=33;
screwTopLeftPosX=24.7 + screwTypeOneRadius;
screwTopLeftPosY=4.45 + screwTypeOneRadius;
screwTopRightPosX=screwTopLeftPosX + screwTypeOneRadius + screwTopSpaceBetween + screwTypeOneRadius;
screwTopRightPosY=screwTopLeftPosY;

screenMarginTop=10;
screenWidth=32;
screenHeight=38.35;
screenPosX=(plateWidth - screenWidth) / 2;
screenPosY=screwTopLeftPosY + screwTypeTwoDiameter + screenMarginTop;
screenScrewTopLeftPosX=(0.5 + screwTypeTwoRadius) * -1;
screenScrewTopLeftPosY=(5 + screwTypeTwoRadius) * -1;
screenScrewTopRightPosX=screenWidth + 0.5 + screwTypeTwoRadius;
screenScrewTopRightPosY=screenScrewTopLeftPosY;
screenMarginBottom=16;

coinAcceptorMarginTop=4;
coinInsertOutputGap=28.5;
coinOutputWidth=8.1;
coinOutputHeight=36.8;
coinOutputPosX=(plateWidth - coinOutputWidth) / 2;

coinInsertWidth=6.45;
coinInsertHeight=35.85;
coinInsertPosX=coinOutputPosX;
coinInsertPosY=screenPosY + screenHeight + screenMarginBottom + coinAcceptorMarginTop;
coinOutputPosY=coinInsertPosY + coinInsertHeight + coinInsertOutputGap;
coinOutputMarginBottom=22;

toothWidth=plateWidth / floor(plateWidth / 3.5);
toothHeight=16;
topPlateHeight=coinOutputHeight + coinOutputPosY + coinOutputMarginBottom;
topPlatePosX=0;
topPlatePosY=0;
topPlateTeethPosX=topPlatePosX;
topPlateTeethPosY=(topPlatePosY + topPlateHeight) - toothHeight;

bottomPlateHeight=plateHeight - topPlateHeight;
bottomPlatePosX=topPlatePosX + plateWidth + spaceBetweenPrintedParts;
bottomPlatePosY=topPlatePosY;
bottomPlateTeethPosX=0;
bottomPlateTeethPosY=0;

screwBottomSpaceBetween=36.2;
screwBottomLeftPosX=24.65 + screwTypeOneRadius;
screwBottomLeftPosY=bottomPlateHeight - (screwTypeOneDiameter + screwTypeOneRadius + 3.9);
screwBottomRightPosX=screwBottomLeftPosX + screwTypeOneDiameter + screwBottomSpaceBetween + screwTypeOneRadius;
screwBottomRightPosY=screwBottomLeftPosY;

coinAcceptorScrewTopPosX=(7.85 + screwTypeTwoRadius) * -1;
coinAcceptorScrewTopPosY=11.25 + screwTypeTwoRadius;
coinAcceptorScrewBottomPosX=(7.85 + screwTypeTwoRadius) * -1;
coinAcceptorScrewBottomPosY=coinOutputHeight - (5 + screwTypeTwoRadius);
coinAcceptorScrewRightPosX=(14 + screwTypeTwoRadius);
coinAcceptorScrewRightPosY=14 + screwTypeTwoRadius;

maxExpectedCoinDiameter=26.3;
maxExpectedCoinRadius=maxExpectedCoinDiameter / 2;
coinCatchWallThickness=2;
coinCatchWidth=coinOutputWidth + (coinCatchWallThickness * 2);
coinCatchHeight=maxExpectedCoinRadius + coinCatchWallThickness;
coinCatchDepth=maxExpectedCoinDiameter + coinCatchWallThickness;
coinCatchPosX=coinOutputPosX - coinCatchWallThickness;
coinCatchPosY=(coinOutputPosY + coinOutputHeight + coinCatchWallThickness) - coinCatchHeight;
coinCatchPosZ=plateThickness + (coinCatchWallThickness * -1);

// plate (top)
translate([topPlatePosX, topPlatePosY]) {
    union() {
        difference() {
            // plate
            cube([
                plateWidth,
                topPlateHeight,
                plateThickness
            ]);
            // screw (top-left)
            translate([
                // Invert x-coordinate:
                plateWidth - (screwTopLeftPosX + screwTypeOneDiameter),
                screwTopLeftPosY
            ]) {
                cylinder(
                    h=plateThickness,
                    r=screwTypeOneRadius
                );
            }
            // screw (top-right)
            translate([
                plateWidth - (screwTopRightPosX + screwTypeOneDiameter),
                screwTopRightPosY
            ]) {
                cylinder(
                    h=plateThickness,
                    r=screwTypeOneRadius
                );
            }
            // screen
            translate([screenPosX, screenPosY]) {
                cube([
                    screenWidth,
                    screenHeight,
                    plateThickness
                ]);
                // screen screw (top-left)
                translate([
                    screenScrewTopLeftPosX,
                    screenScrewTopLeftPosY
                ]) {
                    cylinder(
                        h=plateThickness,
                        r=screwTypeTwoRadius
                    );
                }
                // screen screw (top-right)
                translate([
                    screenScrewTopRightPosX,
                    screenScrewTopRightPosY
                ]) {
                    cylinder(
                        h=plateThickness,
                        r=screwTypeTwoRadius
                    );
                }
            }
            // coin insert
            translate([
                // Invert x-coordinate:
                plateWidth - (coinInsertPosX + coinInsertWidth),
                coinInsertPosY
            ]) {
                cube([
                    coinInsertWidth,
                    coinInsertHeight,
                    plateThickness
                ]);
                // screw (top)
                translate([
                    // Invert x-coordinate:
                    coinInsertWidth - (coinAcceptorScrewTopPosX + screwTypeTwoDiameter),
                    coinAcceptorScrewTopPosY
                ]) {
                    cylinder(
                        h=plateThickness,
                        r=screwTypeTwoRadius
                    );
                }
            }
            // coin output
            translate([coinOutputPosX, coinOutputPosY]) {
                cube([
                    coinOutputWidth,
                    coinOutputHeight,
                    plateThickness
                ]);
                // screw (bottom)
                translate([
                    // Invert x-coordinate:
                    coinOutputWidth - (coinAcceptorScrewBottomPosX + screwTypeTwoDiameter),
                    coinAcceptorScrewBottomPosY
                ]) {
                    cylinder(
                        h=plateThickness,
                        r=screwTypeTwoRadius
                    );
                }
                // screw (right)
                translate([
                    // Invert x-coordinate:
                    coinOutputWidth - (coinAcceptorScrewRightPosX + screwTypeOneDiameter),
                    coinAcceptorScrewRightPosY
                ]) {
                    cylinder(
                        h=plateThickness,
                        r=screwTypeOneRadius
                    );
                }
            }
            // teeth
            translate([
                topPlateTeethPosX,
                topPlateTeethPosY,
                plateThickness * (2/3)
            ]) {
                cube([
                    plateWidth,
                    toothHeight,
                    (plateThickness / 3) + 0.1
                ]);
                translate([0, 0, plateThickness / -3]) {
                    for (offsetX=[toothWidth : toothWidth * 2 : plateWidth]) {
                        translate([offsetX, 0]) {
                            cube([
                                toothWidth,
                                toothHeight,
                                (plateThickness / 3) + 0.1
                            ]);
                        }
                    }
                }
            }
        }
        // coin output catch
        difference() {
            translate([
                coinCatchPosX,
                coinCatchPosY,
                coinCatchPosZ
            ]) {
                cube([
                    coinCatchWidth,
                    coinCatchHeight,
                    coinCatchDepth
                ]);
            }
            translate([
                coinCatchPosX + coinCatchWallThickness,
                coinCatchPosY - coinCatchWallThickness,
                coinCatchPosZ - coinCatchWallThickness
            ]) {
                cube([
                    coinCatchWidth - (coinCatchWallThickness * 2),
                    coinCatchHeight,
                    coinCatchDepth
                ]);
            }
        }
    }
}

// plate (bottom)
translate([bottomPlatePosX, bottomPlatePosY]) {
    difference() {
        // plate
        cube([
            plateWidth,
            bottomPlateHeight,
            plateThickness
        ]);
        // screw (bottom-left)
        translate([
            screwBottomLeftPosX,
            screwBottomLeftPosY
        ]) {
            cylinder(
                h=plateThickness,
                r=screwTypeOneRadius
            );
        }
        // screw (bottom-right)
        translate([
            screwBottomRightPosX,
            screwBottomRightPosY
        ]) {
            cylinder(
                h=plateThickness,
                r=screwTypeOneRadius
            );
        }
        // teeth
        translate([
            bottomPlateTeethPosX,
            bottomPlateTeethPosY,
            plateThickness * (2/3)
        ]) {
            cube([
                plateWidth,
                toothHeight,
                (plateThickness / 3) + 0.1
            ]);
            translate([0, 0, plateThickness / -3]) {
                for (offsetX=[toothWidth : toothWidth * 2 : plateWidth]) {
                    translate([offsetX, 0]) {
                        cube([
                            toothWidth,
                            toothHeight,
                            (plateThickness / 3) + 0.1
                        ]);
                    }
                }
            }
        }
    }
}

// part mounts
translate([
    topPlatePosX + plateWidth + spaceBetweenPrintedParts,
    bottomPlatePosY + bottomPlateHeight + spaceBetweenPrintedParts
]) {
    mounts=[
        // screen mount #1:
        [ screenMountHeight, screwTypeTwoRadius + partMountWallThickness ],
        // screen mount #2:
        [ screenMountHeight, screwTypeTwoRadius + partMountWallThickness ],
        // coin acceptor left mount #1:
        [ coinAcceptorLeftMountHeight, screwTypeTwoRadius + partMountWallThickness ],
        // coin acceptor left mount #2:
        [ coinAcceptorLeftMountHeight, screwTypeTwoRadius + partMountWallThickness ],
        // coin acceptor right mount:
        [ coinAcceptorRightMountHeight, screwTypeOneRadius + partMountWallThickness ]
    ];
    for (index=[0 : 1 : len(mounts) - 1]) {
        mountHeight=mounts[index][0];
        mountRadius=mounts[index][1];
        translate([
            mountRadius,
            (spaceBetweenPrintedParts * index) + mountRadius + (mountRadius * 1.5 * index)
        ]) {
            difference() {
                cylinder(
                    h=mountHeight,
                    r=mountRadius
                );
                // screw hole:
                cylinder(
                    h=mountHeight,
                    r=mountRadius-partMountWallThickness
                );
            }
        }
    }
}
