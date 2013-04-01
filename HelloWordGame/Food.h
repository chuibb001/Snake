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


@interface Food : NSObject
{
    SPoint position;

}

- (CCSprite *)setUpFoodPiece;
- (SPoint)getFoodPosition;
@end
