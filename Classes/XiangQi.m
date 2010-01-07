//
//  XiangQi.m
//  FCGXiangQi
//
//  Created by Sean Grove on 1/3/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

// Import the interfaces
#import "XiangQi.h"
#import "Board.h"
#import "Team.h"
#import "Jiang.h"
#import "Shi.h"
#import "Xiang.h"
#import "Ma.h"
#import "Ju.h"
#import "Pao.h"
#import "Zu.h"

// XiangQi implementation
@implementation XiangQi

+(id) scene
{
	// 'scene' is an autorelease object.
	Scene *scene = [Scene node];
	
	// 'layer' is an autorelease object.
	XiangQi *layer = [XiangQi node];
	
	// add layer as a child to scene
	[scene addChild: layer];
		
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super init] )) {
		self.isTouchEnabled = YES;

		board = [[Board alloc] init];
		[self addChild:board.board];
		
		// Initialize teams
		Team *red_team =   [[Team alloc] initWithBoard:[board board] andName: @"red" andPlayingBoard: board];
		Team *black_team = [[Team alloc] initWithBoard:[board board] andName: @"black" andPlayingBoard: board];
		
		board.team_1 = red_team;
		board.team_2 = black_team;

		// Initialize pieces
		[red_team addPiece:[[Jiang alloc]	initWithPosition:4 andY:9 onTeam:@"red"]];
		[red_team addPiece:[[Shi alloc]		initWithPosition:3 andY:9 onTeam:@"red"]];
		[red_team addPiece:[[Shi alloc]		initWithPosition:5 andY:9 onTeam:@"red"]];
		[red_team addPiece:[[Xiang alloc]	initWithPosition:2 andY:9 onTeam:@"red"]];
		[red_team addPiece:[[Xiang alloc]	initWithPosition:6 andY:9 onTeam:@"red"]];
		[red_team addPiece:[[Ma alloc]		initWithPosition:1 andY:9 onTeam:@"red"]];
		[red_team addPiece:[[Ma alloc]		initWithPosition:7 andY:9 onTeam:@"red"]];
		[red_team addPiece:[[Ju alloc]		initWithPosition:0 andY:9 onTeam:@"red"]];
		[red_team addPiece:[[Ju alloc]		initWithPosition:8 andY:9 onTeam:@"red"]];
		[red_team addPiece:[[Pao alloc]		initWithPosition:1 andY:7 onTeam:@"red"]];
		[red_team addPiece:[[Pao alloc]		initWithPosition:7 andY:7 onTeam:@"red"]];
		[red_team addPiece:[[Zu alloc]		initWithPosition:0 andY:6 onTeam:@"red"]];
		[red_team addPiece:[[Zu alloc]		initWithPosition:2 andY:6 onTeam:@"red"]];
		[red_team addPiece:[[Zu alloc]		initWithPosition:4 andY:6 onTeam:@"red"]];
		[red_team addPiece:[[Zu alloc]		initWithPosition:6 andY:6 onTeam:@"red"]];
		[red_team addPiece:[[Zu alloc]		initWithPosition:8 andY:6 onTeam:@"red"]];
		
		[black_team addPiece:[[Jiang alloc] initWithPosition:4 andY:0 onTeam:@"black"]];
		[black_team addPiece:[[Shi alloc]   initWithPosition:3 andY:0 onTeam:@"black"]];
		[black_team addPiece:[[Shi alloc]   initWithPosition:5 andY:0 onTeam:@"black"]];
		[black_team addPiece:[[Xiang alloc] initWithPosition:2 andY:0 onTeam:@"black"]];
		[black_team addPiece:[[Xiang alloc] initWithPosition:6 andY:0 onTeam:@"black"]];
		[black_team addPiece:[[Ma alloc]    initWithPosition:1 andY:0 onTeam:@"black"]];
		[black_team addPiece:[[Ma alloc]    initWithPosition:7 andY:0 onTeam:@"black"]];
		[black_team addPiece:[[Ju alloc]    initWithPosition:0 andY:0 onTeam:@"black"]];
		[black_team addPiece:[[Ju alloc]    initWithPosition:8 andY:0 onTeam:@"black"]];
		[black_team addPiece:[[Pao alloc]   initWithPosition:1 andY:2 onTeam:@"black"]];
		[black_team addPiece:[[Pao alloc]   initWithPosition:7 andY:2 onTeam:@"black"]];
		[black_team addPiece:[[Zu alloc]    initWithPosition:0 andY:3 onTeam:@"black"]];
		[black_team addPiece:[[Zu alloc]    initWithPosition:2 andY:3 onTeam:@"black"]];
		[black_team addPiece:[[Zu alloc]    initWithPosition:4 andY:3 onTeam:@"black"]];
		[black_team addPiece:[[Zu alloc]    initWithPosition:6 andY:3 onTeam:@"black"]];
		[black_team addPiece:[[Zu alloc]    initWithPosition:8 andY:3 onTeam:@"black"]];

		// For debugging game ending
		[red_team addPiece:[[Pao alloc]		initWithPosition:4 andY:4 onTeam:@"red"]];

		team_1 = red_team;
		team_2 = black_team;
		
		currentTeam = @"red";

	}
	return self;
}

