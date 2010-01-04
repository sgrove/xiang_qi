//
//  Board.m
//  ___PROJECTNAME___
//
//  Created by Sean Grove on 1/3/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

#import "Board.h"


@implementation Board
-(id) init {
	
	self = [super init];

	if (self)
	{
		// Initalize board
		int board_width = 320;
		int board_height = 480;

		board = [Sprite spriteWithFile:@"Board.png"];
		board.position = ccp( board_width / 2,  board_height / 2 );
	}
	
	return self;
}
- (id) getUnitAtPoint: (int) x andY: (int) y
{
	NSLog(@"Looking for unit.");
	NSLog(@"Looking for unit at %d, %d", x, y);
	
	NSLog(@"Checking in team_1 with %d units", [self.team_1.pieces count]);
	Piece *unit = [self.team_1 unitAt:x andY:y];
	if (unit == NULL) {
		NSLog(@"Checking in team_2 with %d units", [self.team_2.pieces count]);
		unit = [self.team_2 unitAt:x andY:y]; }

	if (unit != NULL) 
	{ 
		NSLog(@"Unit found: %@", unit.name);
	} else {
		NSLog(@"No unit found at position");
	}

	return unit;
}

- (CGPoint) convertPointToBoard: (int) x andY: (int) y
{
	x -= 32;
	y -= 40;
	
	CGPoint newPoint;
	newPoint.x = floor(x / 30);
	newPoint.y = floor(y / 40);
	
	return newPoint;
}

-(void) gameOver
{
	[team_1 removeAllFromBoard];
	[team_2 removeAllFromBoard];
	
	Label *endLabel = [Label labelWithString:@"游戏结束" fontName:@"Marker Felt" fontSize:60];
	endLabel.color = ccc3(255, 255, 255);
	[board addChild:endLabel];
	endLabel.position = ccp(150, 240); // Adjust label within piece space		
}

@synthesize board;
@synthesize team_1;
@synthesize team_2;
@end
