//
//  TSTasksView.h
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/19/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSTasksView : UIView
@property (nonatomic, retain)   IBOutlet UITableView        *table;
@property (nonatomic, retain)	IBOutlet UIBarButtonItem	*addTaskButton;

@end
