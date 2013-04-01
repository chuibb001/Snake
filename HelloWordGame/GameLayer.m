//
//  GameLayer.m
//  HelloWordGame
//
//  Created by simon on 13-4-1.
//  Copyright (c) 2013年 simon. All rights reserved.
//

#import "GameLayer.h"
#define MAX_SPEED   10
#define BASE_SPEED  0.2

@implementation GameLayer

+(id)scene
{
    CCScene *scene=[CCScene node];
    GameLayer *layer=[GameLayer node];
    [scene addChild:layer];
    return scene;
}

-(id)init;
{
    if(self=[super init])
    {
        snake=[[Snake alloc] init];
        world=[[World alloc] init];
        food=[[Food alloc] init];
        self.touchEnabled=YES;
        [self scheduleUpdate];  // 每帧执行一次update和draw
        [self drawFood];
    }
    return self;
}

-(void)update:(ccTime)delta
{
    accumulator += delta;
    float speedStep = BASE_SPEED - BASE_SPEED/MAX_SPEED * currentSpeed_;
        while (accumulator >= speedStep) {
            [snake step];
            [snake canEatFood:[food getFoodPosition]];
            accumulator -= speedStep;
        }
    
}

-(void)draw
{
    // 游戏区线框

    [world drawGameRect];
    
    // 绘制蛇
    for(int i=0;i<[[snake snake_sprites] count];i++)
    {
        CCSprite *sprite=[[snake snake_sprites] objectAtIndex:i];
        SPoint point=[snake positionOfSnakeAtIndex:i];
        sprite.position=CGPointMake(38 + point.x * 20, 49 + point.y * 20); // 把行列坐标转换成全局CGPoint
        if (![sprite parent])
        {
            [self addChild:sprite];
        }       
    }
    
}
-(void)drawFood
{
    CCSprite *foodSprite=[food setUpFoodPiece];
    [self addChild:foodSprite];
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [self convertTouchToNodeSpace:touch];
    [snake changeDirection:p];
}
@end
