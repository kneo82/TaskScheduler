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

#import "TSFindTasks.h"
#import "UIViewController+IDPExtensions.h"
#import "NSDate+IDPExtensions.h"
#import "NSDateComponents+IDPExtinsions.h"

@interface TSCalendarViewController () <CKCalendarDelegate>
@property (nonatomic, readonly) TSCalendarView *calendarView;
@property(nonatomic, retain) UILabel *dateLabel;
@property(nonatomic, retain) NSDateFormatter *dateFormatter;
@property(nonatomic, retain) NSDate *minimumDate;
@property(nonatomic, retain) NSArray *disabledDates;
//@property(nonatomic, retain) CKCalendarView *calendar;

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
    
    self.calendarView.calendar.delegate = self;
    
    self.dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];

    TSFindTasks *findTask = [[[TSFindTasks alloc] init] autorelease];
    
    NSDateComponents *components = [[NSDate date] components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit)];
    
    components.day = 29;
    components.month = 2;
    components.year = 2012;
    
    NSDate *date1 = [components dateFromComponents];
    
    components.day = 17;
    components.month = 5;
    components.year = 2014;
    NSDate *date2 = [components dateFromComponents];
    
    findTask.startDate = date1;
    findTask.endDate = date2;
    
    [findTask addObserver:self];
    [findTask findTasks];
    [findTask cancel];
}

- (void)localeDidChange {
    [self.calendarView.calendar setLocale:[NSLocale currentLocale]];
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
//    NSLog(@"Configure %@", dateItem);
    
    if ([self dateIsDisabled:date]) {
        dateItem.backgroundColor = [UIColor redColor];
        dateItem.textColor = [UIColor whiteColor];
    }
}

//- (BOOL)calendar:(CKCalendarView *)calendar didChangeToMonth:(NSDate *)date {
//    NSLog(@"Configure %@", calendar.datesShowing);
//    return YES;
//}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    NSLog(@"%@",  [self.dateFormatter stringFromDate:date]);
    return ![self dateIsDisabled:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    self.dateLabel.text = [self.dateFormatter stringFromDate:date];
}

- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame {
    //    NSLog(@"calendar layout: %@", NSStringFromCGRect(frame));
}

#pragma mark -
#pragma mark TDTaskCompletion

- (void)modelDidLoad:(id)object {
    TSFindTasks *task = object;
    NSLog(@"******Dates & Event **********\n\n%@", task.tasksWithDates);
}

- (void)modelDidCancelLoading:(id)theModel {
    NSLog(@"****** Cancel **********\n\n");
}

- (void)modelDidFailToLoad:(id)model {
    NSLog(@"****** Fail Load **********\n\n");
}

@end
