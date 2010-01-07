//
//  Pao.m
//  FCGXiangQi
//
//  Created by Sean Grove on 1/3/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

#import "Pao.h"


@implementation Pao
-(id) initWithPosition: (int) init_x andY: (int) init_y onTeam: (NSString *) ownerTeam
{
	team = ownerTeam;
	names = [NSDictionary dictionaryWithObjectsAndKeys:
			 @"炮", @"red",
			 @"砲", @"black", nil];
	
	self = [super initWithPosition:init_x andY:init_y];
	
	return self;
}

-(bool) moveAllowed: (int) new_x : (int) new_y
{
	if ( ![super moveAllowed:new_x :new_y] ) {return false;}
	
	int count = 0;
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
					Piece *unit = [board getUnitAtPoint:new_x andY:i];
					if ( unit != NULL) { NSLog(@"Found piece %@ at %d %d", unit.name, new_x, i); count += 1; }
				}
			} else {
				NSLog(@"Move down");
				// down
				for (int i = y - 1; i > new_y; i--) { Piece *unit = [board getUnitAtPoint:new_x andY:i]; if ( unit != NULL) { count += 1; } }
			}
		} else if (new_y == y) {
			NSLog(@"Horizontal move");
			// horizontal
			if (new_x > x) {
				// right
				for (int i = x + 1; i < new_x; i++) { Piece *unit = [board getUnitAtPoint:i andY:new_y]; if ( unit != NULL) { count += 1; } }
			} else {
				// left
				for (int i = x - 1; i > new_x; i--) { Piece *unit = [board getUnitAtPoint:i andY:new_y]; if ( unit != NULL) { count += 1; } }
			}		
		} else {
			return false;
		}
	
	// Movement of Pao depends on if its an attack or not
	// We already checked for friendly units, so if there's
	// a unit here, it's an attack.
	Piece *unit = [board getUnitAtPoint:new_x andY:new_y];
	if ( unit != NULL)
	{
		NSLog(@"This is an attempted attack by %@ on %@", self.name, unit.name);
		// Attack. If we've counted one unit in the path, then the move is valid.
		if (count == 1) {
			return true;
		} else {
			return false;
		}
	} else {
		NSLog(@"This is a normal move");
		// Normal movement. If we've counted one unit in the path, then the move is invalid.
		if (count > 0) {
			return false;
		} else {
			return true;
		}
	}
}
@end
