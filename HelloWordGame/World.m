//
//  World.m
//  HelloWordGame
//
//  Created by simon on 13-4-1.
//  Copyright (c) 2013年 simon. All rights reserved.
//

#import "World.h"

@implementation World

-(void)drawGameRect
{
    //glDisable(GL_LINE_WIDTH);
	glLineWidth( 1.0f );
	//glColor4ub(0,0,0,255);
    
    CGRect gameRect = CGRectMake(28, 39, 422, 242);
    CGPoint poli[]=
    {gameRect.origin,
        CGPointMake(gameRect.origin.x,gameRect.origin.y + gameRect.size.height),
        CGPointMake(gameRect.origin.x + gameRect.size.width, gameRect.origin.y + gameRect.size.height),
        CGPointMake(gameRect.origin.x + gameRect.size.width,gameRect.origin.y)};
    
	ccDrawLine(poli[0], poli[1]);
	ccDrawLine(poli[1], poli[2]);
	ccDrawLine(poli[2], poli[3]);
	ccDrawLine(poli[3], poli[0]);
}

-(CGPoint)PointTranslation:(int)row :(int)col
{
    CGPoint point=CGPointMake(38 + row * 20, 49 + col * 20);
    return  point;
}

@end
