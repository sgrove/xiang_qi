//
//  Ju.m
//  FCGXiangQi
//
//  Created by Sean Grove on 1/3/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

#import "Ju.h"


@implementation Ju
-(id) initWithPosition: (int) init_x andY: (int) init_y onTeam: (NSString *) ownerTeam
{
	team = ownerTeam;
	names = [NSDictionary dictionaryWithObjectsAndKeys:
			 @"俥", @"red",
			 @"車", @"black", nil];
	
	self = [super initWithPosition:init_x andY:init_y];
	
	return self;
}

-(BOOL) isMoveAllowed: (int) new_x : (int) new_y
{
	if ( ![super isMoveAllowed:new_x :new_y] ) {return false;}
	
	// TODO: Make it DRY. Not in the mood right now.
	// -- Probably means I should take a break. But not yet.
	// Determine if move is vertical or horizontal
	NSLog(@"Checking for piece in the path");
	if (new_x == x) {
		NSLog(@"Vertical move");
		// vertical
		// determine up or down
		if (new_y > y) {
			NSLog(@"Move up");
			// up
			NSLog(@"Move-y from %d to %d", y, new_y);
			for (int i = y + 1; i < new_y; i++) {
				NSLog(@"Checking for piece at %d, %d", new_x, i);
			Piece *unit = [[team board] getUnitAtPoint:new_x andY:i];
				if ( unit != NULL) { NSLog(@"Found piece %@ at %d %d", unit.name, new_x, i); return FALSE; }
			}
		} else {
			NSLog(@"Move down");
			// down
			for (int i = y - 1; i > new_y; i--) { Piece *unit = [[team board] getUnitAtPoint:new_x andY:i]; if ( unit != NULL) { return FALSE; } }
		}
	} else if (new_y == y) {
		NSLog(@"Horizontal move");
		// horizontal
		if (new_x > x) {
			// right
			for (int i = x + 1; i < new_x; i++) { Piece *unit = [[team board] getUnitAtPoint:i andY:new_y]; if ( unit != NULL) { return FALSE; } }
		} else {
			// left
			for (int i = x - 1; i > new_x; i--) { Piece *unit = [[team board] getUnitAtPoint:i andY:new_y]; if ( unit != NULL) { return FALSE; } }
		}		
	} else {
		return false;
	}
		
	return true;
}
@end
