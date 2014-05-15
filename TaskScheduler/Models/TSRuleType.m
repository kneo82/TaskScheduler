//
//  TSRuleType.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/14/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSRuleType.h"
#import "TSTask.h"

#import "IDPActiveRecordKit.h"

static NSString * const kTSTasks = @"tasksSet";

@implementation TSRuleType

@dynamic ruleType;
@dynamic tasks;
@dynamic tasksSet;

#pragma mark -
#pragma mark Class Methods

#pragma mark -
#pragma mark Accessors

- (void)setTasks:(NSArray *)tasks {
    [self setCustomValue:[NSSet setWithArray:tasks]
                  forKey:NSStringFromSelector(@selector(tasks))];
}

- (NSArray *)tasks {
    NSSet *result = [self customValueForKey:NSStringFromSelector(@selector(tasks))];
    return [result allObjects];
}

- (void)addTask:(TSTask *)value {
    [self addCustomValue:value inMutableSetForKey:kTSTasks];
}

- (void)removeTask:(TSTask *)value {
    [value deleteManagedObject];
}

@end
