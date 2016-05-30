//
//  ViewController.m
//  GifDemo
//
//  Created by miaios on 16/5/26.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "ViewController.h"
#import "YYImage.h"


@interface ViewController ()
@end


@implementation ViewController {
    dispatch_queue_t _queue;
    dispatch_semaphore_t _semaphore;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"-------------");
    _queue = dispatch_queue_create("com.gift.dynamic_animation", DISPATCH_QUEUE_SERIAL);
    _semaphore = dispatch_semaphore_create(1);
}

- (IBAction)shortEvent {
    dispatch_async(_queue, ^{
        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"-------------");
            NSLog(@"Short Start");
            _imageView.alpha = 1.0f;
            YYImage *image = [YYImage imageNamed:@"Gift.gif"];
            _imageView.image = image;
            
            [UIView animateWithDuration:0.5f delay:3.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
                NSLog(@"-------------");
                NSLog(@"Animation");
                _imageView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                NSLog(@"-------------");
                NSLog(@"End");
                _imageView.image = nil;
                dispatch_semaphore_signal(_semaphore);
            }];
        });
    });
}

- (IBAction)longEvent {
    dispatch_async(_queue, ^{
        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"-------------");
            NSLog(@"Long Start");
            _imageView.alpha = 1.0f;
            YYImage *image = [YYImage imageNamed:@"2.png"];
            _imageView.image = image;
            
            [UIView animateWithDuration:0.5f delay:5.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
                NSLog(@"-------------");
                NSLog(@"Animation");
                _imageView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                NSLog(@"-------------");
                NSLog(@"End");
                _imageView.image = nil;
                dispatch_semaphore_signal(_semaphore);
            }];
        });
    });
}

@end
