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
    dispatch_queue_t queue;
}

- (IBAction)shortEvent {
    dispatch_async(queue, ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"-------------");
            YYImage *image = [YYImage imageNamed:@"2.png"];
            _imageView.image = image;
            NSLog(@"short");
        });
        sleep(5);
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"-------------");
            _imageView.image = nil;
        });
    });
}

- (IBAction)longEvent {
    dispatch_async(queue, ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"-------------");
            YYImage *image = [YYImage imageNamed:@"Gift.gif"];
            _imageView.image = image;
            NSLog(@"short");
        });
        sleep(3);
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"-------------");
            _imageView.image = nil;
        });
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"-------------");
    queue = dispatch_queue_create("com.dispatch.serial", DISPATCH_QUEUE_SERIAL);
}


@end
