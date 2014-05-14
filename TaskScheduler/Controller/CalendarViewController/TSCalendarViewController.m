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
        CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
        self.calendarView.calendar = calendar;
        calendar.delegate = self;
        
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
        self.minimumDate = [self.dateFormatter dateFromString:@"20/09/2012"];
        
        self.disabledDates = @[
                               [self.dateFormatter dateFromString:@"05/01/2013"],
                               [self.dateFormatter dateFromString:@"06/01/2013"],
                               [self.dateFormatter dateFromString:@"07/01/2013"]
                               ];
        calendar.onlyShowCurrentMonth = NO;
        calendar.adaptHeightToNumberOfWeeksInMonth = YES;
        
        calendar.frame = CGRectMake(10, 10, 300, 320);
        [self.view addSubview:calendar];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.view.bounds.size.width, 24)];
        [self.view addSubview:self.dateLabel];
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];

    }
    return self;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.calendarView.calendarView.de
}

- (void)localeDidChange {
    [self.calendarView.calendar setLocale:[NSLocale currentLocale]];
}

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(TSCalendarView, calendarView);


#pragma mark -
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // TODO: play with the coloring if we want to...
//    NSLog(@"Configure %@", date);
//    if ([self :date]) {
//        dateItem.backgroundColor = [UIColor redColor];
//        dateItem.textColor = [UIColor whiteColor];
//    }
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return NO;
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    self.dateLabel.text = [self.dateFormatter stringFromDate:date];
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    if ([date laterDate:self.minimumDate] == date) {
        self.calendarView.calendar.backgroundColor = [UIColor blueColor];
        return YES;
    } else {
        self.calendarView.calendar.backgroundColor = [UIColor redColor];
        return NO;
    }
}

- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame {
    //    NSLog(@"calendar layout: %@", NSStringFromCGRect(frame));
}

@end
