//
//  GameState.m
//  FCGXiangQi
//
//  Created by Sean Grove on 1/6/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

#import "GameState.h"


@implementation GameState

-(void) dealloc {
	[pieces release];
	[redTeam release];
	[blackTeam release];
	[teams release];
	[board release];
}

- (void) encodeWithCoder:(NSCoder *)coder {
	[pieces removeAllObjects];

	[coder encodeObject:pieces forKey:@"piecesArray"];
}

-(id) init {
	self.board     = [[Board alloc] init];
	self.redTeam   = [[Team alloc] initWithBoard:[board boardSprite] andName:@"red"];
	self.blackTeam = [[Team alloc] initWithBoard:[board boardSprite] andName:@"black"];

	NSArray *teams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
					  redTeam,   @"red",
					  blackTeam, @"black", nil];
	
	NSMutableArray *pieces = [[NSMutableArray alloc] init];
}

- (id) initWithCoder:(NSCoder *)coder {
    self = [super init];
	pieces = [[coder decodeObjectForKey:@"pieces"] retain];

    return self;
}

@synthesize theWorld;
@synthesize board;
@synthesize redTeam;
@synthesize blackTeam;
@synthesize teams;
@synthesize pieces;
@end
