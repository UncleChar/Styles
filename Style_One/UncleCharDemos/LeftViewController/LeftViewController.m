//
//  LeftViewController.m
//  SlideLikeQQ
//
//  Created by UncleChar on 15/12/22.
//  Copyright © 2015年 hailong.xie. All rights reserved.
//

#import "LeftViewController.h"
#import "fuckViewController.h"
#import "loveViewController.h"
#import "AppBaseViewController.h"
#import "AppEngineManager.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray  *titleListArray;
@property (nonatomic, strong) UIImageView  *avatarImageView;

@end

@implementation LeftViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleListArray = @[@"开通会员", @"QQ钱包", @"网上营业厅", @"个性装扮", @"我的收藏", @"我的相册", @"我的文件"];
    
    _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20,self.view.frame.size.width, self.view.frame.size.height-20) style:UITableViewStylePlain];
    _listTableView.dataSource = self;
    _listTableView.delegate = self;
    [self.view addSubview:_listTableView];
    self.view.frame = CGRectMake(-(self.view.frame.size.width - self.view.frame.size.width / 6), 0, self.view.frame.size.width - self.view.frame.size.width / 6, kScreenHeight);

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _titleListArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentify = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = _titleListArray[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

//    id obj;
    
//    if (indexPath.row % 2 == 0) {
//        fuckViewController *al = [[fuckViewController alloc]init];
//        obj = al;
//    }else{
//    
//        loveViewController *tt = [[loveViewController alloc]init];
//        obj = tt;
//    }

    
    AppBaseViewController *baseVC = [AppEngineManager sharedInstance].baseViewController;
    [baseVC homeControllerAppear];
    
    fuckViewController *fuck = [[fuckViewController alloc]init];
    fuck.labelTitle = _titleListArray[indexPath.row];
    [baseVC.navigationController pushViewController:fuck animated:YES];
    



    

    
    
    
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
