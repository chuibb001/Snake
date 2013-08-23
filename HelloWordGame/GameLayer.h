//
//  GameLayer.h
//  HelloWordGame
//
//  Created by simon on 13-4-1.
//  Copyright (c) 2013年 simon. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "AutoSnake.h"
#import "Snake.h"
#import "World.h"
#import "Food.h"
#import "AutoSnakeV2.h"
typedef enum
{
    SnakeGetPoint = 0,
    SnakeLosePoint,
    AutoSnakeGetPoint,
    AutoSnakeLosePoint,
}GameScoreType;

@interface GameLayer : CCLayer
{
    Snake *snake;
    AutoSnakeV2 *autoSnake;
    World *world;
    Food *food;
        
    Boolean pause;
    
    float timeLeft;
    
    CCMenuItemFont *snake_score;
    CCMenuItemFont *autosnake_score;
    
    int snakeScore;
    int autoSnakeScore;
}

+(id)scene;
@end
