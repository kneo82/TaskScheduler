//
//  TSCalendarViewController.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/13/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//
#import <ABCalendarPicker/ABCalendarPicker.h>

#import "TSCalendarViewController.h"
#import "TSCalendarView.h"
#import "TSTasksForDate.h"
#import "TSFindTasks.h"
#import "TSTasksViewController.h"

#import "IDPPropertyMacros.h"

#import "UIViewController+IDPExtensions.h"
#import "NSDate+IDPExtensions.h"
#import "NSDateComponents+IDPExtinsions.h"
#import "NSObject+IDPExtensions.h"
#import "UIViewController+IDPInitialization.h"

@interface TSCalendarViewController () <ABCalendarPickerDelegateProtocol,
                                        ABCalendarPickerDataSourceProtocol>

@property (nonatomic, readonly) TSCalendarView  *calendarView;
//@property (nonatomic, retain)   NSDictionary    *tasks;
@property (nonatomic, retain)   TSTasksForDate  *tasksForDates;
@property (nonatomic, retain)   TSFindTasks     *findTask;

@end

@implementation TSCalendarViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
//    self.tasks = nil;
    self.tasksForDates = nil;
    self.findTask = nil;
    
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
    
//    TSFindTasks *findTask = [TSFindTasks object];
    
//    NSDateComponents *components = [[NSDate date] components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit)];
    
    ABCalendarPicker *calendarPicker = self.calendarView.calendar;
    
    NSDate *startDate = [calendarPicker.daysProvider dateForRow:0 andColumn:0];
    NSDate *endDate = [calendarPicker.daysProvider dateForRow:[calendarPicker.daysProvider rowsCount]-1
                                                    andColumn:[calendarPicker.daysProvider columnsCount]-1];
    
//    self.tasksForDates = [TSTasksForDate object];
//    TSTasksForDate *taskForDates = self.tasksForDates;
//    taskForDates.startDatePeriod = startDate;
//    taskForDates.endDatePeriod = endDate;
//    findTask.taskForDate = taskForDates;
//    
//    [findTask addObserver:self];
//    [findTask findTasks];
    
    [self findeTasksForStartDate:startDate endDate:endDate];
}


#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(TSCalendarView, calendarView);

- (void)setTasksForDates:(TSTasksForDate *)tasksForDates {
    IDPNonatomicRetainPropertySynthesize(_tasksForDates, tasksForDates);
}

#pragma mark -
#pragma mark Private

- (void)findeTasksForStartDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
//    if (!self.tasksForDates) {
        self.tasksForDates = [TSTasksForDate object];
//    }
    
    TSFindTasks *findTask = [TSFindTasks object];
    self.findTask = findTask;
    
    TSTasksForDate *taskForDates = self.tasksForDates;
    taskForDates.startDatePeriod = startDate;
    taskForDates.endDatePeriod = endDate;
    findTask.taskForDate = taskForDates;
    
    [findTask addObserver:self];
    [findTask findTasks];
}

#pragma mark -
#pragma mark TDTaskCompletion

- (void)modelDidLoad:(id)object {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.calendarView.calendar updateStateAnimated:NO];
    });
}

- (void)modelDidCancelLoading:(id)theModel {
    NSLog(@"****** Cancel **********\n\n");
}

- (void)modelDidFailToLoad:(id)model {
    NSLog(@"****** Fail Load **********\n\n");
}

#pragma mark -
#pragma mark ABCalendarPickerDataSourceProtocol

- (NSInteger)calendarPicker:(ABCalendarPicker *)calendarPicker
      numberOfEventsForDate:(NSDate *)date
                    onState:(ABCalendarPickerState)state
{
    NSDate *midnightDate = [date midnightDate];
    NSUInteger countOfTasks = [[self.tasksForDates tasksForDate:midnightDate] count];
    
    return countOfTasks;
}

- (void)calendarPicker:(ABCalendarPicker*)calendarPicker
          dateSelected:(NSDate*)date
             withState:(ABCalendarPickerState)state
{
    NSLog(@"\n\n*********\n\n dateSelected date %@ \n\n*********", [calendarPicker.daysProvider mainDateEnd]);
    NSDate *startDate = [calendarPicker.daysProvider dateForRow:0 andColumn:0];
    NSDate *endDate = [calendarPicker.daysProvider dateForRow:[calendarPicker.daysProvider rowsCount]-1
                                                    andColumn:[calendarPicker.daysProvider columnsCount]-1];
    
    if (![self.tasksForDates periodTheSameForStartDate:startDate endDate:endDate]) {
        [self findeTasksForStartDate:startDate endDate:endDate];
    } else {
        TSTasksViewController *controller = [TSTasksViewController viewControllerWithDefaultNib];
        controller.tasksForDate = self.tasksForDates;
        controller.date = date;
        
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
