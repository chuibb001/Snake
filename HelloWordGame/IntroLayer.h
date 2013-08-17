//
//  IntroLayer.h
//  HelloWordGame
//
//  Created by simon on 13-3-31.
//  Copyright simon 2013年. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "GameLayer.h"
#import "LoadingScene.h"

// HelloWorldLayer
@interface IntroLayer : CCLayer
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
