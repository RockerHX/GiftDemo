//
//  HXCountAnimationViewController.m
//  GifDemo
//
//  Created by miaios on 16/5/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXCountAnimationViewController.h"


@interface HXCountAnimationViewController ()
@end

@implementation HXCountAnimationViewController {
    dispatch_group_t _group;
    dispatch_queue_t _queue;
    dispatch_semaphore_t _semaphore;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"------ Count Animation -------");
    _group = dispatch_group_create();
    _queue = dispatch_queue_create("com.gift.count_animation", DISPATCH_QUEUE_SERIAL);
    _semaphore = dispatch_semaphore_create(1);
    
    for (NSInteger index = 0; index < 10; index++) {
        dispatch_group_async(_group, _queue, ^{
            dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
            dispatch_sync(dispatch_get_main_queue(), ^{
                _countLabel.text = @(index).stringValue;
                _labelContainer.transform = CGAffineTransformMakeScale(0.2f, 0.2f);
                [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    _labelContainer.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
                } completion:^(BOOL finished) {
                    _labelContainer.transform = CGAffineTransformIdentity;
                    dispatch_semaphore_signal(_semaphore);
                }];
            });
        });
    }
    
    dispatch_group_notify(_group, dispatch_get_main_queue(), ^{
        NSLog(@"finish!");
    });
}

@end
