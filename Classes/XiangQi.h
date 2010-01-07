//
//  XiangQi.h
//  FCGXiangQi
//
//  Created by Sean Grove on 1/3/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Team.h"
#import "Piece.h"
#import "Board.h"

// XiangQi Interface
@interface XiangQi : Layer
{
	Board *board;
	
	// Initialize teams
	Team *team_1;
	Team *team_2;
	bool pieceSelected;
	NSArray *teams;
	
	Piece *selectedPiece;
	NSString *currentTeam;
}


+(id) scene;
@property (nonatomic, retain) Board *board;
@property (nonatomic, retain) Piece *selectedPiece;
@end
