//
//  LoadingScene.m
//  贪吃蛇
//
//  Created by simon on 13-8-17.
//  Copyright (c) 2013年 simon. All rights reserved.
//

#import "LoadingScene.h"

@implementation LoadingScene

+(id)sceneWithTargetScene:(TargetSceneType)sceneType
{
    return [[[self alloc] initWithTargetScene:sceneType] autorelease];
}

-(id)initWithTargetScene:(TargetSceneType)sceneType
{
    if((self = [super init]))
    {
        currentSceneType = sceneType;
        
        CCLayerColor *whiteColoe = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
        [self addChild:whiteColoe];
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Loading..." fontName:@"Marker Felt" fontSize:64];
        CGSize size = [CCDirector sharedDirector].winSize;
        label.position = CGPointMake(size.width/2, size.height/2);
        label.color = ccc3(0, 0, 0);
        [self addChild:label];
        
        [self scheduleOnce:@selector(loadScene:) delay:0.0f];
    }
    return self;
}

-(void)loadScene:(ccTime)delta
{
    switch (currentSceneType) {
        case TargetSceneTypeMain:
            [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
            break;
            
        default:
            break;
    }
}

@end
