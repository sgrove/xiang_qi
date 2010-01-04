//
//  piece.h
//  ___PROJECTNAME___
//
//  Created by Sean Grove on 1/2/10.
//  Copyright 2010 Chuwe. All rights reserved.
//
#import "cocos2d.h"

@class Team;
@class Board;

@interface Piece : NSObject {
	int x;
	int y;
	
	NSString *team;
	NSString *name;
	NSDictionary *names;
	
	bool vital;
	
	Label *label;
	Sprite *sprite;
	Team *realTeam;
	Board *board;
}

-(id) initWithPosition: (int) x andY: (int) y;
-(id) initWithPosition: (int) x andY: (int) y andKillSwitch: (bool) killSwitch;
-(bool) moveAllowed: (int) new_x : (int) new_y;
-(bool) moveTo:      (int) new_x : (int) new_y;
-(void) forceMoveTo: (int) new_x : (int) new_y;
-(void) forceJumpTo:  (float) new_x : (float) new_y;
-(bool) isMoveAttack:(int) new_x : (int) new_y;
-(void) attachToBoard: (Board *) newBoard;
-(void) removeFromBoard;
-(void) setColor: (int) r : (int) g : (int) b;
-(CGPoint) convertPoint: (int) new_x : (int) new_y;
-(void)selected;
-(void)deseledted;
@property (nonatomic, retain) NSString *team;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDictionary *names;
@property (nonatomic, retain) Team *realTeam;
@property (nonatomic, retain) Board *board;
@property (readonly) Sprite *sprite;
@property (readonly) Label *label;
@property (readonly) int x;
@property (readonly) int y;
@property (readonly) bool vital;
@end
