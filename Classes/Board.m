//
//  Board.m
//  FCGXiangQi
//
//  Created by Sean Grove on 1/3/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

#import "Board.h"


@implementation Board
- (CGPoint) convertPointToBoard: (CGPoint) initialPoint {
	NSLog(@"Converting %@ to board coord", NSStringFromCGPoint(initialPoint));
	initialPoint.x -= 32;
	initialPoint.y -= 40;
	
	CGPoint newPoint;
	newPoint.x = floor(initialPoint.x / 30);
	newPoint.y = floor(initialPoint.y / 40);
	
	return newPoint;
}

-(void) dealloc {
	[team_1 release];
	[team_2 release];
	
	[super dealloc];
}

-(void) gameOver {
	[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"charlotte.mp3"];
	[team_1 removeTeamFromBoard];
	[team_2 removeTeamFromBoard];
	
	Label *endLabel = [Label labelWithString:@"游戏结束" fontName:@"Marker Felt" fontSize:60];
	endLabel.color = ccc3(255, 255, 255);
	[sprite addChild:endLabel];
	endLabel.position = ccp(160, 240); // Adjust label within piece space		
}

- (NSMutableArray *) getAllPieces {
	NSMutableArray *teamPieces = [[NSMutableArray alloc] init];
	
	for (Piece *piece in [team_1 pieces]) { [teamPieces addObject:piece]; }
	for (Piece *piece in [team_2 pieces]) { [teamPieces addObject:piece]; }
	
	return teamPieces;
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

-(id) getUnitAtPoint: (CGPoint) point {
	return [self getUnitAtPoint: point.x : point.y];
}

-(id) init {
	
	self = [super init];

	if (self) {
		// Initalize board
		int board_width = 320;
		int board_height = 480;

		sprite = [Sprite spriteWithFile:@"Board.png"];
		sprite.position = ccp( board_width / 2,  board_height / 2 );
	}
	
	return self;
}

-(void) addPiece: (Piece *) piece {
	[self addPieceSprite:[piece sprite]];
}

-(void) addPieceSprite: (Sprite *) pieceSprite {
	[sprite addChild:pieceSprite];
}

-(void) removePieceSprite: (Sprite *) pieceSprite {
	[sprite removeChild:pieceSprite cleanup:YES];
}

@synthesize sprite;
@synthesize team_1;
@synthesize team_2;
@end
