//
//  AutoSnakeV2.m
//  贪吃蛇
//
//  Created by yan simon on 13-8-22.
//  Copyright (c) 2013年 simon. All rights reserved.
//

#import "AutoSnakeV2.h"

@implementation Node

@end


@implementation AutoSnakeV2
- (id)init
{
    self = [super init];
    if (self) {
        max_length=20;
        _current_length=3;
        current_direction=LEFT;
        self.numberOfFoodEatten = 0;
        _snake_sprites=[[NSMutableArray alloc] init];
        for(int i=0;i<_current_length;i++)
        {
            CCSprite *sprite=[self SpriteAtIndex:i];
            [_snake_sprites addObject:sprite];
            SPoint point;
            point.x=18+i;
            point.y=11;
            _snake_points[i]=point;
            self.speed = 1.0f;
        }
        CCSprite * head= [_snake_sprites objectAtIndex:0];
        head.rotation=270;
        
        // A*
        self.openList = [[[NSMutableArray alloc] init] autorelease];
        self.closeList = [[[NSMutableArray alloc] init] autorelease];
        self.origineNode = [[[Node alloc] init] autorelease];
        self.goalNode = [[[Node alloc] init] autorelease];
        
    }
    return self;
}

-(CCSprite *)SpriteAtIndex:(int)index
{
    CCSprite *sprite;
    if(index==0)
        sprite=[CCSprite spriteWithFile:@"snake_green_head@2x.png"];
    else if(index%2==0)
        sprite=[CCSprite spriteWithFile:@"snake_green_light@2x.png"];
    else
        sprite=[CCSprite spriteWithFile:@"snake_green_dark@2x.png"];
    return sprite;
}

-(Boolean)step:(SPoint)point andAnotherSnake:(Snake *)another
{
    //NSLog(@"--------------Step-------------");
    // clear data
    [self.openList removeAllObjects];
    [self.closeList removeAllObjects];
    
    // init data
    newHeadPos = _snake_points[0];
    self.origineNode.position = newHeadPos;
    self.origineNode.fValue = 0;
    self.origineNode.gValue = 0;
    self.origineNode.parent = nil;
    
    self.goalNode.position = point;
    self.goalNode.fValue = 0;
    self.goalNode.gValue = 0;
    self.goalNode.parent = nil;
    
    [self.openList addObject:self.origineNode];
    
    self.anotherSnake = another;
    
    self.foodPos = point;
    
    Node *minNode = [self Process];
    
    if(!minNode)
        return NO;
    else
    {
        Node *findNode = minNode;
        while (minNode.parent) {
            findNode = minNode;
            minNode = minNode.parent;
            
        }
        
        newHeadPos = findNode.position;
        lastPoint=_snake_points[_current_length-1];
        for (int i = _current_length - 1; i > 0; i--)
        {
            _snake_points[i]=_snake_points[i-1];
        }
        _snake_points[0]=newHeadPos;
        
        CCSprite *head=[_snake_sprites objectAtIndex:0];
        head.rotation=current_direction*90;
        
        return YES;
    }
    
}

#pragma mark A - star 算法
- (Node *)Process
{
    while (1) {
        if([self.openList count] == 0)  // open表为空，失败退出
        {
            //NSLog(@"open表为空，失败退出");
            return nil;
        }
        Node *minNode = [self minNodeInOpenList]; // 从open表中取出f值最小的节点
        [self putIntoCloseList:minNode];  // 把节点放到close表中
        if([self isNodeEqualToGoal:minNode])  // 当前节点就是目标节点了
            return minNode;
        if(![self Spread:minNode])  // 扩展当前节点
        {
            //NSLog(@"无路可走，失败退出");
            return nil;
        }
    }
}

-(Node *)minNodeInOpenList  // 返回open表中f值最小的节点，并将其移除
{
    Node *min = [self.openList objectAtIndex:0];
    int minIndex = 0;
    int count = [self.openList count];
    //NSLog(@"当前open表:");
    //NSLog(@"(%d，%d)",min.position.x,min.position.y);
    for(int i = 1;i<count;i++)
    {
        Node *tmp = [self.openList objectAtIndex:i];
        //NSLog(@"(%d，%d)",tmp.position.x,tmp.position.y);
        if(tmp.fValue < min.fValue)
        {
            min = tmp;
            minIndex = i;
        }
    }
    Node *returnNode = [min retain];
    [self.openList removeObjectAtIndex:minIndex];
    
    return [returnNode autorelease];
}

