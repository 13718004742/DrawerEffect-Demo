//
//  DrawerViewController.m
//  抽屉效果-Demo
//
//  Created by 张建 on 2017/4/25.
//  Copyright © 2017年 JuZiShu. All rights reserved.
//

#import "DrawerViewController.h"

// 抬起手指时，让topview定位
#define MaxRightX      280.0
#define MaxLeftX       -200.0

@interface DrawerViewController ()

//左面的视图
@property (nonatomic,strong)UIView * leftView;
//右面的视图
@property (nonatomic,strong)UIView * rightView;
//最上面的视图
@property (nonatomic,strong)UIView * topView;
//是否拖动
@property (nonatomic,assign)BOOL draging;
//是否动画
@property (nonatomic,assign)BOOL animation;

@end

@implementation DrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.userInteractionEnabled = YES;
    
    //初始化视图
    [self initUI];
}

#pragma mark ---initUI---
- (void)initUI{
    
    //左面的视图
    _leftView = [[UIView alloc] init];
    _leftView.frame = self.view.bounds;
    _leftView.userInteractionEnabled = NO;
    _leftView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_leftView];
    
    //右面的视图
    _rightView = [[UIView alloc] init];
    _rightView.frame = self.view.bounds;
    _rightView.userInteractionEnabled = NO;
    _rightView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_rightView];
    
    //最上面的视图
    _topView = [[UIView alloc] init];
    _topView.backgroundColor = [UIColor greenColor];
    _topView.userInteractionEnabled = YES;
    _topView.frame = self.view.bounds;
    [self.view addSubview:_topView];
    
    //监听topView的frame变化
    [_topView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
}

#pragma mark ---touch---
//开始触摸移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
        
    //记录是拖动的
    self.draging = YES;
    
    //取出触摸
    UITouch * touch = touches.anyObject;
    //当前触摸点
    CGPoint location = [touch locationInView:self.view];
    //之前的触摸点
    CGPoint lastLocation = [touch previousLocationInView:self.view];
    //计算水平偏移量
    CGFloat offetX = location.x - lastLocation.x;
    
    NSLog(@"offsetX:%f",offetX);
    
    //topView的frame
    _topView.frame = [self topRectWithX:offetX];
    
    
}
//结束触摸
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //如果不是拖动的直接回复位置
    if (!_draging && _topView.frame.origin.x != 0) {
        
        //恢复
//        [self recoveryFrame];
        
        return;
    }
    
    CGRect frame = _topView.frame;
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    CGFloat targetX = 0;
    if (frame.origin.x > size.width * 0.5) {
        
        targetX = MaxRightX;
    }
    else if (CGRectGetMaxX(frame) < size.width * 0.5) {
        
        targetX = MaxLeftX;
    }
    
    //计算出偏移量
    CGFloat offsetX = targetX - frame.origin.x;
    
    _animation = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        if (targetX != 0) {
            
            _topView.frame = [self topRectWithX:offsetX];
            
        }else {
            
            _topView.frame = self.view.bounds;
        }
        
    } completion:^(BOOL finished) {
        
        _draging = NO;
        _animation = NO;
    }];
}

//根据x值来计算topView的frame（主要计算y值）
- (CGRect)topRectWithX:(CGFloat)x{
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    //计算y-最大是60
    CGFloat y = x / size.width * 60;
    //计算缩放比列
    CGFloat scale = (size.height - 2 * y) / size.height;
    //如果x < 0同样要缩放、
    if (_topView.frame.origin.x < 0) {
        
        scale = 2 - scale;
    }
    NSLog(@"scale:%f",scale);
    
    //根据比例计算topView新的frame
    CGRect frame = _topView.frame;
    frame.size.width = frame.size.width * scale;
    frame.size.height = frame.size.height * scale;
    frame.origin.x += x;
    frame.origin.y = (size.height - frame.size.height) / 2.0;
    
    return frame;
}
- (void)recoveryFrame
{
    _animation = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
       
        self.topView.frame = self.view.bounds;
        
    } completion:^(BOOL finished) {
        
        _animation = NO;
        
    }];
}
#pragma mark ---topView的frame变化的时候就会调用这个方法---
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (_animation) {
        
        return;
    }
    
    // 如果self.mainView.frame.origin.x > 0 向右
    if (_topView.frame.origin.x > 0) {
        
        //显示左侧视图
        _leftView.hidden = NO;
        _rightView.hidden = YES;
    }
    else {
        
        //显示右侧视图
        _rightView.hidden = NO;
        _leftView.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
