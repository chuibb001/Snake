//
//  LoadingScene.h
//  贪吃蛇
//
//  Created by simon on 13-8-17.
//  Copyright (c) 2013年 simon. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"
#import "GameLayer.h"

typedef enum
{
    TargetSceneTypeINVALID = 0,
    TargetSceneTypeMain
}
TargetSceneType;

@interface LoadingScene : CCScene
{
    TargetSceneType currentSceneType;
}

+(id)sceneWithTargetScene:(TargetSceneType)sceneType;

@end
