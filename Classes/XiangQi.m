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

enum {
	kTagDebug = 1,
};

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
		movementMethod = @"tap";

		self.isTouchEnabled = YES;

		board = [[Board alloc] init];
		[self addChild:board.sprite];
		
		// Initialize teams
		Team *redTeam   = [[Team alloc] initWithBoard:board andName:@"red"];
		Team *blackTeam = [[Team alloc] initWithBoard:board andName:@"black"];
		
		board.team_1 = redTeam;
		board.team_2 = blackTeam;
		
		CGPoint LOWERLEFT;
		CGPoint UPPERRIGHT;
		
		LOWERLEFT.x = 15;
		LOWERLEFT.y = 15;
		
		UPPERRIGHT.x = 305;
		UPPERRIGHT.y = 480;
		
		const int INCREMENT_X = (UPPERRIGHT.x - LOWERLEFT.x) / 9;
		const int INCREMENT_Y = (UPPERRIGHT.y - LOWERLEFT.y) / 9;

		NSLog(@"Increments: %d, %d", INCREMENT_X, INCREMENT_Y);

		// Initialize pieces
		[redTeam addPiece:[[Jiang alloc]	initWithPosition:4 andY:9 onTeam:@"red"]];
		[redTeam addPiece:[[Shi alloc]		initWithPosition:3 andY:9 onTeam:@"red"]];
		[redTeam addPiece:[[Shi alloc]		initWithPosition:5 andY:9 onTeam:@"red"]];
		[redTeam addPiece:[[Xiang alloc]	initWithPosition:2 andY:9 onTeam:@"red"]];
		[redTeam addPiece:[[Xiang alloc]	initWithPosition:6 andY:9 onTeam:@"red"]];
		[redTeam addPiece:[[Ma alloc]		initWithPosition:1 andY:9 onTeam:@"red"]];
		[redTeam addPiece:[[Ma alloc]		initWithPosition:7 andY:9 onTeam:@"red"]];
		[redTeam addPiece:[[Ju alloc]		initWithPosition:0 andY:9 onTeam:@"red"]];
		[redTeam addPiece:[[Ju alloc]		initWithPosition:8 andY:9 onTeam:@"red"]];
		[redTeam addPiece:[[Pao alloc]		initWithPosition:1 andY:7 onTeam:@"red"]];
		[redTeam addPiece:[[Pao alloc]		initWithPosition:7 andY:7 onTeam:@"red"]];
		[redTeam addPiece:[[Zu alloc]		initWithPosition:0 andY:6 onTeam:@"red"]];
		[redTeam addPiece:[[Zu alloc]		initWithPosition:2 andY:6 onTeam:@"red"]];
		[redTeam addPiece:[[Zu alloc]		initWithPosition:4 andY:6 onTeam:@"red"]];
		[redTeam addPiece:[[Zu alloc]		initWithPosition:6 andY:6 onTeam:@"red"]];
		[redTeam addPiece:[[Zu alloc]		initWithPosition:8 andY:6 onTeam:@"red"]];
		
		[blackTeam addPiece:[[Jiang alloc] initWithPosition:4 andY:0 onTeam:@"black"]];
		[blackTeam addPiece:[[Shi alloc]   initWithPosition:3 andY:0 onTeam:@"black"]];
		[blackTeam addPiece:[[Shi alloc]   initWithPosition:5 andY:0 onTeam:@"black"]];
		[blackTeam addPiece:[[Xiang alloc] initWithPosition:2 andY:0 onTeam:@"black"]];
		[blackTeam addPiece:[[Xiang alloc] initWithPosition:6 andY:0 onTeam:@"black"]];
		[blackTeam addPiece:[[Ma alloc]    initWithPosition:1 andY:0 onTeam:@"black"]];
		[blackTeam addPiece:[[Ma alloc]    initWithPosition:7 andY:0 onTeam:@"black"]];
		[blackTeam addPiece:[[Ju alloc]    initWithPosition:0 andY:0 onTeam:@"black"]];
		[blackTeam addPiece:[[Ju alloc]    initWithPosition:8 andY:0 onTeam:@"black"]];
		[blackTeam addPiece:[[Pao alloc]   initWithPosition:1 andY:2 onTeam:@"black"]];
		[blackTeam addPiece:[[Pao alloc]   initWithPosition:7 andY:2 onTeam:@"black"]];
		[blackTeam addPiece:[[Zu alloc]    initWithPosition:0 andY:3 onTeam:@"black"]];
		[blackTeam addPiece:[[Zu alloc]    initWithPosition:2 andY:3 onTeam:@"black"]];
		[blackTeam addPiece:[[Zu alloc]    initWithPosition:4 andY:3 onTeam:@"black"]];
		[blackTeam addPiece:[[Zu alloc]    initWithPosition:6 andY:3 onTeam:@"black"]];
		[blackTeam addPiece:[[Zu alloc]    initWithPosition:8 andY:3 onTeam:@"black"]];

		// For debugging game ending
		//[blackTeam addPiece:[[Pao alloc]	initWithPosition:4 andY:4 onTeam:@"red"]];
		
		[redTeam   autorelease];
		[blackTeam autorelease];

		currentTeam = @"red";
		// DebugGraphic
		CGPoint point_1 = CGPointMake(10, 10);
		CGPoint point_2 = CGPointMake(10, 50);
		CGPoint point_3 = CGPointMake(50, 50);
		CGPoint point_4 = CGPointMake(50, 10);
		
		DebugGraphic *dg = [[DebugGraphic alloc] init];
		[dg setVertices:point_1 :point_2 :point_3 :point_4];
		
		self.debugGraphic = dg;
		
		[self addChild:dg z:2 tag:kTagDebug];
	}
	return self;
}

