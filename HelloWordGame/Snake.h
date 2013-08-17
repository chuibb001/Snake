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
#import "World.h"
typedef enum
{
    UP,
    RIGHT,
    DOWN,
    LEFT
} Direction;

@interface Snake : NSObject
{
    SPoint _snake_points[20];
    SPoint lastPoint;
    SPoint newHeadPos;
    NSMutableArray *_snake_sprites;
    int _current_length;
    int max_length;
    Direction current_direction;
}

@property (nonatomic,retain) NSMutableArray *snake_sprites;
@property (nonatomic,assign) int numberOfFoodEatten;
@property (nonatomic,assign) int current_length;
@property (nonatomic,assign) float speed;
@property (nonatomic,assign) float cumulation; // 时间的累积量,不用每一帧都update

-(CCSprite *)SpriteAtIndex:(int)index;
-(Boolean)step:(Snake *)another;
-(void)changeDirection:(CGPoint)point;
-(Boolean)canEatFood:(SPoint)point;
-(SPoint)positionOfSnakeAtIndex:(int)index;
// c数组getter
-(SPoint *)getSnakePoints;
-(Boolean)isClideWithAnotherSnake:(Snake *)anotherSnake;
@end
