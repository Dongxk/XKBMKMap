//
//  ViewController.m
//  BMK_XKMap
//
//  Created by  XIAOKUN on 2018/11/5.
//  Copyright © 2018 晓坤. All rights reserved.
//

#import "ViewController.h"
#import "LocationViewController.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"百度地图";
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.textAlignment = 1;
    cell.detailTextLabel.numberOfLines = 0;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"定位";
        cell.detailTextLabel.text = @"定位";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"单个描点";
        cell.detailTextLabel.text = @"通过经纬度，显示位置";
    }else if (indexPath.row == 2) {
        cell.textLabel.text = @"组描点";
        cell.detailTextLabel.text = @"通过一组经纬度，显示多个位置";
    }else if (indexPath.row == 3) {
        cell.textLabel.text = @"气泡点击事件";
        cell.detailTextLabel.text = @"点击气泡，获取到点击事件";
    }else if (indexPath.row == 4) {
        cell.textLabel.text = @"自定义大头针,给气泡加tag值";
        cell.detailTextLabel.text = @"多个位置描点后, 通过tag值区分点击的气泡(百度没有该功能，需要自定义实现)";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row != 4) {
        return 50;
    }
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        LocationViewController *vc = [LocationViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
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
