//
//  Zu.m
//  FCGXiangQi
//
//  Created by Sean Grove on 1/3/10.
//  Copyright 2010 Chuwe. All rights reserved.
//
#import <objc/runtime.h>
#import "Zu.h"

@implementation Zu
-(id) initWithPosition: (int) init_x andY: (int) init_y onTeam: (NSString *) ownerTeam
{
	team = ownerTeam;
	names = [NSDictionary dictionaryWithObjectsAndKeys:
			 @"卒", @"red",
			 @"兵", @"black", nil];

//	NSDictionary *directions = [NSDictionary dictionaryWithObjectsAndKeys:
//			 -1, @"red",
//			 1, @"black", nil];

//	direction =   //[directions objectForKey:team];
	if ( team == @"red" ) { direction = -1; }
	if ( team == @"black" ) { direction = 1; }
	
	self = [super initWithPosition:init_x andY:init_y];
	
	return self;
}

-(bool) moveAllowed: (int) new_x : (int) new_y
{
	if ( ![super moveAllowed:new_x :new_y] ) {return false;}
	
	NSLog(@"Checking to see if move is allowed...");
	bool attack = false;
	
	if ( ![self canMoveTo: new_x : new_y] ) { return false; }
	NSLog(@"Rules allow the movement.");

	/*
	if (board == NULL) { NSLog(@"Board is goddamn null"); } else {
		NSLog(@"It's not null, what the hell?");
		int i=0;
		unsigned int mc = 0;
		Method * mlist = class_copyMethodList(object_getClass(board), &mc);
		NSLog(@"%d methods", mc);
		for(i=0;i<mc;i++)
			NSLog(@"Method no #%d: %s", i, sel_getName(method_getName(mlist[i])));
		
		if ([board respondsToSelector:@selector(getUnitAtPoint)]) {
			NSLog(@"It responds. Damn it.");
		} else {
			NSLog(@"Fuck christ on a stick");
		}
	}
	 */

	
	Piece *unit = [board getUnitAtPoint:new_x andY:new_y];
		
	if ( unit )
	{
		NSLog(@"There is a unit at this position");
		if (unit.team == self.team)
		{
			NSLog(@"Friendly unit, move blocked");
			return false;
		} else {
			NSLog(@"Enemy unit, this is an attack!");
			attack = true;
		}
	} else {
		NSLog(@"No unit responded at destination.");
	}	
	
	return true;
}

-(bool) canMoveTo:  (int) new_x : (int) new_y
{
	NSLog(@"Zu: Can (%@) %@ move (%d, %d) -> (%d, %d)?", team, name, x, y, new_x, new_y );
	if (new_x == x && new_y == (y + direction) ) {
		return true;
	}
	
	// TODO: Find more elegant way of expressing these rules
	if ((self.team == @"red") &&
		(y < 5) &&
		(new_y == y) &&
		( new_x == (x - 1) || new_x == (x + 1) ))
	{
		return true;
	}
	
	if ((self.team == @"black") &&
		(y > 4) &&
		(new_y == y) &&
		( new_x == (x - 1) || new_x == (x + 1) ))
	{
		return true;
	}
	return false;
}

@end
