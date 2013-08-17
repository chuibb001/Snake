//
//  AutoSnake.h
//  HelloWordGame
//
//  Created by simon on 13-4-2.
//  Copyright (c) 2013年 simon. All rights reserved.
//

#import "Snake.h"

@interface AutoSnake : Snake

-(Boolean)step:(SPoint)point andAnotherSnake:(Snake *)another;

@end
