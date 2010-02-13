//
//  Team.m
//  FCGXiangQi
//
//  Created by Sean Grove on 1/3/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

#import "Team.h"
#import "Piece.h"

@implementation Team

-(void) addPiece: (Piece *) piece {
	piece.team = self;

	int r, g, b = 0;
	if (name == @"red") { r = 255; }
	[piece setColor:r :g :b];

	[board addPiece:piece];
	
	[pieces addObject:piece];
}

-(void) dealloc {
	[pieces release];
	[super dealloc];
}

-(void) clearPieceGraphic: (Piece *) piece {
	[board removePieceSprite:[piece sprite]];
	[piece clearSprite];
}

-(id) initWithBoard: (Board *) initBoard andName: (NSString *) initName {
	self = [super init];
	
	if (self) {
		self.board = initBoard;
		self.name = initName;
		self.pieces = [[NSMutableArray alloc] init];
	}
	
	return self;
}

-(BOOL) removePiece: (Piece *) piece {
	BOOL lost = false;
	if ( piece.vital ) { lost = true; }

	[self clearPieceGraphic:piece];

	[pieces removeObject:piece];
	if ( lost ) {
		NSLog(@"Game over, %@ team is dead", name);
		[board gameOver];
		return true;
	}
	
	NSLog(@"%@ team is wounded, but not dead", name);
	return false;
}

-(BOOL) removePieceAudibly: (Piece *) piece {
	BOOL lost = false;
	if ( piece.vital ) { lost = true; }
	
	[self clearPieceGraphic:piece];
	[piece soundDeathKnell];
	
	[pieces removeObject:piece];
	if ( lost ) {
		NSLog(@"Game over, %@ team is dead", name);
		[board gameOver];
		return true;
	}
	
	NSLog(@"%@ team is wounded, but not dead", name);
	return false;
}

-(void) removeTeamFromBoard {
	for (Piece *piece in pieces) {
		[self clearPieceGraphic:piece];
	}
}

-(id) unitAt: (int) x andY: (int) y {
	for (Piece *piece in pieces) {
		if (piece.x == x && piece.y == y) {
			return piece;
		}
	}
	
	return NULL;
}

@synthesize board;
@synthesize name;
@synthesize pieces;
@end
