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
-(id) initWithPosition: (int) init_x andY: (int) init_y onTeam: (NSString *) ownerTeam {
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

-(BOOL) isMoveAllowed: (int) new_x : (int) new_y
{
	if ( ![super isMoveAllowed:new_x :new_y] ) {return false;}
	
	if (new_x == x && new_y == (y + direction) ) { return YES; }

	if (([self.team name] == @"red") &&
		(y < 5) &&
		(new_y == y) &&
		( new_x == (x - 1) || new_x == (x + 1) )) {
		return YES;
	}
	
	if (([self.team name] == @"black") &&
		(y > 4) &&
		(new_y == y) &&
		(new_x == (x - 1) || new_x == (x + 1))) {
		return YES;
	}
	
	NSLog(@"Rules allow the movement.");
	
	return NO;
}

@end
