//
//  DrawerViewController.h
//  抽屉效果-Demo
//
//  Created by 张建 on 2017/4/25.
//  Copyright © 2017年 JuZiShu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerViewController : UIViewController

#pragma mark ---touch---

//开始触摸移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

//结束触摸
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

@end
