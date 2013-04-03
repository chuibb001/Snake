//
//  World.h
//  HelloWordGame
//
//  Created by simon on 13-4-1.
//  Copyright (c) 2013年 simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface World : NSObject
{
    int width;
    int height;
}

+(World *)sharedWorld;
-(int)maxRow;
-(int)maxCol;
-(void)drawGameRect;
-(CGPoint)PointTranslation:(int)row :(int)col;

@end
