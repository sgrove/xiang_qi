//
//  Xiang.m
//  FCGXiangQi
//
//  Created by Sean Grove on 1/3/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

#import "Xiang.h"


@implementation Xiang
-(id) initWithPosition: (int) init_x andY: (int) init_y onTeam: (NSString *) ownerTeam
{
	team = ownerTeam;
	names = [NSDictionary dictionaryWithObjectsAndKeys:
			 @"象", @"red",
			 @"相", @"black", nil];
	
	self = [super initWithPosition:init_x andY:init_y];
	
	return self;
}

-(BOOL) isMoveAllowed: (int) new_x : (int) new_y
{
	if ( ![super isMoveAllowed:new_x :new_y] ) { return NO; }

	NSLog(@"Checking specific move rules for %@", self.name );
	if ( [team name] == @"red"   && new_y < 5) { return NO; } 
	if ( [team name] == @"black" && new_y > 4) { return NO; }
	
	NSLog(@"Not overbounds %@", self.name );
	// Xiang can only move diagonolly two spaces at a time 
	// and cannot cross the river (for a total of 7 places)
	if (((new_x == x - 2) || (new_x == x + 2)) &&
		((new_y == y - 2) || (new_y == y + 2))) {
		NSLog(@"Not in %@'s movement pattern", self.name );
		return YES;
	}

	NSLog(@"(%d, %d) -> (%d, %d) is allowed for %@", x, y, new_x, new_y, self.name );
	
	return NO;
}
@end
