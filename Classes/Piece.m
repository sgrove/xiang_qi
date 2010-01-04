//
//  piece.m
//  ___PROJECTNAME___
//
//  Created by Sean Grove on 1/2/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

#import "piece.h"


@implementation Piece
-(id) init
{
	self = [super init];
	
	if (self) {
		sprite = [Sprite spriteWithFile:@"Piece.png"];
		
		name = [names objectForKey:team];
		// create and initialize a Label
		label = [Label labelWithString:name fontName:@"Marker Felt" fontSize:16];
		label.color = ccc3(0, 0, 0);
		[sprite addChild:label];
		label.position = ccp(18, 18); // Adjust label within piece space
		
		vital = false; // Not a game-ending piece by default
	}
	
	return self;	
}

-(id) initWithPosition: (int) init_x andY:(int) init_y
{
	self = [self init];
	
	if (self) {
		[self forceMoveTo:init_x :init_y];
	}

	return self;
}

-(void) setColor: (int) r : (int) g : (int) b
{
	label.color = ccc3(r, g, b);
}

-(void) attachToBoard: (Board *) newBoard
{
	if (newBoard == NULL) { NSLog(@"Cannot attach to a null newBoard"); exit(1); }
	board = newBoard;
}

-(void) removeFromBoard
{
	[[[self sprite] parent] removeChild:sprite cleanup:false];
}

-(void) forceMoveTo: (int)new_x : (int)new_y
{
		x = new_x;
		y = new_y;
		
		[self.sprite runAction: [MoveTo actionWithDuration:0.25f position:[self convertPoint:x :y]]];
}

-(bool) moveTo: (int)new_x : (int)new_y
{
	NSLog(@"Trying to move (%@) %@", self.team, self.name);
	
	if ( [self moveAllowed:new_x : new_y] ) {
		if ( [self isMoveAttack:new_x :new_y] ) {
			Piece *unit = [board getUnitAtPoint:new_x andY:new_y];
			NSLog(@"(%@) %@ has been attacked, removing", unit.team, unit.name);
//			// Move is allowed and it's an attack. Sayonara, baby.
			bool quit = unit.vital;
			
			[unit.realTeam removePiece:unit];
			
			if ( quit ) { return false; };

			NSLog(@"Unit removed");
		}
		NSLog(@"Done checking for attack");
		x = new_x;
		y = new_y;
		CGPoint new_point = [self convertPoint:x :y];
		NSLog(@"Set new point");
		Action *move_action = [MoveTo actionWithDuration:0.25f position:new_point];
		NSLog(@"Created new animation, running...");

		[self.sprite runAction: move_action];
		return true;
	} 
	
	return false;
}

-(bool) isMoveAttack:(int) new_x : (int) new_y
{
	Piece *unit = [board getUnitAtPoint:new_x andY:new_y];
	
	if ( unit )
	{
		NSLog(@"There is a unit at this position");
		if (unit.team == self.team)
		{
			NSLog(@"%@ Move blocked by friendly unit %@", self.name, unit.name);
			return false;
		} else {
			// LOOKOUTIT'SCOMINRIGHTFURUS!
			return true;
		}
	}
	
	return false;
}

-(bool) moveAllowed: (int) new_x : (int) new_y
{
	// Border check
	if ( new_x < 0 || new_x >= 9 || new_y < 0 || new_y > 9 ) { return false; }
	Piece *unit = [board getUnitAtPoint:new_x andY:new_y];
	
	if ( unit )
	{
		NSLog(@"There is a unit at this position");
		if (unit.team == self.team)
		{
			NSLog(@"%@ Move blocked by friendly unit %@", self.name, unit.name);
			return false;
		}
	}
	
	return true;
}
								
-(CGPoint) convertPoint: (int) new_x : (int) new_y
{
	int board_x = 32 + (new_x * 32);
	int board_y = 45 + (new_y * 45);
	
	if (new_y > 4) { board_y -= 15; }
	
	return ccp(board_x, board_y);
}

@synthesize x;
@synthesize y;
@synthesize vital;
@synthesize board;
@synthesize realTeam;
@synthesize team;
@synthesize name;
@synthesize names;
@synthesize sprite;
@synthesize label;
@end
