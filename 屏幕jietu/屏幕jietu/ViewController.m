//
//  ViewController.m
//  屏幕jietu
//
//  Created by lihonggui on 2016/12/8.
//  Copyright © 2016年 lihonggui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)jiietuButton:(UIButton *)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        //开启图形上下文
        CGSize size = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        //获取图形上下文
        CGContextRef context = UIGraphicsGetCurrentContext();
        //屏幕的view绘制到图形上下文中
        [self.view.layer renderInContext:context];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
