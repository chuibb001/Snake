//
//  GameLayer.m
//  HelloWordGame
//
//  Created by simon on 13-4-1.
//  Copyright (c) 2013年 simon. All rights reserved.
//

#import "GameLayer.h"

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
        world=[World sharedWorld];
        food=[[Food alloc] init];
        
        self.touchEnabled=YES;
        pause=NO;
        timeLeft=3.0;
        
        [self addChild:[world gameBackgroundSprite] z:-1];
        
        [self drawFood];
        [self setLabels];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timePass:) userInfo:nil repeats:YES];
        
    }
    return self;
}

-(void)timePass:(NSTimer *)timer
{
    [self showTimeLabel:[NSString stringWithFormat:@"%d",(int)timeLeft]];
    timeLeft=timeLeft-1;
    if(timeLeft==0)
    {
        [self scheduleUpdate];  // 每帧执行一次update和draw
        [timer invalidate];
    }
}
-(void)showTimeLabel:(NSString *)s
{
    CCLabelTTF *timeLabel = [CCLabelTTF labelWithString:s fontName:@"Helvetica" fontSize:20.f];
    [timeLabel setColor:ccc3(25, 25, 25)];
    CGSize size=[[CCDirector sharedDirector] winSize];
    timeLabel.position=ccp(size.width/2, size.height/2);
    timeLabel.anchorPoint=ccp(0.5, 0.5);
    
    [self addChild:timeLabel];
    
    //id rotate=[CCRotateBy actionWithDuration:0.1 angle:360];
    //id ease=[CCEaseInOut actionWithAction:rotate rate:3];
    id grow = [CCScaleTo actionWithDuration:.3f scale:2.0f];
    id shrink = [CCScaleTo actionWithDuration:.3f scale:0.0f];
    id fadeout=[CCFadeOut actionWithDuration:0.1];
    id sequence=[CCSequence actions:grow,shrink, nil];
    
    [timeLabel runAction:sequence];
    if([sequence isDone])
       [timeLabel removeFromParentAndCleanup:YES];
}
#pragma mark 菜单
-(void)setLabels
{
    CCMenuItemFont *pauses=[CCMenuItemFont itemWithString:@"pause " target:self selector:@selector(pause)];
    CCMenuItemFont *restart=[CCMenuItemFont itemWithString:@"restart" target:self selector:@selector(restart)];
    [pauses setFontSize:20.0];
    [pauses setColor:ccc3(25, 25, 25)];
    [restart setFontSize:20.0];
    [restart setColor:ccc3(25, 25, 25)];
    CCMenu *menu=[CCMenu menuWithItems:pauses,restart, nil];
    [self addChild:menu];
    menu.position=ccp([[CCDirector sharedDirector] winSize].width-100, 305);
    [menu alignItemsHorizontally];
    
    snake_score=[CCMenuItemFont itemWithString:@"snake:0"];
    autosnake_score=[CCMenuItemFont itemWithString:@"autoSnake:0"];
    [snake_score setFontSize:16.0];
    [autosnake_score setFontSize:16.0];
    [snake_score setColor:ccc3(25, 25, 25)];
    [autosnake_score setColor:ccc3(25, 25, 25)];
    CCMenu *menu1=[CCMenu menuWithItems:snake_score,autosnake_score, nil];
    menu1.position=ccp(100, 15);
    [menu1 alignItemsHorizontally];
    [self addChild:menu1];
    
}
-(void)setSnakeScore:(int)score
{
    NSString *string=[NSString stringWithFormat:@"snake:%d",score];
    [snake_score setString:string];
}
-(void)setAutoSnakeScore:(int)score
{
    NSString *string=[NSString stringWithFormat:@"autoSnake:%d",score];
    [autosnake_score setString:string];
}

-(void)pause
{
    if(pause==NO)
    {
        [self pauseSchedulerAndActions];
        pause=YES;
    }
    else
    {
        [self resumeSchedulerAndActions];
        pause=NO;
    }
}
-(void)restart
{
    [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
}

#pragma mark 游戏进程
-(void)gameOver
{
    [self unscheduleAllSelectors];
    [self showLabel:@"Game Over!"];

}
-(void)gameWin
{
    [self unscheduleAllSelectors];
    [self showLabel:@"You Win!"];
    
}
-(void)decideWhoWin
{
    if(snake.numberOfFoodEatten>autoSnake.numberOfFoodEatten)
       [self gameWin];
    else
        [self gameOver];
}
-(void)showLabel:(NSString *)name
{
    CCLabelTTF *gameOverLabel = [CCLabelTTF labelWithString:name fontName:@"Helvetica" fontSize:20.f];
    gameOverLabel.color=ccc3(25, 25, 25);
    gameOverLabel.position = ccp(31, 15);
    gameOverLabel.anchorPoint = ccp(0.0, 0.5);
    
    [gameOverLabel setFontSize:25.0];
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
-(void)update:(ccTime)delta // 每一帧都调用,delta表示上一次调用后过去的时间,现在是1/30
{   
    snake.cumulation += delta;
    autoSnake.cumulation += delta;
    
    // 加速变量
    float snakeBase = BASE_SPEED - BASE_SPEED/MAX_SPEED * snake.speed;
    float autoSnakeBase = BASE_SPEED - BASE_SPEED/MAX_SPEED * autoSnake.speed;
    
    // 计算玩家蛇
    if(snake.cumulation >=snakeBase)
    {
        if(![snake step:autoSnake])
            [self gameOver];
        else
        {
            if([snake canEatFood:[food getFoodPosition]])
            {
                [self cleanFood];  // 清除食物并绘制新食物
                [self drawFood];
                [food decreaseFoodCount];
                snake.numberOfFoodEatten++;
                [self setSnakeScore:snake.numberOfFoodEatten];
                // 食物吃完了，判断谁赢
                if([food isFoodRemaining])
                    [self decideWhoWin];
                
                snake.speed += 0.6;
            }
        }
        snake.cumulation = 0.0;
    }
    
    // 计算自动蛇
    if(autoSnake.cumulation >=autoSnakeBase)
    {
        if(![autoSnake step:[food getFoodPosition] andAnotherSnake:snake])
            [self gameOver];
        else
        {
            if([autoSnake canEatFood:[food getFoodPosition]])
            {
                [self cleanFood];  // 清除食物并绘制新食物
                [self drawFood];
                [food decreaseFoodCount];
                autoSnake.numberOfFoodEatten++;
                [self setSnakeScore:autoSnake.numberOfFoodEatten];
                // 食物吃完了，判断谁赢
                if([food isFoodRemaining])
                    [self decideWhoWin];
                
                autoSnake.speed += 0.6;
            }
        }
        autoSnake.cumulation = 0.0;
    }
    
}

-(void)draw
{
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
        //sprite.position=CGPointMake(38 + point.x * 20, 49 + point.y * 20); // 把行列坐标转换成全局CGPoint
        sprite.position=[world PointTranslation:point.x :point.y];
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
        //sprite.position=CGPointMake(38 + point.x * 20, 49 + point.y * 20); // 把行列坐标转换成全局CGPoint
        sprite.position=[world PointTranslation:point.x :point.y];
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
