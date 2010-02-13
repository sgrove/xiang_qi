//
//  piece.m
//  FCGXiangQi
//
//  Created by Sean Grove on 1/2/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

#import "piece.h"

@implementation Piece
enum {
	kTagDebug = 1,
};

-(void) clearSprite {
	sprite = NULL;
}

// TODO: Refactor
// These conversion factors shouldn't be hardcoded,
// or they should be a constant.
-(CGPoint) convertPoint: (int) new_x : (int) new_y {
	int board_x = 32 + (new_x * 32);
	int board_y = 45 + (new_y * 45);
	
	if (new_y > 4) { board_y -= 15; }
	
	return ccp(board_x, board_y);
}

-(void) dealloc {
	[debugGraphic release];

	[super dealloc];
}

-(void) deselected {
	if ( self.sprite == NULL ) { return; }
	Action *scaler  = [ScaleTo actionWithDuration:0.25f scale:1.0f];
	Action *opacity = [FadeTo actionWithDuration:0.25f opacity:255];
	Action *runner  = [Spawn actions:scaler, opacity, nil];

	[sprite runAction:runner];
}

- (void) encodeWithCoder:(NSCoder *)coder {
	[coder encodeInt:x forKey:@"x"];
	[coder encodeInt:y forKey:@"y"];
	[coder encodeBool:vital forKey:@"vital"];
	[coder encodeObject:name forKey:@"name"];
	[coder encodeObject:[team name] forKey:@"team_name"];
}


// Note: This is in pixels, not board units
-(void) forceJumpTo: (float)new_x : (float)new_y {	
	NSLog(@"Told to jump to (%f, %f)", new_x, new_y );
	
	CGPoint destination;
	destination.x = new_x;
	destination.y = new_y;
	
	NSLog(@"Moving piece (graphically) to (%f, %f)", destination.x, destination.y );
	[self.sprite runAction: [MoveTo actionWithDuration:0.0f position:destination]];
}

-(void) forceMoveTo: (int)new_x : (int)new_y {
	x = new_x;
	y = new_y;

	[self.sprite runAction: [MoveTo actionWithDuration:0.25f position:[self convertPoint:x :y]]];
}

-(id) init {
	self = [super init];

	if (self) {
		sprite = [Sprite spriteWithFile:@"Piece.png"];

		name =  [names objectForKey:team];
		label = [Label labelWithString:name fontName:@"Marker Felt" fontSize:16];
		[sprite addChild:label];
		label.position = ccp(18, 18); // Adjust label within piece space
		

		vital = false; // Not a game-ending piece by default
		
		[self setColor:0 :0 :0];
		
		debugGraphic = [[DebugGraphic alloc] init];
		
		// DebugGraphic
		CGSize  spriteSize = CGSizeMake(sprite.contentSize.height, sprite.contentSize.width);
		
		DebugGraphic *dg = [[DebugGraphic alloc] init];
		[dg setVertices:CGRectMake(sprite.position.x, sprite.position.y, 
								   spriteSize.width, spriteSize.height)];
		
		self.debugGraphic = dg;
		
		[sprite addChild:dg z:2 tag:kTagDebug];
	}

	return self;
}

- (id) initWithCoder:(NSCoder *) coder {
 	x = [coder decodeIntForKey:@"x"];
	y = [coder decodeIntForKey:@"y"];
	vital = [coder decodeBoolForKey:@"vital"];
	name  = [coder decodeObjectForKey:@"name"];
	
	[super init];
}

-(id) initWithPosition: (int) init_x andY:(int) init_y {
	self = [self init];
	
	if (self) {
		[self forceMoveTo:init_x :init_y];
	}
	
	return self;
}

-(BOOL) isMoveAllowed: (int) new_x : (int) new_y {
	// Border check
	if ( new_x < 0 || new_x >= 9 || new_y < 0 || new_y > 9 ) { NSLog(@"%@ Move out of bounds", self.name); return false; }
	Piece *unit = [[self.team board] getUnitAtPoint:new_x andY:new_y];
	
	if ( unit )
	{
		if (unit.team == self.team)
		{
			NSLog(@"%@ Move blocked by friendly unit %@", self.name, unit.name);
			return false;
		}
	}
	
	return true;
}

-(BOOL) isMoveAttack:(int) new_x : (int) new_y {
	Piece *unit = [[team board] getUnitAtPoint:new_x andY:new_y];
	
	if ( unit )
	{
		NSLog(@"There is a unit at this position");
		if (unit.team == self.team)
		{
			NSLog(@"%@ Move blocked by friendly unit %@", self.name, unit.name);
			return false;
		} else {
			// LOOKOUTITSCOMINRIGHTFURUS!
			return true;
		}
	}
	
	return false;
}

- (BOOL) moveTo: (CGPoint) destination {
	return [self moveTo: destination.x : destination.y];
}

-(BOOL) moveTo: (int)new_x : (int)new_y {
	NSLog(@"Trying to move (%@) %@", self.team, self.name);
	
	if ( [self isMoveAllowed:new_x : new_y] ) {
		if ( [self isMoveAttack:new_x :new_y] ) {
			Piece *unit = [[team board] getUnitAtPoint:new_x andY:new_y];
			NSLog(@"(%@) %@ has been attacked, removing", unit.team, unit.name);
			//			// Move is allowed and it's an attack. Sayonara, baby.
			bool quit = unit.vital;
			
			[unit.team removePieceAudibly:unit];
			
			if ( quit ) { return false; };
			
			NSLog(@"Unit removed");
		}
		NSLog(@"Done checking for attack");
		x = new_x;
		y = new_y;
		CGPoint new_point = [self convertPoint:x :y];
		NSLog(@"Set new point");
		Action *move_action = [MoveTo actionWithDuration:0.25f position:new_point];
		NSLog(@"Created new animation, running...");
		
		[self.sprite runAction: move_action];
		return true;
	} 
	
	return false;
}

-(CGPoint) position {
	return CGPointMake(x, y);
}

-(void) removeFromBoard {
	[[[self sprite] parent] removeChild:sprite cleanup:false];
	sprite = NULL;
}

-(void) removeFromBoardAudibly {
	[self removeFromBoard];
}

-(void) selected {
	Action *scaler =  [ScaleTo actionWithDuration:0.25f scale:2.0f];
	Action *opacity = [FadeTo actionWithDuration:0.25f opacity:125];
	Action *runner = [Spawn actions:scaler, opacity, nil];
	
	[[SimpleAudioEngine sharedEngine] playEffect:@"concrete_stone_dragging_smooth_6.wav"]; // play a sound
	[sprite runAction:runner];
}

-(void) setColor: (int) r : (int) g : (int) b {
	label.color = ccc3(r, g, b);
}

-(void) soundDeathKnell {
	[[SimpleAudioEngine sharedEngine] playEffect:@"hammer_stone_3.wav"]; //play a sound
}

@synthesize x, y;
@synthesize vital;
@synthesize team;
@synthesize name;
@synthesize names;
@synthesize sprite;
@synthesize label;
@synthesize debugGraphic;
@end
