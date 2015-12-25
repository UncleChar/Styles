//
//  fuckViewController.m
//  MyDemoAssemble
//
//  Created by UncleChar on 15/12/25.
//  Copyright © 2015年 LingLi. All rights reserved.
//

#import "fuckViewController.h"

@interface fuckViewController ()

@end

@implementation fuckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel  *label = [[UILabel alloc]init];
    label.text = self.labelTitle;
    label.font = [UIFont boldSystemFontOfSize:30];
    label.textColor = [UIColor colorWithRed:252/255.0 green:166.0/255.0 blue:41.0/255.0 alpha:1];
    label.textAlignment = 1;
    label.frame = CGRectMake(self.view.frame.size.width / 2 - 100, self.view.frame.size.height / 2 - 40, 200, 80);
    [self.view addSubview:label];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
