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
        food_count=10;
    }
    return self;
}

- (CCSprite *)setUpFoodSprite {
    
    foodSprite=[CCSprite spriteWithFile:@"food.png"];
    
    NSInteger col = 0;
    NSInteger row = 0;
    
    //while (true)
    //{
        col = rand() % MAX_COLS;
        row = rand() % MAX_ROWS;
    //}
    foodSprite.position = CGPointMake(38 + col * 20, 49 + row * 20);
    position.x=col;
    position.y=row;
    return  foodSprite;
}
-(SPoint) getFoodPosition
{
    return position;
}

- (CCSprite *)currentSprite
{
    return foodSprite;
}
- (void)decreaseFoodCount
{
    food_count--;
}
- (Boolean)isFoodRemaining
{
    return food_count==0;
}
@end
