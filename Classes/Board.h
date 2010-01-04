//
//  Board.h
//  ___PROJECTNAME___
//
//  Created by Sean Grove on 1/3/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

#import "cocos2d.h"
#import "Piece.h"
#import "Team.h"


@interface Board : NSObject {
	Sprite *board;
	Team *team_1;
	Team *team_2;
}
-(id) getUnitAtPoint: (int) x andY: (int) y;
-(bool) killUnitAtPoint: (int) x andY: (int) y;
-(CGPoint) convertPointToBoard: (int) x andY: (int) y;
-(void) gameOver;
@property (nonatomic, retain) Sprite *board;
@property (readwrite, retain) Team *team_1;
@property (nonatomic, retain) Team *team_2;
@end
