//
//  TSRuleType.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/14/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSRuleType.h"
#import "TSTask.h"
#import "TSUser.h"

#import "IDPActiveRecordKit.h"

static NSString * const kTSTasks = @"tasksSet";
static NSString * const kPredicate = @"ruleType == %@";

@implementation TSRuleType

@dynamic ruleType;
@dynamic tasks;
@dynamic tasksSet;
@dynamic user;

#pragma mark -
#pragma mark Class Methods

+ (id)managedObjectForKey:(NSString *)key {
    NSPredicate *predicate = nil;
    predicate = [NSPredicate predicateWithFormat:kPredicate, key];
    
    NSArray *array = [self fetchEntityWithSortDescriptors:nil
                                                predicate:predicate
                                            prefetchPaths:nil];
    
    TSRuleType *result = nil;
    
    if (0 != [array count]) {
        result = [array firstObject];
    } else {
        result = [super managedObject];
    }
    
    return  result;
}

#pragma mark -
#pragma mark Accessors

- (void)setTasks:(NSArray *)tasks {
    [self setCustomValue:[NSSet setWithArray:tasks]
                  forKey:NSStringFromSelector(@selector(tasks))];
}

- (NSArray *)tasks {
    NSSet *result = [self customValueForKey:NSStringFromSelector(@selector(tasksSet))];
    return [result allObjects];
}

- (void)addTask:(TSTask *)value {
    [self addCustomValue:value inMutableSetForKey:kTSTasks];
}

- (void)removeTask:(TSTask *)value {
    [value deleteManagedObject];
}

@end
