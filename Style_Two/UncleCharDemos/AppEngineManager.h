//
//  AppEngineManager.h
//  UncleCharDemos
//
//  Created by UncleChar on 15/12/25.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppBaseViewController;//相当于整个容器
@class MainTabBarController;
@class UINavigationController;

@interface AppEngineManager : NSObject

@property (nonatomic, strong) UINavigationController    *baseNavController;
@property (nonatomic, strong) AppBaseViewController     *baseViewController;
@property (nonatomic, strong) MainTabBarController      *mainTabBarController;

+ (instancetype)sharedInstance;

@end
