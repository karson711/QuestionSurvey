//
//  ViewController.m
//  QuestionSurvey
//
//  Created by kunge on 16/6/7.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import "ViewController.h"

#import "QuestionPulishVC.h"

@interface ViewController ()

- (IBAction)questionSurveyAction;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)questionSurveyAction {
    QuestionPulishVC *question  = [[QuestionPulishVC alloc] init];
    [self.navigationController pushViewController:question animated:YES];
}
@end
