 //
//  TSFindeTasks.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/15/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSFindTasks.h"

#import "TSTask.h"
#import "TSRuleType.h"
#import "TSTaskRule.h"
#import "TSTasksForDate.h"
#import "TSUser.h"

#import "IDPActiveRecordKit.h"
#import "IDPCoreDataManager.h"
#import "IDPPropertyMacros.h"

#import "NSDate+IDPExtensions.h"
#import "NSDateComponents+IDPExtinsions.h"

@interface TSFindTasks ()

@end

@implementation TSFindTasks

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self cancel];
    
    [super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (void)setTaskForDate:(TSTasksForDate *)taskForDate {
    IDPNonatomicRetainPropertySynthesize(_taskForDate, taskForDate);
}

#pragma mark -
#pragma mark Public

- (void)findTasks {
    [self load];
}

- (BOOL)load {
    if (![super load]) {
        return NO;
    }

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        [self tasksInCurrentDataRange];
    });
    
    return YES;
}

- (void)cancel {
    self.taskForDate = nil;
    
    [super cancel];
}

#pragma mark -
#pragma mark Private

- (NSArray *)fetchTasks {
    TSUser *user = [TSUser managedObject];
//    NSManagedObjectContext *context = manager.managedObjectContext;
//    NSString *entetyName = NSStringFromClass([TSTask class]);
//    
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entetyName];
//    NSError *error;
//    
//    NSArray *tasks = [context executeFetchRequest:request error:&error];
////    [context release];
//    if (error) {
//        NSLog(@"Error : %@", error);
//        [self failLoading];
//        
//        return nil;
//    }
//
    NSArray *ruleTypes = user.rulesType;
    NSMutableArray *result = [NSMutableArray array];
    
    for (TSRuleType *ruleType in ruleTypes) {
        [result addObjectsFromArray:ruleType.tasks];
    }
    return result;
}

- (void)tasksInCurrentDataRange {
    TSTasksForDate *taskForDate = self.taskForDate;
    
    NSDate *startDate = taskForDate.startDatePeriod;
    NSDate *endDate = taskForDate.endDatePeriod;
    
    if (!startDate || !endDate) {
        [self failLoading];
        return;
    }
    
    NSMutableDictionary *tasksWithDates = [NSMutableDictionary dictionary];
    
    NSArray *tasks = [self fetchTasks];
    
    for (TSTask *task in tasks) {
        TSTaskRule *rule = [[TSTaskRule contextWithTask:task] retain];
        
        NSArray *dates = [[rule datesFromDate:startDate toDate:endDate] retain];
        
        for (NSDate *date in dates) {
            NSMutableArray *array = [tasksWithDates objectForKey:date];
            
            array = [NSMutableArray arrayWithArray:array];
            [array addObject:task];
            
            [tasksWithDates setObject:array forKey:date];
        }
        [dates release];
        [rule release];
    }
    
    [taskForDate setDatesWithTasks:tasksWithDates];
    
    [self finishLoading];
}

@end
