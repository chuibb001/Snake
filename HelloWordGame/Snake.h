//
//  Snake.h
//  HelloWordGame
//
//  Created by simon on 13-4-1.
//  Copyright (c) 2013年 simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constant.h"
typedef enum
{
    RIGHT,
    DOWN,
    LEFT,
    UP
} Direction;

@interface Snake : NSObject
{
    SPoint _snake_points[20];
    SPoint lastPoint;
    NSMutableArray *_snake_sprites;
    int current_length;
    int max_length;
    Direction current_direction;
}

@property (nonatomic,retain) NSMutableArray *snake_sprites;

-(CCSprite *)SpriteAtIndex:(int)index;
-(void)step;
-(void)changeDirection:(CGPoint)point;
-(Boolean)canEatFood:(SPoint)point;
-(Boolean)isEatSelf;
-(Boolean)isClideWithAnotherSnake;
-(SPoint)positionOfSnakeAtIndex:(int)index;
@end
