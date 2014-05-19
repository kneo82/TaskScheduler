//
//  TSTasksViewController.h
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/19/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TSTasksForDate;

@interface TSTasksViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain)   TSTasksForDate  *tasksForDate;
@property (nonatomic,retain)    NSDate          *date;

- (IBAction)onAddTask:(id)sender;

@end
