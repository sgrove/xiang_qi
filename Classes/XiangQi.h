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
#import "DebugGraphic.h"

// XiangQi Interface
@interface XiangQi : Layer
{
	Board *board;
	
	// Initialize teams
	BOOL isPieceSelected;
	NSArray *teams;
	
	Piece *selectedPiece;
	NSString *currentTeam;
	NSString *movementMethod;
	
	DebugGraphic *debugGraphic;
}


+(id) scene;
-(void) toggleTeam;
-(CGPoint) convertToBoard: (CGPoint) screenPoint;
-(BOOL) rectContainsPoint: (CGRect) containerRect point: (CGPoint) point;
@property (nonatomic, assign) Board *board;
@property (nonatomic, assign) Piece *selectedPiece;
@property (nonatomic, assign) BOOL isPieceSelected;
@property (nonatomic, assign) NSString *movementMethod;
@property (nonatomic, assign) DebugGraphic *debugGraphic;
@end
