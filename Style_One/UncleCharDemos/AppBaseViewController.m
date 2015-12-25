//
//  AppBaseViewController.m
//  UncleCharDemos
//
//  Created by UncleChar on 15/12/25.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import "AppBaseViewController.h"
#import "LeftViewController.h"
#import "AppEngineManager.h"
#import "MainTabBarController.h"

@interface AppBaseViewController ()
{

    UIImageView     *backgroundIV;
    UIView          *blackCover;
    UIView          *baseView;
    CGFloat          displacementOfLeftViewController;
    CGPoint          centerOfLeftViewAtBeginning;
    CGPoint          centerOfBaseViewController;
    CGFloat          realDistance;
    
}
@end

@implementation AppBaseViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    [AppEngineManager sharedInstance].mainTabBarController.tabBar.hidden = NO;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initControllers];
    
    //初始化背景的图片和黑色遮盖层
    [self configBackgroundElement];
    
    
}

//-----------------------------------------------------------

- (void)initControllers{

    _leftViewController   = [[LeftViewController alloc]init];
    _mainTabBarController = [AppEngineManager sharedInstance].mainTabBarController;

}


- (void)configBackgroundElement {

    //注意添加覆盖的顺序
    backgroundIV = [[UIImageView alloc]init];
    backgroundIV.image = [UIImage imageNamed:@"WeakUp.jpg"];
    backgroundIV.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:backgroundIV];
  
    //动画初始参数
    centerOfLeftViewAtBeginning = _leftViewController.view.center;
    centerOfBaseViewController  = self.view.center;
    //把侧滑菜单加入跟控制器
    [self.view addSubview:_leftViewController.view];
    
    blackCover = [[UIView alloc]initWithFrame:CGRectOffset(self.view.frame, 0, 0)];
    blackCover.backgroundColor = [UIColor blackColor];
    [self.view addSubview:blackCover];
    
    baseView = [[UIView alloc]initWithFrame:self.view.frame];
    baseView =_mainTabBarController.view;
    [self.view addSubview:baseView];
    
    self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gestureOnBaseVC:)];
    [baseView addGestureRecognizer:self.panGesture];

    self.tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(homeControllerAppear)];
    
}



//-----------------------------------------------------------

//左边的控制器
- (void)leftControllerAppear{
    //
    [baseView addGestureRecognizer:self.tapGesture];
    //在这里提前刷洗防止tableView留下上次选中的状态
    [_leftViewController.listTableView reloadData];
    displacementOfLeftViewController = centerOfBaseViewController.x + kScreenWidth - kScreenWidth / 6;;
    [self doAnimationWithType:@"left"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)homeControllerAppear{
    
    [baseView removeGestureRecognizer:self.tapGesture];
    displacementOfLeftViewController = self.view.center.x;
    [self doAnimationWithType:@"home"];
    
    
}

- (void)rightControllerAppear{
    
//    [mainView addGestureRecognizer:self.tapGesture];
//    [self doAnimationWithType:@"right"];
}

//处理动画啊
- (void)doAnimationWithType:(NSString *)type {
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        baseView.center = CGPointMake(displacementOfLeftViewController, self.view.center.y);
        
        if ([type isEqualToString:@"left"]) {
            
            _leftViewController.view.center = CGPointMake(centerOfLeftViewAtBeginning.x + displacementOfLeftViewController - self.view.center.x, centerOfLeftViewAtBeginning.y);
        }
        
       
        if ([type isEqualToString:@"home"]) {
            
            _leftViewController.view.center = CGPointMake(centerOfLeftViewAtBeginning.x , centerOfLeftViewAtBeginning.y);
        }
        
         blackCover.alpha = [type isEqualToString:@"home"]? 1 : 0;
    
        
    }];
    
}

//-----------------------------------------------------------
- (void)gestureOnBaseVC:(UIPanGestureRecognizer *)recognizer {
    
    realDistance = [recognizer translationInView:self.view].x;

    //结束时，自动激活停靠动作
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        if (realDistance > kScreenWidth / 3) {
            
            [self leftControllerAppear];
            
            
        }else if (realDistance < kScreenWidth * -(1/ 3)){
            
            //这个页面未做
            [self rightControllerAppear];
            
        }else {
            
            [self homeControllerAppear];
        }
        
        return; //这是需要return，因为停止状态了;
    }

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
