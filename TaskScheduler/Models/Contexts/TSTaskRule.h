//
//  TSTaskRule.h
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/15/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TSTask;

#define kTSRunitFlags (NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit)

@interface TSTaskRule : NSObject
@property (nonatomic, readonly)     TSTask  *task;
@property (nonatomic, retain)       NSDate  *currentDate;

+ (id)contextWithTask:(TSTask *)task;

- (NSDate *)nextDate;
- (NSDate *)previewDate;
- (NSArray *)datesFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
- (NSDate *)dateInCurrentMonthFromComponent:(NSDateComponents *)component;

@end
