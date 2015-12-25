//
//  AppEngineManager.m
//  UncleCharDemos
//
//  Created by UncleChar on 15/12/25.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import "AppEngineManager.h"
#import "AppBaseViewController.h"
#import "MainTabBarController.h"

static  AppEngineManager *sharesElement = nil;
@implementation AppEngineManager


+ (instancetype)sharedInstance {
    
    @synchronized(self) {
        
        if (sharesElement == nil) {
            
            sharesElement = [[self alloc]init];
        }
    }
    
    return sharesElement;
}

+(id)allocWithZone:(struct _NSZone *)zone {
    
    @synchronized(self) {
        
        if (sharesElement == nil) {
            
            sharesElement = [super allocWithZone:zone];
            return  sharesElement;
        }
        
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    
    return self;
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.baseViewController = [[AppBaseViewController alloc]init];
        
        self.baseNavController = [[UINavigationController alloc]initWithRootViewController:self.baseViewController];
        
        self.mainTabBarController = [[MainTabBarController alloc]init];
        
        
        NSLog(@"BaseViewController%@",self.baseViewController);
        NSLog(@"BaseViewControllerNavC%@",self.baseNavController);
        NSLog(@"MainTBC%@",self.mainTabBarController);
    }
    return self;
}



@end
