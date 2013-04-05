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
@interface GameLayer : CCLayer
{
    Snake *snake;
    AutoSnake *autoSnake;
    World *world;
    Food *food;
    
    float currentSpeed;
    float cumulation;
    
    Boolean pause;
    
    float timeLeft;
    
    CCMenuItemFont *snake_score;
    CCMenuItemFont *autosnake_score;
}

+(id)scene;
@end
