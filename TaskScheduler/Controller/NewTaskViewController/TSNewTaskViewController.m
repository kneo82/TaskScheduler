//
//  TSNewTaskViewController.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/19/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSNewTaskViewController.h"
#import "TSNewTaskView.h"
#import "TSUser.h"
#import "TSRuleType.h"
#import "IDPActiveRecordKit.h"

#import "TSRuleOnceYear.h"
#import "TSRuleOnceWeek.h"
#import "TSRuleOnceMonth.h"
#import "TSRuleOnceDay.h"

#import "IDPActiveRecordKit.h"
#import "UIViewController+IDPInitialization.h"
#import "UIViewController+IDPExtensions.h"

@interface TSNewTaskViewController ()
@property (nonatomic, readonly) TSNewTaskView   *taskView;
@property (nonatomic, retain)   NSArray         *taskRules;
@property (nonatomic, retain)   TSUser          *user;
@end

@implementation TSNewTaskViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.taskRules = nil;
    self.date = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TSUser *user = [TSUser managedObject];
    self.user = user;
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    TSRuleType *rule = nil;
    if (![user isHasRuleType:NSStringFromClass([TSRuleOnceDay class])]) {
        rule = [TSRuleType managedObject];
        rule.ruleType = NSStringFromClass([TSRuleOnceDay class]);
        [user addRuleType:rule];
    }
    [dictionary setObject:rule forKey:@"Once a Day"];
    
    rule = nil;
    if (![user isHasRuleType:NSStringFromClass([TSRuleOnceWeek class])]) {
        rule = [TSRuleType managedObject];
        rule.ruleType = NSStringFromClass([TSRuleOnceWeek class]);
        [user addRuleType:rule];
    }
    [dictionary setObject:rule forKey:@"Once a Week"];
    
    rule = nil;
    if (![user isHasRuleType:NSStringFromClass([TSRuleOnceMonth class])]) {
        TSRuleType *rule = [TSRuleType managedObject];
        rule.ruleType = NSStringFromClass([TSRuleOnceMonth class]);
        [user addRuleType:rule];
    }
    [dictionary setObject:rule forKey:@"Once a Month"];
    
    rule = nil;
    if (![user isHasRuleType:NSStringFromClass([TSRuleOnceYear class])]) {
        TSRuleType *rule = [TSRuleType managedObject];
        rule.ruleType = NSStringFromClass([TSRuleOnceYear class]);
        [user addRuleType:rule];
    }
    [dictionary setObject:rule forKey:@"Once a Year"];

    
    self.taskRules = user.rulesType;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(TSNewTaskView, taskView);

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.taskRules count];
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    TSRuleType *rule = self.taskRules[row];
    return rule.ruleType;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    TSRuleType *rule = self.taskRules[row];
    NSLog(@"Selected row = %d, title = %@", row, rule.ruleType);
}

@end
