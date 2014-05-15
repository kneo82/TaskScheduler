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
#import "IDPActiveRecordKit.h"
#import "IDPCoreDataManager.h"

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
    [self fetchTasks];
}

#pragma mark -
#pragma mark Private

- (NSArray *)fetchTasks {
    IDPCoreDataManager *manager = [IDPCoreDataManager sharedManager];
    NSManagedObjectContext *context = manager.managedObjectContext;
    
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([TSTask class])];
    
    NSArray *tasks = [context executeFetchRequest:request error:nil];
    
    TSTask *task1 = tasks[0];
    NSDate *date = task1.date;
    
    NSLog(@"%@", task1.ruleType.ruleName);
    
    return tasks;
}

@end
