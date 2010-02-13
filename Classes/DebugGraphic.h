//
//  DebugGraphic.h
//  xiangqi
//
//  Created by Sean Grove on 1/9/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

#import "cocos2d.h"

@interface DebugGraphic : CocosNode {
	CGPoint point_1;
	CGPoint point_2;
	CGPoint point_3;
	CGPoint point_4;
}
-(void) setVertices: (CGPoint) new_point_1 : (CGPoint) new_point_2 : (CGPoint) new_point_3 : (CGPoint) new_point_4;
-(void) setVertices: (CGRect) rect;
@end
