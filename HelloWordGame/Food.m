//
//  Food.m
//  HelloWordGame
//
//  Created by simon on 13-4-1.
//  Copyright (c) 2013年 simon. All rights reserved.
//

#import "Food.h"

@implementation Food

-(id)init
{
    self=[super init];
    if(self)
    {
        srand ( time(NULL) );
    }
    return self;
}

- (CCSprite *)setUpFoodPiece {
    
    CCSprite *food=[CCSprite spriteWithFile:@"Icon.png"];
    
    NSInteger col = 0;
    NSInteger row = 0;
    
    //while (true)
    //{
        col = rand() % MAX_COLS;
        row = rand() % MAX_ROWS;
    //}
    food.position = CGPointMake(38 + col * 20, 49 + row * 20);
    position.x=col;
    position.y=row;
    return  food;
}
-(SPoint) getFoodPosition
{
    return position;
}

@end
