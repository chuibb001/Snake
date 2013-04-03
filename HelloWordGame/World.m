//
//  World.m
//  HelloWordGame
//
//  Created by simon on 13-4-1.
//  Copyright (c) 2013年 simon. All rights reserved.
//

#import "World.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@implementation World

+(World *)sharedWorld
{
    static World *world;
    if(world==nil)
    {
        world=[[World alloc] init];
    }
    return  world;
}
-(int)maxRow
{
    return 11;
}
-(int)maxCol
{
    if(iPhone5)
        return 24;
    else
        return 20;
}
-(void)drawGameRect
{
    //glDisable(GL_LINE_WIDTH);
	glLineWidth( 1.0f );
	//glColor4ub(0,0,0,255);
    
    CGRect gameRect;
    if(iPhone5)
        gameRect = CGRectMake(30, 40, 500, 240);
    else
        gameRect = CGRectMake(34, 40, 420, 240);
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
    CGPoint point;
    if(iPhone5)
        point=CGPointMake(44 + (float)row * 20, 50 + (float)col * 20);
    else
        point=CGPointMake(40 + (float)row * 20, 50 + (float)col * 20);
    return point;
}

@end
