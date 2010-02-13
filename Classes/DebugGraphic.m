//
//  DebugGraphic.m
//  xiangqi
//
//  Created by Sean Grove on 1/9/10.
//  Copyright 2010 Chuwe. All rights reserved.
//

#import "DebugGraphic.h"


@implementation DebugGraphic

-(void) draw
{
	glEnable(GL_LINE_SMOOTH);
	glColor4ub(255, 0, 255, 255);
	glLineWidth(2);
	CGPoint vertices2[] = { point_1, point_2, point_3, point_4 };
	drawPoly(vertices2, 4, YES);
}

-(void) setVertices: (CGPoint) new_point_1 : (CGPoint) new_point_2 : (CGPoint) new_point_3 : (CGPoint) new_point_4 {
	point_1 = new_point_1;
	point_2 = new_point_2;
	point_3 = new_point_3;
	point_4 = new_point_4;
}

-(void) setVertices: (CGRect) rect {
	point_1 = ccp(rect.origin.x, rect.origin.y);
	point_2 = ccp(rect.origin.x, rect.origin.y + rect.size.height);
	point_3 = ccp(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
	point_4 = ccp(rect.origin.x + rect.size.width, rect.origin.y);
}
@end
