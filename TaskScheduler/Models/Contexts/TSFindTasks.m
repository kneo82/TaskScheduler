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

#import "IDPActiveRecordKit.h"
#import "IDPCoreDataManager.h"

#import "NSDate+IDPExtensions.h"

@interface TSFindTasks ()
@property (nonatomic, retain)   NSMutableDictionary  *tasks;

@end

@implementation TSFindTasks

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.startDate = nil;
    self.endDate = nil;
    self.tasks = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (void)findTasks {
//    [self fetchTasks];
    TSRuleType *ruleOnceDay = [TSRuleType managedObject];
    ruleOnceDay.ruleType = @"TSRuleOnceDay";
    
    TSRuleType *ruleOnceMonth = [TSRuleType managedObject];
    ruleOnceMonth.ruleType = @"TSRuleOnceNonth";
    
    TSRuleType *ruleOnceWeek = [TSRuleType managedObject];
    ruleOnceWeek.ruleType = @"TSRuleOnceWeek";
    
    TSRuleType *ruleOnceYear = [TSRuleType managedObject];
    ruleOnceYear.ruleType = @"TSRuleOnceYear";
    
    TSTask *task1 = [TSTask managedObject];
    task1.date = [NSDate date];
    
    [ruleOnceDay addTask:task1];
    
    TSTask *task2 = [TSTask managedObject];
    task2.date =  [task1.date dateByAddingTimeInterval:-10*24*60*60];
    
    [ruleOnceDay addTask:task2];
    
    TSTask *task3 = [TSTask managedObject];
    task3.date =  task2.date;
    [ruleOnceWeek addTask:task3];

    
    TSTaskRule *task = [TSTaskRule contextWithTask:task2] ;
    NSLog(@"Current day %@", [task1.date dateToStringWithFormat:@"dd/MM/yyyy"]);
    
    NSArray *array = [task datesFromDate:task1.date toDate:[task1.date dateByAddingTimeInterval:10*24*60*60]];
    NSLog(@"Count dates = %d", array.count);
}

#pragma mark -
#pragma mark Private

- (NSArray *)fetchTasks {
    IDPCoreDataManager *manager = [IDPCoreDataManager sharedManager];
    NSManagedObjectContext *context = manager.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([TSTask class])];
    NSError *error;
    
    NSArray *tasks = [context executeFetchRequest:request error:&error];
    
    if (!error) {
        NSLog(@"Work with Task");
    } else {
        NSLog(@"Error : %@", error);
    }
    
    return tasks;
}

@end
