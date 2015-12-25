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

#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface AppBaseViewController ()
{

    UIImageView            *backgroundIV;
    UIView                 *blackCover;
    UIView                 *tabBarView;
    UIView                 *mainView;
    UINavigationController *homeNavController;
    
    CGFloat   distance;
    CGFloat   fullDistance;
    CGFloat   proportion;

    CGPoint   centerOfLeftViewAtBeginning;
    CGFloat   proportionOfLeftView;
    CGFloat   distanceOfLeftView;
    
    
    
    
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
    
    NSLog(@"appbasevc %@",self);
    //初始化一些控制器
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

    /*
     右侧主视图左边界距离屏幕左边界的距离占屏幕宽度的比例为：78%
     右侧主视图的高度占屏幕高度的比例为：77%
     */
    distance     = 0;
    fullDistance = 0.78;
    proportion = 0.77;  //这些数据是别人给的缩小的比例
    proportionOfLeftView = 1;
    distanceOfLeftView = 50;
    //注意添加覆盖的顺序
    backgroundIV = [[UIImageView alloc]init];
    backgroundIV.image = [UIImage imageNamed:@"WeakUp.jpg"];
    backgroundIV.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:backgroundIV];
    
    // 适配 4.7 和 5.5 寸屏幕的缩放操作，有偶发性小 bug
    if (kScreenWidth > 320) {
        
        proportionOfLeftView = kScreenWidth / 320;
        distanceOfLeftView += (kScreenWidth - 320)*fullDistance / 2;
        
    }

    _leftViewController.view.center = CGPointMake((_leftViewController.view.center.x - 50), _leftViewController.view.center.y);
    _leftViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
    
    //动画初始参数
    centerOfLeftViewAtBeginning = _leftViewController.view.center;
    //把侧滑菜单加入跟控制器
    [self.view addSubview:_leftViewController.view];
    
    blackCover = [[UIView alloc]initWithFrame:CGRectOffset(self.view.frame, 0, 0)];
    blackCover.backgroundColor = [UIColor blackColor];
    [self.view addSubview:blackCover];
    
    mainView = [[UIView alloc]initWithFrame:self.view.frame];
    tabBarView =_mainTabBarController.view;
    [mainView addSubview:tabBarView];
    [self.view addSubview:mainView];
    //
    self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gestureOnBaseVC:)];
    [mainView addGestureRecognizer:self.panGesture];

    self.tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(homeControllerAppear)];
    
    
}

- (void)receiveLeftVC:(NSNotification *)noti {

    [self homeControllerAppear];
    [AppEngineManager sharedInstance].mainTabBarController.tabBar.hidden = YES;
    
    NSLog(@"seld %@",self.navigationController);
    [UIView animateWithDuration:2.0 animations:^{
        
        [self.navigationController pushViewController:noti.object animated:YES];
        
    }];
    


}

//-----------------------------------------------------------

//左边的控制器
- (void)leftControllerAppear{
    //
    [mainView addGestureRecognizer:self.tapGesture];
    //在这里提前刷洗防止tableView留下上次选中的状态
    [_leftViewController.listTableView reloadData];
    distance = self.view.center.x * (fullDistance + proportion / 2);
    [self doAnimationWithScale:proportion withType:@"left"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)homeControllerAppear{
    
    [mainView removeGestureRecognizer:self.tapGesture];
    distance = 0;
    [self doAnimationWithScale:1 withType:@"home"];
    
    
}

- (void)rightControllerAppear{
    
    [mainView addGestureRecognizer:self.tapGesture];
    distance = self.view.center.x * -(fullDistance + proportion / 2);
    [self doAnimationWithScale:proportion withType:@"right"];
}

//处理动画啊
- (void)doAnimationWithScale:(CGFloat)scale withType:(NSString *)type {
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        mainView.center = CGPointMake(self.view.center.x + distance, self.view.center.y);
        mainView.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
        
        if ([type isEqualToString:@"left"]) {
            
            _leftViewController.view.center = CGPointMake(centerOfLeftViewAtBeginning.x + distanceOfLeftView, _leftViewController.view.center.y);
            _leftViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportionOfLeftView, proportionOfLeftView);
        }
        
        blackCover.alpha = [type isEqualToString:@"home"]? 1 : 0;
        
        
        // 为了演示效果，在右侧菜单划出时隐藏漏出的左侧菜单，并无实际意义
        _leftViewController.view.alpha = [type isEqualToString:@"right"] ? 0 : 1;
        
        
        
    }];
    
}





//-----------------------------------------------------------
- (void)gestureOnBaseVC:(UIPanGestureRecognizer *)recognizer {
    
    CGFloat distanceX    = [recognizer translationInView:self.view].x;
    
//    if (distanceX > 0) {
//        <#statements#>
//    }else {
//    
//    
//    
//    }
    
    CGFloat realDistance = distance + distanceX; //实时距离
    CGFloat realProportion = realDistance /(kScreenWidth * fullDistance);
    
    //结束时，自动激活停靠动作
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        if (realDistance > kScreenWidth * (proportion / 3)) {
            
            [self leftControllerAppear];
            
            
        }else if (realDistance < kScreenWidth * -(proportion / 3)){
            
            //这个页面未做
            [self rightControllerAppear];
            
        }else {
            
            [self homeControllerAppear];
        }
        
        return; //这是需要return，因为停止状态了;
    }
    
    //下面是计算缩放比例
    CGFloat scal = recognizer.view.frame.origin.x > 0 ? -1 : 1;
    scal *= realDistance / kScreenWidth;
    scal *= 1 - proportion;
    scal /= fullDistance + proportion / 2 - 0.5;
    scal += 1;
    
    if (scal <= proportion) { //若比例已经达到最小，则不在继续动画
        
        return;
    }
    // 执行视差特效
    blackCover.alpha = (scal - proportion) / (1 - proportion);
    
    
    //分别执行平移和缩放动画
    recognizer.view.center = CGPointMake(self.view.center.x + realDistance, self.view.center.y);
    recognizer.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, scal, scal);
    
    CGFloat pro = 0.8 + (proportionOfLeftView - 0.8) * realProportion;
    _leftViewController.view.center = CGPointMake(centerOfLeftViewAtBeginning.x + distanceOfLeftView * realProportion,
                                     centerOfLeftViewAtBeginning.y - (proportionOfLeftView - 1) * _leftViewController.view.frame.size.height * realProportion / 2);
    _leftViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, pro, pro);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
