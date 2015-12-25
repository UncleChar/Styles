//
//  BaseViewController.m
//  ReconstructionQQSlide
//
//  Created by LingLi on 15/12/24.
//  Copyright © 2015年 LingLi. All rights reserved.
//

#import "BaseViewController.h"
#import "AppEngineManager.h"
#import "AppBaseViewController.h"
//#import "ContainerViewController.h"
//#import "AppEngine.h"
//#import "LeftVCToOthers.h"
//#import "ViewController.h"
@implementation BaseViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.title = @"ff";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(home)];
    leftItem.image = [UIImage imageNamed:@"qq@3x"];
    self.navigationItem.leftBarButtonItem = leftItem;


}
- (void)home{
    
    NSLog(@"leftBtnClicked");
    [[AppEngineManager sharedInstance].baseViewController leftControllerAppear];

   
}
@end
