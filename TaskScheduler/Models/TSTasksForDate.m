//
//  TSTasksForDate.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/18/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSTasksForDate.h"
#import "TSTask.h"

#import "IDPPropertyMacros.h"

#import "NSDate+IDPExtensions.h"

@interface TSTasksForDate ()
@property (nonatomic, retain) NSDictionary    *datesWithTasks;

@end

@implementation TSTasksForDate

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.datesWithTasks = nil;
    self.endDatePeriod = nil;
    self.startDatePeriod = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (void)setDatesWithTasks:(NSDictionary *)datesWithTasks {
    IDPNonatomicRetainPropertySynthesize(_datesWithTasks, datesWithTasks);
}

- (NSArray *)tasksForDate:(NSDate *)date {
    return [self.datesWithTasks objectForKey:[date midnightDate]];
}

- (void)setStartDatePeriod:(NSDate *)startDatePeriod {
    IDPNonatomicRetainPropertySynthesize(_startDatePeriod, [startDatePeriod midnightDate]);
}

- (void)setEndDatePeriod:(NSDate *)endDatePeriod {
    IDPNonatomicRetainPropertySynthesize(_endDatePeriod, [endDatePeriod midnightDate]);
}

#pragma mark -
#pragma mark Public

- (BOOL)periodTheSameForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    if (NSOrderedSame == [self.startDatePeriod compare:[startDate midnightDate]]
        && NSOrderedSame == [self.endDatePeriod compare:[endDate midnightDate]])
    {
        return YES;
    }
    
    return NO;
}

@end
