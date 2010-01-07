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
	NSString *name;
	NSMutableArray *pieces;
	Layer *board;
	Board *playingBoard;
}

-(id) initWithBoard: (Layer *) layer andName: (NSString *) name andPlayingBoard: (Board *) newPlayingBoard;
-(void) addPiece: (Piece *) piece;
-(bool) removePiece: (Piece *) piece;
-(id) unitAt: (int) x andY: (int) y;
-(void) removeAllFromBoard;
-(bool) lost;
@property (nonatomic, retain) Board *playingBoard;
@property (nonatomic, retain) Layer *board;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableArray *pieces;
@end
