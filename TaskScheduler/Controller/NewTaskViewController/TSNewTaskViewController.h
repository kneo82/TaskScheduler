//
//  TSNewTaskViewController.h
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/19/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSNewTaskViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic,retain)    NSDate          *date;

@end
