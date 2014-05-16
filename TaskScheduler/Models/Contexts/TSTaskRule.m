//
//  TSTaskRule.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/15/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSTaskRule.h"
#import "TSTask.h"
#import "TSRuleType.h"
#import "IDPPropertyMacros.h"

#import "NSObject+IDPExtensions.h"

//static const NSUInteger kTSRunitFlags = (NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit);

@implementation TSTaskRule

#pragma mark -
#pragma mark Class Methods

+ (id)contextWithTask:(TSTask *)task {
    Class class = NSClassFromString(task.ruleType.ruleType);
    if (![class isSubclassOfClass:[TSTaskRule class]]) {
        return nil;
    }
    
    TSTaskRule *context = [class object];
    context.task = task;
    
    return context;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.task = nil;
    self.currentDate = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Accessors

//- (void)setTask:(TSTask *)task {
//    IDPNonatomicRetainPropertySynthesize(_task, task);
//    
//    self.currentDate = task.date;
//}


- (NSDate *)currentDate {
    if (!_currentDate) {
        self.currentDate = self.task.date;
    }
    
    return _currentDate;
}

#pragma mark -
#pragma mark Public

- (NSDate *)nextDate {
    return nil;
}

- (NSDate *)previewDate {
    return nil;
}

- (NSArray *)datesFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    return nil;
}

@end
