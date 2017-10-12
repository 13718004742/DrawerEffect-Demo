//
//  ViewController.m
//  抽屉效果-Demo
//
//  Created by 张建 on 2017/4/25.
//  Copyright © 2017年 JuZiShu. All rights reserved.
//

#import "ViewController.h"
#import "DrawerViewController.h"

@interface ViewController ()

@property (nonatomic,strong)DrawerViewController * drawerC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.userInteractionEnabled = YES;
    
    _drawerC = [[DrawerViewController alloc] init];
    _drawerC.view.frame = self.view.bounds;
    _drawerC.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:_drawerC.view];
    
}

//开始触摸移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesMoved:touches withEvent:event];
    
    [_drawerC touchesBegan:touches withEvent:event];
    
}

//结束触摸
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesEnded:touches withEvent:event];
    
    [_drawerC touchesEnded:touches withEvent:event];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
