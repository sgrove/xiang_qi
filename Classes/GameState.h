//
//  GameState.h
//  FCGXiangQi
//
//  Created by Sean Grove on 1/6/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

@class Board;
@class Team;

@interface GameState : NSObject <NSCoding> {
	NSArray *teams;
	NSMutableArray *pieces;
	NSMutableDictionary *theWorld;	

	Board *board;
	Team  *redTeam;
	Team  *blackTeam;
}

+(void)loadGameStateFromFile:(NSString *)file;
@property (nonatomic, assign) NSMutableDictionary *theWorld;
@property (nonatomic, assign) Board *board;
@property (nonatomic, assign) Team *redTeam;
@property (nonatomic, assign) Team *blackTeam;
@property (nonatomic, assign) NSArray *teams;
@property (nonatomic, assign) NSMutableArray *pieces;
@end
