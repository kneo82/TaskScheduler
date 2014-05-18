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
#import "NSDate+IDPExtensions.h"
#import "NSDateComponents+IDPExtinsions.h"

static const NSUInteger kTSFirstDay = 1;
@interface TSTaskRule ()
@property (nonatomic, retain)     TSTask  *task;

@end

@implementation TSTaskRule

//@synthesize currentDate = _currentDate;

#pragma mark -
#pragma mark Class Methods

+ (id)contextWithTask:(TSTask *)task {
    Class class = NSClassFromString(task.ruleType.ruleType);
    if (![class isSubclassOfClass:[TSTaskRule class]]) {
        return nil;
    }
    
    TSTaskRule *context = [class object];
    context.task = task;
    context.currentDate = task.date;
    
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

//- (NSDate *)currentDate {
//    if (!_currentDate) {
//        self.currentDate = self.task.date;
//    }
//    
//    return _currentDate;
//}

- (void)setCurrentDate:(NSDate *)currentDate {
    IDPNonatomicRetainPropertySynthesize(_currentDate, [currentDate midnightDate]);
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
    if (!fromDate || !toDate) {
        return nil;
    }
    
    if (NSOrderedDescending == [self.currentDate compare:toDate]
        || NSOrderedDescending == [fromDate compare:toDate])
    {
        return nil;
    }
    
    fromDate = [NSDate midnightDateForDate:fromDate];
    toDate = [NSDate midnightDateForDate:toDate];

    [self lastPreviewDateToDate:fromDate];
    
    NSMutableArray *dates = [NSMutableArray array];
    
    if ([self isCurrentDateBetwinStartDate:fromDate endDate:toDate]) {
        [dates addObject:self.currentDate];
    }
    
    while (NSOrderedAscending == [[self nextDate] compare:toDate]
           || NSOrderedSame == [self.currentDate compare:toDate])
    {
        [dates addObject:self.currentDate];
    }
    
    return [[dates copy] autorelease];
}

- (NSDate *)dateInCurrentMonthFromComponent:(NSDateComponents *)component {
    component.day = kTSFirstDay;
    
    NSUInteger countDayInMonth = [NSDate numberOfDaysInMonthForDate:[component dateFromComponents]];
    
    if (self.task.date.day > countDayInMonth) {
        component.day = countDayInMonth;
    } else {
        component.day = self.task.date.day;
    }
    
    return [component dateFromComponents];
}

#pragma mark -
#pragma mark Private

- (NSDate *)lastPreviewDateToDate:(NSDate *)date {
    while (NSOrderedAscending == [[self nextDate] compare:date]) {
    }
    
    [self previewDate];
    
    return self.currentDate;
}

- (BOOL)isCurrentDateBetwinStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSDate *currentDate = self.currentDate;
    
    NSComparisonResult compareWithFromData = [currentDate compare:startDate];
    NSComparisonResult compareWithToData = [currentDate compare:endDate];
    
    return ((NSOrderedDescending == compareWithFromData || NSOrderedSame == compareWithFromData)
            && (NSOrderedAscending == compareWithToData || NSOrderedSame == compareWithToData));
}

@end
