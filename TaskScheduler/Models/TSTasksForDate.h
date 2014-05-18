//
//  TSTasksForDate.h
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/18/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TSTask;

@interface TSTasksForDate : NSObject
@property (nonatomic, readonly) NSDictionary    *datesWithTasks;
@property (nonatomic, retain)   NSDate          *startDatePeriod;
@property (nonatomic, retain)   NSDate          *endDatePeriod;

- (void)setDatesWithTasks:(NSDictionary *)datesWithTasks;
- (NSArray *)tasksForDate:(NSDate *)date;
- (BOOL)periodTheSameForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end