-(void)putIntoCloseList:(Node *)node
{
    [self.closeList addObject:node];
}

-(BOOL)isNodeEqualToGoal:(Node *)node
{
    return ((node.position.x == self.goalNode.position.x) &&(node.position.y == self.goalNode.position.y));
}

-(BOOL)isTwoNodeEqual:(Node *)node1 andNode:(Node *)node2
{
    return ((node1.position.x == node2.position.x) &&(node1.position.y == node2.position.y));
}

-(BOOL)Spread:(Node *)node
{
    // 生成新的4个位置
    SPoint newS1;
    SPoint newS2;
    SPoint newS3;
    SPoint newS4;
    newS1.x = node.position.x - 1; newS1.y = node.position.y;
    newS2.x = node.position.x + 1; newS2.y = node.position.y;
    newS3.x = node.position.x; newS3.y = node.position.y -1;
    newS4.x = node.position.x; newS4.y = node.position.y +1;
    SPoint sArray[4] = {newS1,newS2,newS3,newS4}; // 放进一个数组好使用
    
    Node *child; // 子节点
    
    int availableCount = 0;
    
    for(int i = 0;i<4;i++)
    {
        if(![self isKnockWall:sArray[i]] && ![self isEatSelf:sArray[i]] && ![self isClideWithAnotherSnake:self.anotherSnake andNewPosition:sArray[i]]) // 合理位置
        {
            availableCount ++;
            child = [[Node alloc] init];
            child.position = sArray[i];
            child.gValue = node.gValue + 1;
            child.parent = node;
            if([self isChildBelongToList:child])
                ;
            [child release];
        }
    }
    if(availableCount == 0)
        return NO;
    else
        return YES;
}

-(BOOL)isChildBelongToList:(Node *)child
{
    BOOL isBelong = NO;
    
    Node *temp = nil;
    if([self isChildBelongToOpenList:child] || [self isChildBelongToCloseList:child])// 该子节点在open表或者close表
    {
        if([self isChildBelongToOpenList:child])
            temp = [self isChildBelongToOpenList:child];
        else
            temp = [self isChildBelongToCloseList:child];
        if(child.gValue < temp.gValue)
        {
            temp.gValue = child.gValue;
            temp.fValue = child.fValue;
            temp.parent = child.parent;
            isBelong = YES;
        }
    }
    else  // 计算其F值并加入open表
    {
        [self.openList addObject:child];
        child.fValue = [self distanceOfFood:self.foodPos andNewPostion:child.position] + child.gValue;
    }
    return isBelong;
}

-(Node *)isChildBelongToOpenList:(Node *)child
{
    for(Node *node in self.openList)
    {
        if([self isTwoNodeEqual:child andNode:node])
            return node;
    }
    return nil;
}

-(Node *)isChildBelongToCloseList:(Node *)child
{
    for(Node *node in self.closeList)
    {
        if([self isTwoNodeEqual:child andNode:node])
            return node;
    }
    return nil;
}
-(Boolean)isKnockWall:(SPoint)newPos
{
    int max_col=[[World sharedWorld] maxCol];
    int max_row=[[World sharedWorld] maxRow];
    if(newPos.x>max_col || newPos.y>max_row || newPos.x<0 || newPos.y<0 )
    {
        return YES;
    }
    else
        return NO;
}
-(Boolean)isEatSelf:(SPoint)newPos
{
    for (int i = _current_length - 1; i > 0; i--) // 撞自己
    {
        if(newPos.x==_snake_points[i].x && newPos.y==_snake_points[i].y)
            return YES;
    }
    return NO;
}
-(Boolean)isClideWithAnotherSnake:(Snake *)anotherSnake andNewPosition:(SPoint)newPos
{
    SPoint *anotheSnakePoints = [anotherSnake getSnakePoints];
    int anotheSnakeLength = anotherSnake.current_length;
    
    for(int i = 0;i < anotheSnakeLength;i ++)
    {
        if([self isColide:anotheSnakePoints[i] b:newPos])
            return YES;
    }
    return NO;
}

-(float)distanceOfFood:(SPoint)foodPos andNewPostion:(SPoint)newPos
{
    return sqrtf((float)((foodPos.x-newPos.x)*(foodPos.x-newPos.x)+(foodPos.y-newPos.y)*(foodPos.y-newPos.y)));
}

#pragma mark private
-(BOOL)isColide:(SPoint)a b:(SPoint)b
{
    return ((a.x == b.x) && (a.y == b.y));
}
@end
