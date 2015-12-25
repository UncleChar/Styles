//
//  MessageViewController.m
//  ReconstructionQQSlide
//
//  Created by LingLi on 15/12/24.
//  Copyright © 2015年 LingLi. All rights reserved.
//

#import "MessageViewController.h"

@implementation MessageViewController


- (void)viewWillAppear:(BOOL)animated {
    
    NSLog(@"MESSAGE");
    
}
- (void)viewDidLoad {
    
     [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"MESSAGE";

    
   
    
}
- (void)jumpToOtherController {
    
    
////        [AppEngine sharedInstance].mainTabBarController.tabBarController.tabBar.hidden = 1;
//        LeftVCToOthers *other = [[LeftVCToOthers alloc]init];
//    //    other.nameOfController = _titleOfController;
//        [self.navigationController pushViewController:other animated:nil];
    
}
@end
