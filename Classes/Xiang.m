//
//  Xiang.m
//  ___PROJECTNAME___
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

-(bool) moveAllowed: (int) new_x : (int) new_y
{
	if ( ![super moveAllowed:new_x :new_y] ) {return false;}
	
	// Xiang can only move diagonolly two spaces at a time 
	// and cannot cross the river (for a total of 7 places)
	if (((new_x != x - 2) && (new_x != x + 2)) &&
		((new_y != y - 2) && (new_y != y + 2))) {
		return false;
	}
	
	if ( team == @"red"   && new_y < 5) { return false; } 
	if ( team == @"black" && new_y > 4) { return false; }
	
	return true;
}
@end
