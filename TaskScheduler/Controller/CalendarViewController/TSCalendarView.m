//
//  TSCalendarView.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/13/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSCalendarView.h"

@implementation TSCalendarView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.calendar = nil;
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

#pragma mark -
#pragma mark View Lifecycle

<<<<<<< HEAD:TaskScheduler/Controller/CalendarViewController/TSCalendarView.m
- (void)awakeFromNib {
    CKCalendarView *calendar = self.calendar;
    
    calendar.onlyShowCurrentMonth = NO;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    [calendar setMonthButtonColor:[UIColor grayColor]];
    [calendar setInnerBorderColor:[UIColor blueColor]];
    [calendar setDayOfWeekBottomColor:[UIColor blackColor] topColor:[UIColor darkGrayColor]];
    calendar.dayOfWeekTextColor = [UIColor whiteColor];
    calendar.backgroundColor = [UIColor blackColor];
}

=======
>>>>>>> parent of 38fc842... Convert CKCalendar FROM ARC to NON ARC:TaskScheduler/CalendarViewController/TSCalendarView.m
@end
