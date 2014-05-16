//
//  TSRuleOnceDay.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/15/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSRuleOnceDay.h"

#import "NSDate+IDPExtensions.h"
#import "NSDateComponents+IDPExtinsions.h"

@implementation TSRuleOnceDay

#pragma mark -
#pragma mark Public

- (NSDate *)nextDate {
    NSDateComponents *components = [self.currentDate components:kTSRunitFlags];
    components.day++;
    
    NSDate *dateNext = [components dateFromComponents];
    self.currentDate = dateNext;
    
    NSLog(@"Next Day -- %@", [dateNext dateToStringWithFormat:@"dd/MM/yyyy"]);

    return self.currentDate;
}

- (NSDate *)previewDate {
    NSDateComponents *components = [self.currentDate components:kTSRunitFlags];
    components.day--;
    
    NSDate *dateNext = [components dateFromComponents];
    self.currentDate = dateNext;
    
    NSLog(@"Preview Day -- %@", [dateNext dateToStringWithFormat:@"dd/MM/yyyy"]);
    
    return self.currentDate;
}

- (NSArray *)datesFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    if (NSOrderedDescending == [self.currentDate compare:toDate]) {
        return nil;
    }
    
    
    
    while (NSOrderedAscending == [[self nextDate] compare:fromDate]) {
        
    }
    
    [self previewDate];
    
    NSMutableArray *dates = [NSMutableArray array];
    NSComparisonResult compareWithFromData = [self.currentDate compare:fromDate];
    NSComparisonResult compareWithToData = [self.currentDate compare:toDate];
    if (NSOrderedSame == compareWithFromData
        || NSOrderedSame == compareWithToData
        ||(NSOrderedDescending == compareWithFromData
           && NSOrderedAscending == compareWithToData))
    {
        [dates addObject:self.currentDate];
    }
    
    while (NSOrderedAscending == [[self nextDate] compare:toDate]) {
        NSLog(@"Add date");
        [dates addObject:self.currentDate];
    }
    
    return [[dates copy] autorelease];
}

@end
