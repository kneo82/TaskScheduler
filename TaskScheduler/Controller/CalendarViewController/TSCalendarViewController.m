//
//  TSCalendarViewController.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/13/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSCalendarViewController.h"
#import "TSCalendarView.h"
#import "CKCalendarView.h"

#import "UIViewController+IDPExtensions.h"

@interface TSCalendarViewController () <CKCalendarDelegate>
@property (nonatomic, readonly) TSCalendarView *calendarView;
@property(nonatomic, retain) UILabel *dateLabel;
@property(nonatomic, retain) NSDateFormatter *dateFormatter;
@property(nonatomic, retain) NSDate *minimumDate;
@property(nonatomic, retain) NSArray *disabledDates;
@property(nonatomic, retain) CKCalendarView *calendar;

@end

@implementation TSCalendarViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.dateLabel = nil;
    self.dateFormatter = nil;
    self.minimumDate = nil;
    self.disabledDates = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(TSCalendarView, calendarView);

#pragma mark -
#pragma mark Private

- (BOOL)dateIsDisabled:(NSDate *)date {
    for (NSDate *disabledDate in self.disabledDates) {
        if ([disabledDate isEqualToDate:date]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // TODO: play with the coloring if we want to...
//    NSLog(@"Configure %@", date);
    if ([self dateIsDisabled:date]) {
        dateItem.backgroundColor = [UIColor redColor];
        dateItem.textColor = [UIColor whiteColor];
    }
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return ![self dateIsDisabled:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    self.dateLabel.text = [self.dateFormatter stringFromDate:date];
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    if ([date laterDate:self.minimumDate] == date) {
        self.calendar.backgroundColor = [UIColor blueColor];
        return YES;
    } else {
        self.calendar.backgroundColor = [UIColor redColor];
        return NO;
    }
}

- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame {
    //    NSLog(@"calendar layout: %@", NSStringFromCGRect(frame));
}

@end
