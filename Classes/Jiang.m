//
//  Jiang.m
//  FCGXiangQi
//
//  Created by Sean Grove on 1/3/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

#import "Jiang.h"


@implementation Jiang
-(id) initWithPosition: (int) init_x andY: (int) init_y onTeam: (NSString *) ownerTeam
{
	team = ownerTeam;
	names = [NSDictionary dictionaryWithObjectsAndKeys:
			 @"帥", @"red",
			 @"將", @"black", nil];
	
	self = [super initWithPosition:init_x andY:init_y];
	
	vital = true; // Game-ending piece
	return self;
}

-(bool) moveAllowed: (int) new_x : (int) new_y
{
	if ( ![super moveAllowed:new_x :new_y] ) {return false;}

	if ( ![super moveAllowed:new_x :new_y] ) {return false;}
	
	// Can only be in the palace
	if (self.team == @"red")
	{
		if ((new_x > 5) || (new_x < 3) ||
			(new_y < 7)) {
			return false;
		}
	} else {
		if ((new_x > 5) || (new_x < 3) ||
			(new_y > 2)) {
			return false;
		}
	}

	// Can only move orthogonally
	if (((new_y == y) && (new_x == x + 1 || new_x == x - 1)) ||
		((new_x == x) && (new_y == y + 1 || new_y == y - 1)))
	{
		return true;
	}
	
	return false;
}

@end
