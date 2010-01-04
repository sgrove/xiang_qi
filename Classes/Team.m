//
//  Team.m
//  ___PROJECTNAME___
//
//  Created by Sean Grove on 1/3/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

#import "Team.h"
#import "Piece.h"

@implementation Team

-(id) initWithBoard: (Layer *) layer andName: (NSString *) name andPlayingBoard: (Board *) newPlayingBoard
{
	self = [super init];
	
	if (self)
	{
		self.playingBoard = newPlayingBoard;
		self.board = layer;
		self.name = name;
		self.pieces = [[NSMutableArray alloc] init];
	}
	
	return self;
}

-(void) addPiece: (Piece *) piece
{
	int r = 0;
	int g = 0;
	int b = 0;
	
	if (name == @"red") {
		r = 255;
	}
	
	[board addChild:[piece sprite]];
	
	piece.realTeam = self;
	[piece attachToBoard:playingBoard];
	[piece setColor:r :g :b];
	[pieces addObject:piece];
}

-(bool) removePiece: (Piece *) piece
{
	bool lost = false;
	if ( piece.vital ) { lost = true; }
	
	[piece removeFromBoard];
	[pieces removeObject:piece];
	if ( lost )
	{
		NSLog(@"Game over, %@ team is dead", name);
		[playingBoard gameOver];
		return true;
	} else {
		NSLog(@"%@ team is wounded, but not dead", name);
		return false;
	}
}

-(void) removeAllFromBoard
{
	// Hackish, but a nice quick one
	for (Piece *piece in pieces)
	{
		[piece removeFromBoard];
	}
}

-(bool) lost
{
	// Hackish, but a nice quick one
	for (Piece *piece in pieces)
	{
		NSLog(@"%@:(%@)", name, piece.name);
		if (piece.name == @"帥") { NSLog(@"This is 帥"); }
		if (name == @"red") {
			NSLog(@"This is the red team!");
		if (piece.name == @"帥") { NSLog(@"This is 帥"); return false; } }
		if (name == @"black" && piece.name == @"將") { return false; }
	}
	
	// If there is no general, this side lost.
	return true;
}

-(id) unitAt: (int) x andY: (int) y
{
	for (Piece *piece in pieces)
	{
		if (piece.x == x && piece.y == y)
		{
			return piece;
		}
	}
	
	return NULL;
}

@synthesize playingBoard;
@synthesize board;
@synthesize name;
@synthesize pieces;
@end
