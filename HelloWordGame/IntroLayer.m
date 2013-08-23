//
//  IntroLayer.m
//  HelloWordGame
//
//  Created by simon on 13-3-31.
//  Copyright simon 2013年. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

//
-(id) init
{
	if( (self=[super init]))
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCLayerColor *backgroundColor=[CCLayerColor layerWithColor:ccc4(193, 219, 236, 255)];
        [self addChild:backgroundColor z:-1];
        
        CCSprite *intro=[CCSprite spriteWithFile:@"coverLabal@2x.png"];
        intro.position=ccp(size.width/2, size.height/2 + 100);
        [self addChild:intro];
        
        CCMenuItemImage *playItem=[CCMenuItemImage itemWithNormalImage:@"playButton@2x.png" selectedImage:@"playButton@2x.png" target:self selector:@selector(Play)];
        
        
        CCMenu *menu = [CCMenu menuWithItems:playItem,nil];
        menu.position=ccp(size.width/2,size.height/2 - 20);
        [self addChild:menu];
    }
	
	return self;
}

-(void)Play
{
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameLayer scene] ]];
    [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneTypeMain]];
    
}
-(void) onEnter
{
	[super onEnter];
	
}
@end