- (BOOL)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	
	if( touch ) {
		NSLog(@"Touch began!");
		
		CGPoint location = [touch locationInView: [touch view]];
		
		// IMPORTANT:
		// The touches are always in "portrait" coordinates. You need to convert them to your current orientation
		CGPoint convertedPoint = [[Director sharedDirector] convertToGL:location];
		//NSLog(@"Original:  %@", NSStringFromCGPoint(location));
		NSLog(@"Converted: %@", NSStringFromCGPoint(convertedPoint));
		NSLog(@"----> %f, %f", convertedPoint.x, convertedPoint.y);
		
		CGPoint newPoint = [[self board] convertPointToBoard: convertedPoint.x andY: convertedPoint.y];
		int converted_x = newPoint.x;
		int converted_y = newPoint.y;
		
		NSLog(@"Board: (%d, %d)", converted_x, converted_y);
		
		if ( pieceSelected )
		{
			NSLog(@"Something wierd... piece shouldn't be selected right now");
			pieceSelected = FALSE;
			self.selectedPiece = NULL;
		} 
		else if ( self.selectedPiece = [[self board] getUnitAtPoint:converted_x andY:converted_y] )
		{
			if (self.selectedPiece.team == currentTeam) {
				NSLog(@"Piece selected: %@ on team: %@", self.selectedPiece.name, self.selectedPiece.team);
				[self.selectedPiece selected];
				pieceSelected = TRUE;
			} else {
				NSLog(@"It is %@ team's turn right now", currentTeam);
			}
		}
		

		
		// no other handlers will receive this event
		return kEventHandled;
	}
	
	// we ignore the event. Other receivers will receive this event.
	return kEventIgnored;		
}

- (BOOL)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	
	if( touch ) {
		NSLog(@"Touch Moved!");
		CGPoint location = [touch locationInView: [touch view]];
		
		// IMPORTANT:
		// The touches are always in "portrait" coordinates. You need to convert them to your current orientation
		CGPoint convertedPoint = [[Director sharedDirector] convertToGL:location];
		//NSLog(@"Original:  %@", NSStringFromCGPoint(location));
		NSLog(@"Converted: %@", NSStringFromCGPoint(convertedPoint));
		NSLog(@"---> %f, %f", convertedPoint.x, convertedPoint.y);

		if ( pieceSelected )
		{
			NSLog(@"Forcing piece to jump to: %f, %f", convertedPoint.x, convertedPoint.y);
			[self.selectedPiece forceJumpTo:convertedPoint.x :convertedPoint.y];
		}
		
		// no other handlers will receive this event
		return kEventHandled;
	}
	
	// we ignore the event. Other receivers will receive this event.
	return kEventIgnored;		
}


- (BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	
	if( touch ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		// IMPORTANT:
		// The touches are always in "portrait" coordinates. You need to convert them to your current orientation
		CGPoint convertedPoint = [[Director sharedDirector] convertToGL:location];
		//NSLog(@"Original:  %@", NSStringFromCGPoint(location));
		NSLog(@"Converted: %@", NSStringFromCGPoint(convertedPoint));

		CGPoint newPoint = [[self board] convertPointToBoard: convertedPoint.x andY: convertedPoint.y];
		int converted_x = newPoint.x;
		int converted_y = newPoint.y;
		
		NSLog(@"Board: (%d, %d)", converted_x, converted_y);
		

		if ( pieceSelected )
		{
			NSLog(@"Should move %@ piece to %d, %d", selectedPiece.name, converted_x, converted_y);
			bool moveOk = [self.selectedPiece moveTo:converted_x :converted_y];
			[self.selectedPiece deselected];
			if ( !moveOk ) {
				NSLog(@"Not allowed to move %@ to %d, %d - deselecting", selectedPiece.name, converted_x, converted_y);
				[self.selectedPiece forceMoveTo:self.selectedPiece.x :self.selectedPiece.y];
			} else {
				if (currentTeam == @"red") { currentTeam = @"black"; } else { currentTeam = @"red"; }
				NSLog(@"Now %@ team's turn", currentTeam);
			}
			pieceSelected = FALSE;
			self.selectedPiece = NULL;
		} 
/*		
		else if ( self.selectedPiece = [[self board] getUnitAtPoint:converted_x andY:converted_y] )
		{
			if (self.selectedPiece.team == currentTeam) {
				NSLog(@"Piece selected: %@ on team: %@", self.selectedPiece.name, self.selectedPiece.team);
				[self.selectedPiece selected];
				pieceSelected = TRUE;
			} else {
				NSLog(@"It is %@ team's turn right now", currentTeam);
			}
		}
 */
		
		// no other handlers will receive this event
		return kEventHandled;
	}
	
	// we ignore the event. Other receivers will receive this event.
	return kEventIgnored;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@synthesize board;
@synthesize selectedPiece;
@end
