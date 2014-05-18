//
//  TSCalendarViewController.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/13/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSCalendarViewController.h"
#import "TSCalendarView.h"


#import "TSFindTasks.h"
#import "UIViewController+IDPExtensions.h"
#import "NSDate+IDPExtensions.h"
#import "NSDateComponents+IDPExtinsions.h"

@interface TSCalendarViewController ()
@property (nonatomic, readonly) TSCalendarView *calendarView;

@end

@implementation TSCalendarViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    
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
//    [findTask cancel];
//    [findTask release];
}

- (void)localeDidChange {
    [self.calendarView.calendar setLocale:[NSLocale currentLocale]];
}

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(TSCalendarView, calendarView);

#pragma mark -
#pragma mark Private



#pragma mark -
#pragma mark TDTaskCompletion

- (void)modelDidLoad:(id)object {
    TSFindTasks *task = object;
//    NSLog(@"******Dates & Event **********\n\n%@", task.tasksWithDates);
    

}

- (void)modelDidCancelLoading:(id)theModel {
    NSLog(@"****** Cancel **********\n\n");
}

- (void)modelDidFailToLoad:(id)model {
    NSLog(@"****** Fail Load **********\n\n");
}

@end
