//
//  AutoSnake.m
//  HelloWordGame
//
//  Created by simon on 13-4-2.
//  Copyright (c) 2013年 simon. All rights reserved.
//

#import "AutoSnake.h"

@implementation AutoSnake
- (id)init
{
    self = [super init];
    if (self) {
        max_length=20;
        current_length=3;
        current_direction=LEFT;
        _snake_sprites=[[NSMutableArray alloc] init];
        for(int i=0;i<current_length;i++)
        {
            CCSprite *sprite=[self SpriteAtIndex:i];
            [_snake_sprites addObject:sprite];
            SPoint point;
            point.x=18+i;
            point.y=11;
            _snake_points[i]=point;
        }
        
    }
    return self;
}

-(Boolean)step:(SPoint)point
{
    newHeadPos=_snake_points[0];
    
    switch (current_direction)
    {
        case UP:
            newHeadPos.y++;
            break;
        case RIGHT:
            newHeadPos.x++;
            break;
        case DOWN:
            newHeadPos.y--;
            break;
        case LEFT:
            newHeadPos.x--;
            break;
        default:
            break;
    }
    lastPoint=_snake_points[current_length-1];
    
    if([self isKnockWall])  // 撞墙
        return NO;
    
    if([self isEatSelf]) // 撞自己
        return NO;
    
    for (int i = current_length - 1; i > 0; i--)
    {
        _snake_points[i]=_snake_points[i-1];
    }
    _snake_points[0]=newHeadPos;
    
    return YES;
    
}

@end
