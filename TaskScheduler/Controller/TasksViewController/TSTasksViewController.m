//
//  TSTasksViewController.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/19/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSTasksViewController.h"
#include "TSNewTaskViewController.h"
#import "TSTasksForDate.h"
#import "TSTasksView.h"
#import "TSCell.h"
#import "TSTask.h"

#import "IDPPropertyMacros.h"

#import "UIViewController+IDPExtensions.h"
#import "UITableView+TDExtensions.h"
#import "UITableView+IDPCellLoading.h"
#import "UIViewController+IDPInitialization.h"

@interface TSTasksViewController ()
@property (nonatomic, readonly) TSTasksView *taskView;

@end

@implementation TSTasksViewController

@dynamic taskView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.tasksForDate = nil;
    self.date = nil;

    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {

    }
    
    return self;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(TSTasksView, taskView);

- (void)setTasksForDate:(TSTasksForDate *)tasksForDate {
    IDPNonatomicRetainPropertySynthesize(_tasksForDate, tasksForDate);
}

#pragma mark -
#pragma mark Interface Handling

- (void)onAddTask:(id)sender {
    TSNewTaskViewController *view = [TSNewTaskViewController viewControllerWithDefaultNib];
    view.date = self.date;
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.tasksForDate tasksForDate:self.date] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSCell *cell = [tableView dequeueCell:[TSCell class]];
    
//    TDUser *cellModel = self.session.users[indexPath.row];
    NSArray *tasks = [self.tasksForDate tasksForDate:self.date];
    TSTask *task = tasks[indexPath.row];
	cell.label.text = task.title;
    
    return  cell;
}

@end
