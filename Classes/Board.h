//
//  Board.h
//  FCGXiangQi
//
//  Created by Sean Grove on 1/3/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

#import "cocos2d.h"
#import "Piece.h"
#import "Team.h"


@interface Board : NSObject {
	Sprite *sprite;
	Team *team_1;
	Team *team_2;
}
-(id) getUnitAtPoint: (CGPoint) point;
-(id) getUnitAtPoint:new_x andY:new_y;
-(bool) killUnitAtPoint: (CGPoint) point;
-(CGPoint) convertPointToBoard: (CGPoint) point;
-(void) gameOver;
-(NSMutableArray *) getAllPieces;
-(void) addPiece: (Piece *) piece;
-(void) addPieceSprite: (Sprite *) pieceSprite;
-(void) removePieceSprite: (Sprite *) pieceSprite;
@property (nonatomic, retain) Sprite *sprite;
@property (readwrite, retain) Team *team_1;
@property (nonatomic, retain) Team *team_2;
@end
