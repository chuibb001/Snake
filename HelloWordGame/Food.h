//
//  Food.h
//  HelloWordGame
//
//  Created by simon on 13-4-1.
//  Copyright (c) 2013年 simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constant.h"
#import "World.h"
#import "Snake.h"
@interface Food : NSObject
{
    SPoint position;
    CCSprite *foodSprite;
    int food_count;
}

- (CCSprite *)setUpFoodSprite:(Snake *)snake autoS:(Snake *)autoSnake;
- (SPoint)getFoodPosition;
- (CCSprite *)currentSprite;
- (void)decreaseFoodCount;
- (Boolean)isFoodRemaining;
@end
