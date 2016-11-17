//
//  DYWatchLoadingAnimate.m
//  DYWatchLoadingAnimate
//
//  Created by daiyi on 2016/11/17.
//  Copyright © 2016年 DY. All rights reserved.
//

#import "DYWatchLoadingAnimate.h"

/** 圆点相对位置 */
typedef struct {
    WKInterfaceObjectHorizontalAlignment hPosition;
    WKInterfaceObjectVerticalAlignment vPosition;
} PositionRect;

@interface DYWatchLoadingAnimate ()

/** 动画圆点对应位置数组 */
@property (nonatomic, strong) NSMutableArray *positionArr;
/** 动画圆点数组 */
@property (nonatomic, strong) NSArray *roundGroupArr;

/** 动画圆点所在IC */
@property (nonatomic, weak) WKInterfaceController *interfaceController;
@property (nonatomic, assign, getter=isAnimating) BOOL animating;

/** 动画定时器 */
@property (nonatomic, strong) NSTimer *animateTimer;

@end

@implementation DYWatchLoadingAnimate

- (instancetype)initWithInterfaceController:(WKInterfaceController *)interfaceController roundArr:(NSArray<WKInterfaceGroup *> *)roundArr {
    if (self = [super init]) {
        self.interfaceController = interfaceController;
        self.roundGroupArr = roundArr;
        [self prepareToLoadAnimation];
    }
    return self;
}

/*! @brief 初始化圆点位置，准备加载动画
 *
 */
- (void)prepareToLoadAnimation {
    _positionArr = [NSMutableArray arrayWithCapacity:3];
    
    PositionRect positionRect1 = (PositionRect){WKInterfaceObjectHorizontalAlignmentCenter, WKInterfaceObjectVerticalAlignmentTop};
    [_positionArr addObject:[NSValue value:&positionRect1 withObjCType:@encode(PositionRect)]];
    PositionRect positionRect2 = (PositionRect){WKInterfaceObjectHorizontalAlignmentLeft, WKInterfaceObjectVerticalAlignmentBottom};
    [_positionArr addObject:[NSValue value:&positionRect2 withObjCType:@encode(PositionRect)]];
    PositionRect positionRect3 = (PositionRect){WKInterfaceObjectHorizontalAlignmentRight, WKInterfaceObjectVerticalAlignmentBottom};
    [_positionArr addObject:[NSValue value:&positionRect3 withObjCType:@encode(PositionRect)]];
}

/*! @brief 执行动画
 *
 */
- (void)loadAnimation {
    // 顺序 ： 上中 -> 右下 -> 左下 -> 上中 循环
    
    [_positionArr enumerateObjectsUsingBlock:^(NSValue *value, NSUInteger idx, BOOL * _Nonnull stop) {
        PositionRect positionRect;
        [value getValue:&positionRect];
        
        if (positionRect.hPosition == WKInterfaceObjectHorizontalAlignmentCenter
            && positionRect.vPosition == WKInterfaceObjectVerticalAlignmentTop) {
            positionRect.hPosition = WKInterfaceObjectHorizontalAlignmentRight;
            positionRect.vPosition = WKInterfaceObjectVerticalAlignmentBottom;
        }else if (positionRect.hPosition == WKInterfaceObjectHorizontalAlignmentRight
                  && positionRect.vPosition == WKInterfaceObjectVerticalAlignmentBottom) {
            positionRect.hPosition = WKInterfaceObjectHorizontalAlignmentLeft;
            positionRect.vPosition = WKInterfaceObjectVerticalAlignmentBottom;
        }else if (positionRect.hPosition == WKInterfaceObjectHorizontalAlignmentLeft
                  && positionRect.vPosition == WKInterfaceObjectVerticalAlignmentBottom) {
            positionRect.hPosition = WKInterfaceObjectHorizontalAlignmentCenter;
            positionRect.vPosition = WKInterfaceObjectVerticalAlignmentTop;
        }
        
        [_positionArr replaceObjectAtIndex:idx withObject:[NSValue value:&positionRect withObjCType:@encode(PositionRect)]];
        
        [self.interfaceController animateWithDuration:1.f animations:^{
            WKInterfaceGroup *round = self.roundGroupArr[idx];
            [round setHorizontalAlignment:positionRect.hPosition];
            [round setVerticalAlignment:positionRect.vPosition];
        }];
    }];
}

- (void)startAnimate {
    if (!_animateTimer) {
        self.animating = YES;
        _animateTimer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(loadAnimation) userInfo:nil repeats:YES];
        [_animateTimer fire];
    }
}

- (void)stopAnimate {
    if (_animateTimer) {
        self.animating = NO;
        [_animateTimer invalidate];
        _animateTimer = nil;
    }
}

- (void)pauseAnimate {
    if (_animateTimer) {
        [_animateTimer invalidate];
        _animateTimer = nil;
    }
}

@end
