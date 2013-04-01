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
    CCSprite *sprite=[CCSprite spriteWithFile:@"Icon.png"];
    return sprite;
}

-(void)step
{
    SPoint tmp=_snake_points[0];
    switch (current_direction) {
        case UP:
            tmp.y++;
            break;
        case RIGHT:
            tmp.x++;
            break;
        case DOWN:
            tmp.y--;
            break;
        case LEFT:
            tmp.x--;
            break;
        default:
            break;
    }
    lastPoint=_snake_points[current_length-1];
    for (int i = current_length - 1; i > 0; i--)
    {
        _snake_points[i]=_snake_points[i-1];
    }
    _snake_points[0]=tmp;
}
-(void)changeDirection:(CGPoint)point
{
    CGFloat x=_snake_points[0].x*20+38;
    CGFloat y=_snake_points[0].y*20+49;
    if(current_direction==UP || current_direction==DOWN)
    {
        if(point.x>x)
            current_direction=RIGHT;
        else
            current_direction=LEFT;
    }
    else
    {
        if(point.y>y)
            current_direction=UP;
        else
            current_direction=DOWN;
    }
}
-(Boolean)canEatFood:(SPoint)point
{
    if(point.x==_snake_points[0].x &&point.y==_snake_points[0].y)
    {
        
        _snake_points[current_length-1]=lastPoint;
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
-(Boolean)isEatSelf
{
    
}
-(Boolean)isClideWithAnotherSnake
{
    
}
-(SPoint)positionOfSnakeAtIndex:(int)index
{
    return _snake_points[index];
}
@end