- (BOOL)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ( movementMethod == @"tap" ) { return kEventIgnored; }
	
	UITouch *touch = [touches anyObject];
	
	if( touch ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		// IMPORTANT:
		// The touches are always in "portrait" coordinates. You need to convert them to your current orientation
		CGPoint convertedPoint = [[Director sharedDirector] convertToGL:location];
		CGPoint newPoint = [[self board] convertPointToBoard: convertedPoint];

		int converted_x = newPoint.x;
		int converted_y = newPoint.y;
		
		NSLog(@"Touch at %@ -> board %@", NSStringFromCGPoint(convertedPoint), NSStringFromCGPoint(newPoint));
		
		if ( isPieceSelected ) {
			NSLog(@"Something wierd... piece shouldn't be selected right now");
				isPieceSelected = FALSE;
			self.selectedPiece = NULL;
		} else if ( self.selectedPiece = [[self board] getUnitAtPoint:converted_x andY:converted_y] ) {
			if (self.selectedPiece.team.name == currentTeam) {
				NSLog(@"Piece selected: %@ on team: %@", self.selectedPiece.name, self.selectedPiece.team);
				[self.selectedPiece selected];
				isPieceSelected = TRUE;
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
	if ( movementMethod == @"tap" ) { return kEventIgnored; }

	UITouch *touch = [touches anyObject];
	
	if( touch ) {
		NSLog(@"Touch Moved!");
		CGPoint location = [touch locationInView: [touch view]];
		
		CGPoint convertedPoint = [[Director sharedDirector] convertToGL:location];

		if ( isPieceSelected ) {
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
		BOOL pieceTouched = NO;
		Piece *targetPiece = NULL;

		CGPoint convertedPoint = [[Director sharedDirector] convertToGL:[touch locationInView: [touch view]]];
		CGPoint spritePosition = convertedPoint;
		CGSize  spriteSize = CGSizeMake(35 / 2.0f, 35 / 2.0f);			
		CGRect  boundingRect = CGRectMake(spritePosition.x - spriteSize.width, spritePosition.y - spriteSize.height, 
										  spriteSize.width * 2, spriteSize.height * 2);
		[self.debugGraphic setVertices:boundingRect];
		
		for ( Piece *piece in [board getAllPieces]) {
			Sprite *sprite = [piece sprite];
			CGPoint spritePosition = sprite.position;
			CGSize  spriteSize = CGSizeMake(sprite.contentSize.height / 2, sprite.contentSize.width / 2);			
			CGRect  boundingRect = CGRectMake(spritePosition.x - spriteSize.width, spritePosition.y - spriteSize.height, 
											  spriteSize.width * 2, spriteSize.height * 2);
			
			
			NSLog(@"(%@) %@ [%@]: %@ in %@ ? %d", piece.team.name, piece.name, NSStringFromCGPoint(spritePosition), NSStringFromCGPoint(convertedPoint), NSStringFromCGRect(boundingRect), CGRectContainsPoint(boundingRect, convertedPoint));
			
			// Replace CGRectContainsPoint with custom function 
			
			if ([self rectContainsPoint:boundingRect point:convertedPoint]) {
				NSLog(@"Piece: %@ was touched", piece.name);
				pieceTouched = YES;
				targetPiece = piece;
				break;
			}
		}
		
		if ( isPieceSelected ) {
			NSLog(@"Should move %@ piece to %@", selectedPiece.name, NSStringFromCGPoint(convertedPoint));
			CGPoint newPoint = [self convertToBoard: convertedPoint];
			BOOL    moveOk   = [self.selectedPiece moveTo:newPoint];

			if ( moveOk ) { [self toggleTeam]; }			
			
			isPieceSelected = FALSE;
			[self.selectedPiece deselected];
			self.selectedPiece = NULL;
		} else if ( pieceTouched ) {
			self.selectedPiece = targetPiece;
			if (self.selectedPiece.team.name == currentTeam) {
				NSLog(@"Piece selected: %@ on team: %@", self.selectedPiece.name, self.selectedPiece.team.name);
				[self.selectedPiece selected];
				isPieceSelected = TRUE;
				Sprite *sprite = [self.selectedPiece sprite];
				CGSize spriteSize = CGSizeMake(sprite.contentSize.height / 2, sprite.contentSize.width / 2);

				CGPoint spritePosition = [[Director sharedDirector] convertToGL:[sprite position]];
				CGRect myRect = CGRectMake(spritePosition.x - spriteSize.width, spritePosition.y - spriteSize.height, 
										   spritePosition.x + spriteSize.width, spritePosition.y + spriteSize.height);
				NSLog(@"Piece %@ is at %@, centered between %@, Size: %@ ", self.selectedPiece.name, NSStringFromCGPoint(spritePosition), NSStringFromCGRect(myRect), NSStringFromCGSize(spriteSize) );
				
			} else {
				NSLog(@"It is %@ team's turn right now", currentTeam);
			}
			
			// no other handlers will receive this event
			return kEventHandled;
		}
	}
	
	// we ignore the event. Other receivers will receive this event.
	return kEventIgnored;
}

- (CGPoint) convertToBoard: (CGPoint) screenPoint {
	return [board convertPointToBoard:screenPoint];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc {
	[board release];
	[debugGraphic release];

	[super dealloc];
}

- (BOOL) rectContainsPoint: (CGRect) containerRect point: (CGPoint) point {
	if (containerRect.origin.x <= point.x && containerRect.origin.x + containerRect.size.width  >= point.x &&
		containerRect.origin.y <= point.y && containerRect.origin.y + containerRect.size.height >= point.y) {
		NSLog(@"{(%f, %f), (%f, %f)} contains (%f, %f)",	containerRect.origin.x, containerRect.origin.y,
														containerRect.origin.x + containerRect.size.width, containerRect.origin.y + containerRect.size.height,
														point.x, point.y);
		return YES;
	}
	
	return NO;
}

- (void) toggleTeam {
	if (currentTeam == @"red") { currentTeam = @"black"; } else { currentTeam = @"red"; }
}

@synthesize board;
@synthesize selectedPiece;
@synthesize isPieceSelected;
@synthesize movementMethod;
@synthesize debugGraphic;
@end
