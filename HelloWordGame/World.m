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
-(CCSprite *)gameBackgroundSprite
{
    CCSprite *background;
    if(iPhone5)
    {
        background=[CCSprite spriteWithFile:@"ganme_background2@2x.png"];
        background.position=ccp([[CCDirector sharedDirector] winSize].width/2, [[CCDirector sharedDirector] winSize].height/2);
    }
    else
    {
        background=[CCSprite spriteWithFile:@"ganme_background@2x.png"];
        background.position=ccp([[CCDirector sharedDirector] winSize].width/2, [[CCDirector sharedDirector] winSize].height/2);
    }
    return background;
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
