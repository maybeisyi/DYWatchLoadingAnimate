# DYWatchLoadingAnimate
### Apple Watch上的一款原生加载动画，简单接入即可使用。并非images帧动画~  

## DEMO效果：  
![我是配图](http://ww4.sinaimg.cn/mw690/006fcg2Wgw1f9vipbtbjrg304805w0wo.gif) 

## 使用：  
1. 在需要使用的InterfaceController中导入`#import "DYWatchLoadingAnimate.h"`  

2. 在对应storyboard中，放入一个长高相等的group，居中。就像这样：

   ![我是配图](http://ww2.sinaimg.cn/mw690/006fcg2Wgw1f9vhspzs12j30ay0cwdg2.jpg)   

   ![我是配图](http://ww3.sinaimg.cn/mw690/006fcg2Wgw1f9vhsr00vrj30eq0b4my2.jpg)   


3. 在这个group中放入3个小group，并设置圆角为长宽的一半，然后就是个球了。摆放位置也就是Alignment依次为：(center、top)、(left、bottom)、(right、bottom)。最后看起来是这样：![我是配图](http://ww3.sinaimg.cn/mw690/006fcg2Wgw1f9vhwbuom2j30ak0ckt8y.jpg)  

这个就是我们动画时候要动起来的几个东西。  

4. 依次连线到你需要的InterfaceController。  
5. 创建动画：

```
DYWatchLoadingAnimate *loadingAnimate = [[DYWatchLoadingAnimate alloc] initWithInterfaceController:self roundArr:@[_blueGroup, _redGroup, _greenGroup]];
```

6. 开始动画：

```
[self.loadingAnimate startAnimate];
```

## 使用中的小问题： 
1. 结束动画后这玩意还在？  

   因为具体的动画开始和结束时和业务相关的，DEMO中没有演示。在stopAnimate后把3个group外层的这个大group隐藏即可。需要动画时放出来啊~ 


2. 还有问题的Q我475325435

## 介绍下思路： 
1. Apple Watch中对于动画的限制简直是惨无人道。害怕手表性能跟不上动画就直说嘛！最后只能用帧动画（也就是一张一张的图片逐次播放）来实现，虽然说2.0开始新增了个  

   `- (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations WK_AVAILABLE_WATCHOS_ONLY(2.0);`

   简单动画，充其量也就是位移位移，放大缩小之类的。  

   帧动画的体验真心不好，1秒30帧能看？没有对比就没有杀害，玩过iPhone再看手表帧动画，简直卡+不流畅。但是没办法，如果真心要实现自定义的一些图片动画，还是只能靠这个。  

2. 我们用的是啥？

   `- (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations WK_AVAILABLE_WATCHOS_ONLY(2.0);`

   也只能是这个了。这个动画至少60帧够流畅够丰满。

   由于手表的sb布局中，两个同层次的东西是无法叠加的，是会互相排挤的（互相推搡），借助这个特性+位移动画，还是能实现一些好玩的效果。  

3. 3个小球在每个动画周期内，依次滚动到下一个小球的位置，就形成了本DEMO中的效果~
