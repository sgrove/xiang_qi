//
//  Movement.h
//  ___PROJECTNAME___
//
//  Created by Sean Grove on 1/3/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

@class Board;

@protocol Movement
-(bool) moveAllowed: (int) new_x andY: (int) new_y onBoard: (Board *) board;
//-(bool) moveAllowed;
@end
