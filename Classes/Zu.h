//
//  Zu.h
//  FCGXiangQi
//
//  Created by Sean Grove on 1/3/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

#import "Piece.h"
#import "XiangQi.h"

@interface Zu : Piece {
	int direction;
}

-(BOOL) isMoveAllowed: (int) new_x : (int) new_y;
-(id) initWithPosition: (int) init_x andY: (int) init_y onTeam: (NSString *) ownerTeam;
@end
