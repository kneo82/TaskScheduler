//
//  TSCalendarView.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/13/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSCalendarView.h"
#import "CKCalendarView.h"

@implementation TSCalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)awakeFromNib {
    CKCalendarView *calendar = self.calendar;
    
    calendar.onlyShowCurrentMonth = NO;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    [calendar setMonthButtonColor:[UIColor grayColor]];
    [calendar setInnerBorderColor:[UIColor blueColor]];
    [calendar setDayOfWeekBottomColor:[UIColor blackColor] topColor:[UIColor darkGrayColor]];
    calendar.dayOfWeekTextColor = [UIColor whiteColor];
    calendar.backgroundColor = [UIColor blackColor];
    //    [self.view addSubview:calendar];
    
    //    self.dateLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.view.bounds.size.width, 24)] autorelease];
    //    [self.view addSubview:self.dateLabel];
    
    //    self.view.backgroundColor = [UIColor whiteColor];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    
}

- (void)dealloc {
    [_calendar release];
    [super dealloc];
}
@end
