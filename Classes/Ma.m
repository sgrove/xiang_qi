//
//  Ma.m
//  FCGXiangQi
//
//  Created by Sean Grove on 1/3/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

#import "Ma.h"


@implementation Ma
-(id) initWithPosition: (int) init_x andY: (int) init_y onTeam: (NSString *) ownerTeam
{
	team = ownerTeam;
	names = [NSDictionary dictionaryWithObjectsAndKeys:
			 @"傌", @"red",
			 @"馬", @"black", nil];
	
	self = [super initWithPosition:init_x andY:init_y];
	
	return self;
}

-(bool) moveAllowed: (int) new_x : (int) new_y
{
	if ( ![super moveAllowed:new_x :new_y] ) { return false; }
	
	int dx = abs(new_x - x);
	int dy = abs(new_y - y);
	
	if ( dx > dy )
	{
		if ( dx != 2 || dy != 1) { NSLog(@"%@ cannot move in that pattern", name); return false; } // Right pattern
		// Move horizontally before diagonally - check for blocks
		int direction = (new_x - x) / 2;
		Piece *unit = [board getUnitAtPoint:(x + direction) andY:y];
		if ( unit != NULL ) { NSLog(@" %@ blocked horizontally", name); return false; }
	} else {
		if ( dy != 2 || dx != 1) { NSLog(@"%@ cannot move in that pattern", name); return false; } // Right pattern
		// Move horizontally before diagonally
		int direction = (new_y - y) / 2;
		Piece *unit = [board getUnitAtPoint:x andY:(y + direction)];
		if ( unit != NULL ) { NSLog(@" %@ blocked vertically", name); return false; }
	}	
	
	

	return true;
}
@end
