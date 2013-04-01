//
//  GameLayer.h
//  HelloWordGame
//
//  Created by simon on 13-4-1.
//  Copyright (c) 2013年 simon. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "Snake.h"
#import "World.h"
#import "Food.h"
@interface GameLayer : CCLayer
{
    Snake *snake;
    World *world;
    Food *food;
    
    NSInteger currentSpeed_;
    float accumulator;
}

+(id)scene;
@end
