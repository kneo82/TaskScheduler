//
//  TSNewTaskView.h
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/19/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSNewTaskView : UIView
@property (retain, nonatomic) IBOutlet UILabel *dateLable;
@property (retain, nonatomic) IBOutlet UIPickerView *rulePicker;
@property (retain, nonatomic) IBOutlet UITextField *titleTextField;

@end
