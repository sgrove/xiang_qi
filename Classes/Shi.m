//
//  Shi.m
//  FCGXiangQi
//
//  Created by Sean Grove on 1/3/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

#import "Shi.h"


@implementation Shi
-(id) initWithPosition: (int) init_x andY: (int) init_y onTeam: (NSString *) ownerTeam
{
	team = ownerTeam;
	names = [NSDictionary dictionaryWithObjectsAndKeys:
			 @"仕", @"red",
			 @"士", @"black", nil];
	
	self = [super initWithPosition:init_x andY:init_y];
	
	return self;
}

-(bool) moveAllowed: (int) new_x : (int) new_y
{
	if ( ![super moveAllowed:new_x :new_y] ) {return false;}
	
	// Can only move diagonally
	if (((new_x != x + 1) && (new_x != x - 1)) ||
		((new_y != y + 1) && (new_y != y - 1)))
	{
		NSLog(@"%@ unit move (%d, %d) -> (%d, %d) denied", self.name, x, y, new_x, new_y ); 
		return false;
	}
	
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
			

	return true;
}
@end
