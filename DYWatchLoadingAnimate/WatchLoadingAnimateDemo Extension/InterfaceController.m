//
//  InterfaceController.m
//  WatchLoadingAnimateDemo Extension
//
//  Created by daiyi on 2016/11/17.
//  Copyright © 2016年 DY. All rights reserved.
//

#import "InterfaceController.h"
#import "DYWatchLoadingAnimate.h"

@interface InterfaceController()

/** 三个group球。watch只能从sb中添加视图，所以这仨个球只能自己连线：查看Interface.storyboard */
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceGroup *blueGroup;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceGroup *redGroup;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceGroup *greenGroup;

/** 动画对象 */
@property (nonatomic, strong) DYWatchLoadingAnimate *loadingAnimate;

@end


@implementation InterfaceController

- (IBAction)startClick {
    [self.loadingAnimate startAnimate];
}

- (IBAction)stopClick {
    [self.loadingAnimate stopAnimate];
}

- (IBAction)pauseClick {
    [self.loadingAnimate pauseAnimate];
}

#pragma mark - setter/getter方法
- (DYWatchLoadingAnimate *)loadingAnimate {
    if (!_loadingAnimate) {
        _loadingAnimate = [[DYWatchLoadingAnimate alloc] initWithInterfaceController:self roundArr:@[_blueGroup, _redGroup, _greenGroup]];
    }
    return _loadingAnimate;
}

@end



