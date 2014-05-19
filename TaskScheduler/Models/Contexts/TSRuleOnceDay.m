//
//  TSRuleOnceDay.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/15/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSRuleOnceDay.h"
#import "TSTask.h"
#import "TSRuleType.h"

#import "NSDate+IDPExtensions.h"
#import "NSDateComponents+IDPExtinsions.h"

@implementation TSRuleOnceDay

#pragma mark -
#pragma mark Public

- (NSDate *)nextDate {
    NSDate *currentDate = self.currentDate;
    NSDate *taskDate = [self.task.date midnightDate];
    
    if (NSOrderedAscending == [currentDate compare:taskDate]) {
        self.currentDate = taskDate;
        
        return taskDate;
    }
    
    NSDateComponents *components = [currentDate components:kTSRunitFlags];
    components.day++;
    
    NSDate *dateNext = [components dateFromComponents];
    self.currentDate = dateNext;

    return dateNext;
}

- (NSDate *)previousDate {
    
    NSDateComponents *components = [self.currentDate components:kTSRunitFlags];
    components.day--;
    
    NSDate *datePreview = [components dateFromComponents];
    NSDate *taskDate = [self.task.date midnightDate];
    
    if (NSOrderedAscending == [datePreview compare:taskDate]) {
        self.currentDate = taskDate;
        
        return nil;
    }
    
    self.currentDate = datePreview;
    
    return datePreview;
}

@end
