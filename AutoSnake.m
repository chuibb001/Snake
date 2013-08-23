//
//  AutoSnake.m
//  HelloWordGame
//
//  Created by simon on 13-4-2.
//  Copyright (c) 2013年 simon. All rights reserved.
//

#import "AutoSnake.h"

int x_table[4][3] = {0,-1,1,0,-1,1,-1,0,0,1,0,0};
int y_table[4][3] = {1,0,0,-1,0,0,0,1,-1,0,1,-1};

@implementation AutoSnake
- (id)init
{
    self = [super init];
    if (self) {
        max_length=20;
        _current_length=3;
        current_direction=LEFT;
        self.numberOfFoodEatten = 0;
        _snake_sprites=[[NSMutableArray alloc] init];
        for(int i=0;i<_current_length;i++)
        {
            CCSprite *sprite=[self SpriteAtIndex:i];
            [_snake_sprites addObject:sprite];
            SPoint point;
            point.x=18+i;
            point.y=11;
            _snake_points[i]=point;
            self.speed = 1.0f;
        }
        CCSprite * head= [_snake_sprites objectAtIndex:0];
        head.rotation=270;
        
        [self initScoreSprite];
    }
    return self;
}

-(CCSprite *)SpriteAtIndex:(int)index
{
    CCSprite *sprite;
    if(index==0)
        sprite=[CCSprite spriteWithFile:@"snake_green_head@2x.png"];
    else if(index%2==0)
        sprite=[CCSprite spriteWithFile:@"snake_green_light@2x.png"];
    else
        sprite=[CCSprite spriteWithFile:@"snake_green_dark@2x.png"];
    return sprite;
}

-(Boolean)step:(SPoint)point andAnotherSnake:(Snake *)another
{
    newHeadPos=_snake_points[0];
    
    int availableCount = 0;
    SPoint availableSteps [3];
    SPoint s; // tmp point 新位置
    SPoint bestPos;
    float min = 100.0;
    
    switch (current_direction) {
        case UP:
            for(int i= 0;i<3;i++)
            {
                s.x = newHeadPos.x + x_table[0][i];
                s.y = newHeadPos.y + y_table[0][i];
                
                if(![self isKnockWall:s] && ![self isEatSelf:s] && ![self isClideWithAnotherSnake:another andNewPosition:s]) // 合理位置
                {
                    // mark this position
                    availableSteps[availableCount].x = s.x;
                    availableSteps[availableCount].y = s.y;
                    availableCount++;
                }
            }
            
            for(int i=0;i<availableCount;i++)  // 计算最小代价的位置
            {
                float m = [self distanceOfFood:point andNewPostion:availableSteps[i]];
                if(m < min)
                {
                    min = m;
                    bestPos = availableSteps[i];
                }
            }
            
            // 计算改变了什么方向
            int a = bestPos.x - newHeadPos.x;
            int b = bestPos.y - newHeadPos.y;
            if(a == -1)
                current_direction = LEFT;
            else if(a == 1)
                current_direction = RIGHT;
            break;
        case DOWN:
            for(int i= 0;i<3;i++)
            {
                s.x = newHeadPos.x + x_table[1][i];
                s.y = newHeadPos.y + y_table[1][i];
                
                if(![self isKnockWall:s] && ![self isEatSelf:s] && ![self isClideWithAnotherSnake:another andNewPosition:s]) // 合理位置
                {
                    // mark this position
                    availableSteps[availableCount].x = s.x;
                    availableSteps[availableCount].y = s.y;
                    availableCount++;
                }
            }
            for(int i=0;i<availableCount;i++)  // 计算最小代价的位置
            {
                float m = [self distanceOfFood:point andNewPostion:availableSteps[i]];
                if(m < min)
                {
                    min = m;
                    bestPos = availableSteps[i];
                }
            }
            // 计算改变了什么方向
            int a1 = bestPos.x - newHeadPos.x;
            //int b1 = bestPos.y - newHeadPos.y;
            if(a1 == -1)
                current_direction = LEFT;
            else if(a1 == 1)
                current_direction = RIGHT;
            break;
        case LEFT:
            for(int i= 0;i<3;i++)
            {
                s.x = newHeadPos.x + x_table[2][i];
                s.y = newHeadPos.y + y_table[2][i];
                if(![self isKnockWall:s] && ![self isEatSelf:s] && ![self isClideWithAnotherSnake:another andNewPosition:s]) // 合理位置
                {
                    // mark this position
                    availableSteps[availableCount].x = s.x;
                    availableSteps[availableCount].y = s.y;
                    availableCount++;
                }
            }
            for(int i=0;i<availableCount;i++)  // 计算最小代价的位置
            {
                float m = [self distanceOfFood:point andNewPostion:availableSteps[i]];
                if(m < min)
                {
                    min = m;
                    bestPos = availableSteps[i];
                }
            }
            // 计算改变了什么方向
            //int a2 = bestPos.x - newHeadPos.x;
            int b2 = bestPos.y - newHeadPos.y;
            if(b2 == -1)
                current_direction = DOWN;
            else if(b2 == 1)
                current_direction = UP;
            break;
        case RIGHT:
            for(int i= 0;i<3;i++)
            {
                s.x = newHeadPos.x + x_table[3][i];
                s.y = newHeadPos.y + y_table[3][i];
                
                if(![self isKnockWall:s] && ![self isEatSelf:s] && ![self isClideWithAnotherSnake:another andNewPosition:s]) // 合理位置
                {
                    // mark this position
                    availableSteps[availableCount].x = s.x;
                    availableSteps[availableCount].y = s.y;
                    availableCount++;
                }
            }
            for(int i=0;i<availableCount;i++)  // 计算最小代价的位置
            {
                float m = [self distanceOfFood:point andNewPostion:availableSteps[i]];
                if(m < min)
                {
                    min = m;
                    bestPos = availableSteps[i];
                }
            }
            // 计算改变了什么方向
            int a3 = bestPos.x - newHeadPos.x;
            int b3 = bestPos.y - newHeadPos.y;
            if(b3 == -1)
                current_direction = DOWN;
            else if(b3 == 1)
                current_direction = UP;
            break;
        default:
            break;
        
    }
    
    if(availableCount == 0)
        return NO;
    else  // 更新步伐
    {
        newHeadPos = bestPos;
        lastPoint=_snake_points[_current_length-1];
        for (int i = _current_length - 1; i > 0; i--)
        {
            _snake_points[i]=_snake_points[i-1];
        }
        _snake_points[0]=newHeadPos;
        
        CCSprite *head=[_snake_sprites objectAtIndex:0];
        head.rotation=current_direction*90;
            
        return YES;
    }
}
-(Boolean)isKnockWall:(SPoint)newPos
{
    int max_col=[[World sharedWorld] maxCol];
    int max_row=[[World sharedWorld] maxRow];
    if(newPos.x>max_col || newPos.y>max_row || newPos.x<0 || newPos.y<0 )
    {
        return YES;
    }
    else
        return NO;
}
-(Boolean)isEatSelf:(SPoint)newPos
{
    for (int i = _current_length - 1; i > 0; i--) // 撞自己
    {
        if(newPos.x==_snake_points[i].x && newPos.y==_snake_points[i].y)
            return YES;
    }
    return NO;
}
-(Boolean)isClideWithAnotherSnake:(Snake *)anotherSnake andNewPosition:(SPoint)newPos
{
    SPoint *anotheSnakePoints = [anotherSnake getSnakePoints];
    int anotheSnakeLength = anotherSnake.current_length;
    
    for(int i = 0;i < anotheSnakeLength;i ++)
    {
        if([self isColide:anotheSnakePoints[i] b:newPos])
            return YES;
    }
    return NO;
}

