//
//  AutoSnakeV2.h
//  贪吃蛇
//
//  Created by yan simon on 13-8-22.
//  Copyright (c) 2013年 simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Snake.h"

@interface Node : NSObject

@property (nonatomic ,assign) SPoint position;
@property (nonatomic ,assign) double fValue;
@property (nonatomic ,assign) double gValue;
@property (nonatomic ,retain) Node *parent;

@end

@interface AutoSnakeV2 : Snake

-(Boolean)step:(SPoint)point andAnotherSnake:(Snake *)another;

@property (nonatomic ,assign) Snake *anotherSnake;
@property (nonatomic ,assign) SPoint foodPos;
// A*
@property (nonatomic ,retain) NSMutableArray *openList;
@property (nonatomic ,retain) NSMutableArray *closeList;
@property (nonatomic ,retain) Node *origineNode;
@property (nonatomic ,retain) Node *goalNode;

@end
