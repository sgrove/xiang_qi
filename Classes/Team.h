//
//  Team.h
//  FCGXiangQi
//
//  Created by Sean Grove on 1/3/10.
//  Copyright 2010 Chuwe. All rights reserved.
//
#import "cocos2d.h"

@class Piece;
@class Board;

@interface Team : NSObject {
	Board *board;
	NSString *name;
	NSMutableArray *pieces;
}

-(void) addPiece: (Piece *) piece;
-(id) initWithBoard: (Board *) initBoard andName: (NSString *) initName;
-(void) removeTeamFromBoard;
-(BOOL) removePiece: (Piece *) piece;
-(id) unitAt: (int) x andY: (int) y;
@property (nonatomic, assign) Board *board;
@property (nonatomic, assign) NSString *name;
@property (nonatomic, assign) NSMutableArray *pieces;
@end
