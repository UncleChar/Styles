//
//  AppBaseViewController.h
//  UncleCharDemos
//
//  Created by UncleChar on 15/12/25.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeftViewController;
@class MainTabBarController;

@interface AppBaseViewController : UIViewController


@property (nonatomic, strong) LeftViewController     *leftViewController;
@property (nonatomic, strong) MainTabBarController   *mainTabBarController;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

- (void)homeControllerAppear;
- (void)leftControllerAppear;
@end
