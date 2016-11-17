//
//  DYWatchLoadingAnimate.h
//  DYWatchLoadingAnimate
//
//  Created by daiyi on 2016/11/17.
//  Copyright © 2016年 DY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface DYWatchLoadingAnimate : NSObject

/** 是否正在动画中 */
@property (nonatomic, assign, readonly, getter=isAnimating) BOOL animating;

/*! @brief 实例化一个动画
 *
 * @param interfaceController 动画所在IC
 * @param roundArr 三个动画圆点组，分别为中上、左下、右下
 * @return 动画实例
 */
- (instancetype)initWithInterfaceController:(WKInterfaceController *)interfaceController roundArr:(NSArray<WKInterfaceGroup *> *)roundArr;

/*! @brief 开始动画
 *
 */
- (void)startAnimate;

/*! @brief 停止动画
 *
 */
- (void)stopAnimate;

/*! @brief 暂停动画
 *
 */
- (void)pauseAnimate;

@end
