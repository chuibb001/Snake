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
        food_count=100;
    }
    return self;
}

- (CCSprite *)setUpFoodSprite:(Snake *)snake autoS:(Snake *)autoSnake {
    
    foodSprite=[CCSprite spriteWithFile:@"food@2x.png"];
    
    NSInteger col = 0;
    NSInteger row = 0;
    
    int max_col=[[World sharedWorld] maxCol];
    int max_row=[[World sharedWorld] maxRow];
    
    while (true)
    {
        col = rand() % max_col;
        row = rand() % max_row;
        
        // 与蛇的位置冲突
        if((![self clideWithSnake:snake col:col row:row] && ![self clideWithSnake:autoSnake col:col row:row]))
        {
            break;
        }
    }
    //foodSprite.position = CGPointMake(38 + col * 20, 49 + row * 20);
    
    foodSprite.position=[[World sharedWorld] PointTranslation:col :row];
    position.x=col;
    position.y=row;
    //NSLog(@"食物(%d,%d)",col,row);
    
    return  foodSprite;
}
-(BOOL)clideWithSnake:(Snake *)snake col:(int)col row:(int)row
{
    int count = snake.current_length;
    SPoint *body = [snake getSnakePoints];
    for(int i = 0;i<count ;i++)
    {
        SPoint s = body[i];
        if(((col == s.x )&&(row == s.y)))
            return YES;
    }
    return NO;
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
