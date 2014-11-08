//
//  ViewController.m
//  GSStatusBarExampleApp
//
//  Created by Gard Sandholt on 14/02/14.
//  Copyright (c) 2014 GaSa Media. All rights reserved.
//

#import "ViewController.h"
#import "GSStatusBar.h"

@interface ViewController ()

@end

@implementation ViewController


- (IBAction)showButtonPressed:(id)sender {
    
    UIButton *showBtn = (UIButton *)sender;
    
    if ([GSStatusBar isVisible]) {
        [GSStatusBar hide];
        [showBtn setTitle:@"Show" forState:UIControlStateNormal];
        return;
    }

    [GSStatusBar show];
    [showBtn setTitle:@"Hide" forState:UIControlStateNormal];
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [GSStatusBar setMessage:@"Waiting..." animated:NO];
    });
}

- (IBAction)hideButtonPressed:(id)sender {
    [GSStatusBar hide];
}

@end
