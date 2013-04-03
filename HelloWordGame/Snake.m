//
//  Snake.m
//  HelloWordGame
//
//  Created by simon on 13-4-1.
//  Copyright (c) 2013年 simon. All rights reserved.
//

#import "Snake.h"

@implementation Snake
@synthesize snake_sprites=_snake_sprites;

- (id)init
{
    self = [super init];
    if (self) {
        max_length=20;
        current_length=3;
        current_direction=RIGHT;
        _snake_sprites=[[NSMutableArray alloc] init];
        for(int i=0;i<current_length;i++)
        {
            CCSprite *sprite=[self SpriteAtIndex:i];
            [_snake_sprites addObject:sprite];
            SPoint point;
            point.x=2-i;
            point.y=0;
            _snake_points[i]=point;
        }
        
    }
    return self;
}

-(CCSprite *)SpriteAtIndex:(int)index
{
    CCSprite *sprite=[CCSprite spriteWithFile:@"snake.png"];
    return sprite;
}

-(Boolean)step
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
-(void)changeDirection:(CGPoint)point
{
    /*CGFloat x=_snake_points[0].x*20+38;
    CGFloat y=_snake_points[0].y*20+49;*/
    CGPoint current=[[World sharedWorld] PointTranslation:_snake_points[0].x :_snake_points[0].y];
    if(current_direction==UP || current_direction==DOWN)
    {
        if(point.x>current.x)
            current_direction=RIGHT;
        else
            current_direction=LEFT;
    }
    else
    {
        if(point.y>current.y)
            current_direction=UP;
        else
            current_direction=DOWN;
    }
}
-(Boolean)canEatFood:(SPoint)point
{
    if(point.x==_snake_points[0].x &&point.y==_snake_points[0].y)
    {
        
        _snake_points[current_length]=lastPoint;
        CCSprite *sprite=[self SpriteAtIndex:current_length];
        current_length++;
        [_snake_sprites addObject:sprite];
        return YES;
    }
    else
    {
        return NO;
    }
}
-(Boolean)isKnockWall
{
    int max_col=[[World sharedWorld] maxCol];
    int max_row=[[World sharedWorld] maxRow];
    if(newHeadPos.x>max_col || newHeadPos.y>max_row || newHeadPos.x<0 || newHeadPos.y<0 )
    {
        return YES;
    }
    else
        return NO;
}
-(Boolean)isEatSelf
{
    for (int i = current_length - 1; i > 0; i--) // 撞自己
    {
        if(newHeadPos.x==_snake_points[i].x && newHeadPos.y==_snake_points[i].y)
            return YES;
    }
    return NO;
}
-(Boolean)isClideWithAnotherSnake
{
    
}
-(SPoint)positionOfSnakeAtIndex:(int)index
{
    return _snake_points[index];
}
@end
