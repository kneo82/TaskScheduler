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
#import "NSDateComponents+IDPExtinsions.h"

@interface TSFindTasks ()
@property (nonatomic, assign) __block id weakSelf;// = self;
@end

@implementation TSFindTasks

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    NSLog(@"Dealloc");
    [self cancel];
    
    [super dealloc];
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
    self.startDate = nil;
    self.endDate = nil;
    self.tasksWithDates = nil;
    
    [super cancel];
}

#pragma mark -
#pragma mark Private

- (NSArray *)fetchTasks {
    IDPCoreDataManager *manager = [IDPCoreDataManager sharedManager];
    NSManagedObjectContext *context = manager.managedObjectContext;
    NSString *entetyName = NSStringFromClass([TSTask class]);
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entetyName];
    NSError *error;
    
    NSArray *tasks = [context executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"Error : %@", error);
        [self failLoading];
        
        return nil;
    }
    
    return tasks;
}

- (void)tasksInCurrentDataRange {
    NSDate *startDate = self.startDate;
    NSDate *endDate = self.endDate;
    
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
    
    self.tasksWithDates = [tasksWithDates copy];
    
    [self finishLoading];
}

@end
