//
//  piece.h
//  FCGXiangQi
//
//  Created by Sean Grove on 1/2/10.
//  Copyright 2010 Chuwe. All rights reserved.
//
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

// Forward declartion:
//  Basically, promise to Xcode that these classes will
//  be declared sometime in the future
@class Team;
@class Board;
@class DebugGraphic;

@interface Piece : NSObject <NSCoding> {
	int x, y;
	
	NSString *teamName;
	NSString *name;
	NSDictionary *names;
	
	bool vital;

	Label *label;
	Sprite *sprite;

	Team *team;

	DebugGraphic *debugGraphic;
}

-(void) attachToBoard: (Board *) newBoard;
-(void) clearSprite;
-(CGPoint) convertPoint: (int) new_x : (int) new_y;
-(void) forceMoveTo: (int) new_x : (int) new_y;
-(void) forceJumpTo:  (float) new_x : (float) new_y;
-(id) initWithPosition: (int) x andY: (int) y;
-(id) initWithPosition: (int) x andY: (int) y andKillSwitch: (bool) killSwitch;
-(BOOL) isMoveAttack:(int) new_x : (int) new_y;
-(BOOL) isMoveAllowed: (int) new_x : (int) new_y;
-(BOOL) moveTo:      (int) new_x : (int) new_y;
-(BOOL) moveTo:      (CGPoint) destination;
-(void) removeFromBoard;
-(void) setColor: (int) r : (int) g : (int) b;
-(void) selected;
-(void) deselected;
-(CGPoint) position;
@property (readonly) int x, y;
@property (nonatomic, retain) NSString *teamName;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDictionary *names;
@property (nonatomic, retain) Team *team;
@property (nonatomic, assign) DebugGraphic *debugGraphic;
@property (readonly) Sprite *sprite;
@property (readonly) Label *label;
@property (readonly) bool vital;
@end
