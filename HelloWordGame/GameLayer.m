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
        autoSnake=[[AutoSnake alloc] init];
        world=[[World alloc] init];
        food=[[Food alloc] init];
        currentSpeed=1;
        self.touchEnabled=YES;
        [self scheduleUpdate];  // 每帧执行一次update和draw
        [self drawFood];
    }
    return self;
}

#pragma mark 游戏进程
-(void)gameOver
{
    [self unscheduleAllSelectors];
    [self showLabel:@"游戏结束"];

}
-(void)gameWin
{
    [self unscheduleAllSelectors];
    [self showLabel:@"游戏胜利"];
    
}
-(void)showLabel:(NSString *)name
{
    CCLabelTTF *gameOverLabel = [CCLabelTTF labelWithString:name fontName:@"Helvetica" fontSize:20.f];
    gameOverLabel.color=ccc3(255, 255, 255);
    gameOverLabel.position = ccp(31, 15);
    gameOverLabel.anchorPoint = ccp(0.0, 0.5);
    
    CGSize size=[[CCDirector sharedDirector] winSize];
    gameOverLabel.position=ccp(size.width/2, size.height/2);
    gameOverLabel.anchorPoint=ccp(0.5, 0.5);
    
    [self addChild:gameOverLabel];
    
    id rotate=[CCRotateBy actionWithDuration:1 angle:360];
    id ease=[CCEaseInOut actionWithAction:rotate rate:3];
    id grow = [CCScaleTo actionWithDuration:.4f scale:2.0f];
    id shrink = [CCScaleTo actionWithDuration:.3f scale:1.0f];
    id sequence=[CCSequence actions:ease,grow,shrink, nil];
    
    [gameOverLabel runAction:sequence];
}

#pragma mark 刷新
-(void)update:(ccTime)delta
{
    cumulation += delta;
    float base = BASE_SPEED - BASE_SPEED/MAX_SPEED * currentSpeed;
        while (cumulation >= base)
        {
            //Boolean canStep=[snake step];
            Boolean canStep=[autoSnake step:[food getFoodPosition]];
            if(canStep==NO)
               [self gameOver];
            else
            {
                Boolean caneat=[autoSnake canEatFood:[food getFoodPosition]];
                if(caneat)
                {
                    [self cleanFood];
                    [self drawFood];
                    [food decreaseFoodCount];
                    if([food isFoodRemaining])
                        [self gameWin];
                    currentSpeed=currentSpeed+0.6;
                }
            }
            
            cumulation =0;
        }
    
}

-(void)draw
{
    [world drawGameRect];
    [self drawSnake];
    [self drawAutoSnake];
}

#pragma mark 蛇
-(void)drawSnake
{
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
-(void)drawAutoSnake
{
    for(int i=0;i<[[autoSnake snake_sprites] count];i++)
    {
        CCSprite *sprite=[[autoSnake snake_sprites] objectAtIndex:i];
        SPoint point=[autoSnake positionOfSnakeAtIndex:i];
        sprite.position=CGPointMake(38 + point.x * 20, 49 + point.y * 20); // 把行列坐标转换成全局CGPoint
        if (![sprite parent])
        {
            [self addChild:sprite];
        }
    }
}
#pragma mark 食物
-(void)drawFood
{
    CCSprite *foodSprite=[food setUpFoodSprite];
    [self addChild:foodSprite];
}
-(void)cleanFood
{
    CCSprite *foodSprite=[food currentSprite];
    [foodSprite removeFromParentAndCleanup:YES];
}

#pragma mark 触摸
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [self convertTouchToNodeSpace:touch];
    [snake changeDirection:p];
}
@end