-(float)distanceOfFood:(SPoint)foodPos andNewPostion:(SPoint)newPos
{
    return sqrtf((float)((foodPos.x-newPos.x)*(foodPos.x-newPos.x)+(foodPos.y-newPos.y)*(foodPos.y-newPos.y)));
}

#pragma mark private
-(BOOL)isColide:(SPoint)a b:(SPoint)b
{
    return ((a.x == b.x) && (a.y == b.y));
}
//-(Boolean)step:(SPoint)point andAnotherSnake:(Snake *)another
//{
//    newHeadPos=_snake_points[0];
//    int a=point.x-newHeadPos.x;
//    int b=point.y-newHeadPos.y;
//    
//    if(a<0 && b<0)  //1
//    {
//        switch (current_direction)
//        {
//            case UP:
//                current_direction=LEFT;
//                break;
//            case RIGHT:
//                current_direction=DOWN;
//                break;
//            case DOWN:
//                newHeadPos.y--;
//                if([self isClideWithAnotherSnake:another])
//                {
//                    current_direction = LEFT;
//                    newHeadPos.y++;
//                }
//                break;
//            case LEFT:
//                newHeadPos.x--;
//                if([self isClideWithAnotherSnake:another])
//                {
//                    current_direction = DOWN;
//                    newHeadPos.x++;
//                }
//                break;
//            default:
//                break;
//        }
//    }
//    else if(a>0 && b<0) //2
//    {
//        switch (current_direction)
//        {
//            case UP:
//                current_direction=RIGHT;
//                break;
//            case RIGHT:
//                newHeadPos.x++;
//                if([self isClideWithAnotherSnake:another])
//                {
//                    current_direction = DOWN;
//                    newHeadPos.x--;
//                }
//                break;
//            case DOWN:
//                newHeadPos.y--;
//                if([self isClideWithAnotherSnake:another])
//                {
//                    current_direction = RIGHT;
//                    newHeadPos.y++;
//                }
//                break;
//            case LEFT:
//                current_direction=DOWN;
//                break;
//            default:
//                break;
//        }
//    }
//    else if(a>0 && b>0) //3
//    {
//        switch (current_direction)
//        {
//            case UP:
//                newHeadPos.y++;
//                if([self isClideWithAnotherSnake:another])
//                {
//                    current_direction = RIGHT;
//                    newHeadPos.y--;
//                }
//                break;
//            case RIGHT:
//                newHeadPos.x++;
//                if([self isClideWithAnotherSnake:another])
//                {
//                    current_direction = UP;
//                    newHeadPos.x--;
//                }
//                break;
//            case DOWN:
//                current_direction=RIGHT;
//                break;
//            case LEFT:
//                current_direction=UP;
//                break;
//            default:
//                break;
//        }
//    }
//    else if(a<0 && b>0)  //4
//    {
//        switch (current_direction)
//        {
//            case UP:
//                newHeadPos.y++;
//                if([self isClideWithAnotherSnake:another])
//                {
//                    current_direction = LEFT;
//                    newHeadPos.y--;
//                }
//                break;
//            case RIGHT:
//                current_direction=UP;
//                break;
//            case DOWN:
//                current_direction=LEFT;
//                break;
//            case LEFT:
//                newHeadPos.x--;
//                if([self isClideWithAnotherSnake:another])
//                {
//                    current_direction = UP;
//                    newHeadPos.x++;
//                }
//                break;
//            default:
//                break;
//        }
//    }
//    else if(a<0 && b==0) //5
//    {
//        switch (current_direction)
//        {
//            case UP:
//                current_direction=LEFT;
//                break;
//            case RIGHT:
//                current_direction=UP;
//                break;
//            case DOWN:
//                current_direction=LEFT;
//                break;
//            case LEFT:
//                newHeadPos.x--;
//                if([self isClideWithAnotherSnake:another])
//                {
//                    current_direction = DOWN;
//                    newHeadPos.x++;
//                }
//                break;
//            default:
//                break;
//        }
//    }
//    else if(a==0 && b<0)  //6
//    {
//        switch (current_direction)
//        {
//            case UP:
//                current_direction=LEFT;
//                break;
//            case RIGHT:
//                current_direction=DOWN;
//                break;
//            case DOWN:
//                newHeadPos.y--;
//                if([self isClideWithAnotherSnake:another])
//                {
//                    current_direction = LEFT;
//                    newHeadPos.y++;
//                }
//                break;
//            case LEFT:
//                current_direction=DOWN;
//                break;
//            default:
//                break;
//        }
//    }
//    else if(a>0 && b==0)  //7
//    {
//        switch (current_direction)
//        {
//            case UP:
//                current_direction=RIGHT;
//                break;
//            case RIGHT:
//                newHeadPos.x++;
//                if([self isClideWithAnotherSnake:another])
//                {
//                    current_direction = DOWN;
//                    newHeadPos.x--;
//                }
//                break;
//            case DOWN:
//                current_direction=RIGHT;
//                break;
//            case LEFT:
//                current_direction=UP;
//                break;
//            default:
//                break;
//        }
//    }
//    else if(a==0 && b>0)
//    {
//        switch (current_direction)
//        {
//            case UP:
//                newHeadPos.y++;
//                if([self isClideWithAnotherSnake:another])
//                {
//                    current_direction = RIGHT;
//                    newHeadPos.y--;
//                }
//                break;
//            case RIGHT:
//                current_direction=UP;
//                break;
//            case DOWN:
//                current_direction=LEFT;
//                break;
//            case LEFT:
//                current_direction=UP;
//                break;
//            default:
//                break;
//        }
//    }
//
//    
//    lastPoint=_snake_points[_current_length-1];
//    
//    if([self isKnockWall])  // 撞墙
//        return NO;
//    
//    if([self isEatSelf]) // 撞自己
//        return NO;
//    
//    
//    for (int i = _current_length - 1; i > 0; i--)
//    {
//        _snake_points[i]=_snake_points[i-1];
//    }
//    _snake_points[0]=newHeadPos;
//    
//    CCSprite *head=[_snake_sprites objectAtIndex:0];
//    head.rotation=current_direction*90;
//    
//    return YES;
//    
//}

//-(Boolean)isKnockWall
//{
//    int max_col=[[World sharedWorld] maxCol];
//    int max_row=[[World sharedWorld] maxRow];
//    if(newHeadPos.x>max_col || newHeadPos.y>max_row || newHeadPos.x<0 || newHeadPos.y<0 )
//    {
//        return YES;
//    }
//    else
//        return NO;
//}
//-(Boolean)isEatSelf
//{
//    for (int i = _current_length - 1; i > 0; i--) // 撞自己
//    {
//        if(newHeadPos.x==_snake_points[i].x && newHeadPos.y==_snake_points[i].y)
//            return YES;
//    }
//    return NO;
//}

@end
