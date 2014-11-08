// GSStatusBar.m
//
// Copyright (c) 2014 Gard Sandholt
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "GSStatusBar.h"

@interface GSStatusBar ()

@property(nonatomic, strong) UIWindow *containerWindow;
@property(nonatomic, strong) UIActivityIndicatorView *spinnerView;
@property(nonatomic, strong) UILabel *textLabel;

+ (GSStatusBar *)sharedView;

- (void)show;
- (void)hide;

- (BOOL)hidden;

- (void)setMessage:(NSString *)message;
- (void)setMessage:(NSString *)message animated:(BOOL)animated;

@end


static CGFloat const kLabelFontSize = 13.f;

@implementation GSStatusBar


+ (GSStatusBar *)sharedView {
    static GSStatusBar *sharedView;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedView = [[GSStatusBar alloc] initWithFrame:CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, 20.f)];
    });
    
    return sharedView;
}

+ (void)show {
    [[GSStatusBar currentBar] setMessage:NSLocalizedString(@"Loading", nil) animated:NO];
    [[GSStatusBar sharedView] show];
}

+ (void)setMessage:(NSString *)message {
    [[GSStatusBar currentBar] setMessage:message];
}

+ (void)setMessage:(NSString *)message animated:(BOOL)animated {
    [[GSStatusBar currentBar] setMessage:message animated:animated];
}

+ (GSStatusBar *)currentBar {
    if (![[GSStatusBar sharedView] superview]) {
        return nil;
    }

    return [GSStatusBar sharedView];
}

+ (BOOL)isVisible {
    return ![[GSStatusBar sharedView] hidden];
}

+ (void)hide {
    [[GSStatusBar sharedView] hide];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithWhite:.978f alpha:1.f];
        
        NSString *loadingString = NSLocalizedString(@"Loading", nil);
        
        self.spinnerView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _spinnerView.transform = CGAffineTransformMakeScale(0.77, 0.77);
        _spinnerView.hidesWhenStopped = YES;
        [_spinnerView startAnimating];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.alpha = 0.95;
        
        [self setMessage:loadingString animated:NO];
        
        [self addSubview:_textLabel];
        [self addSubview:_spinnerView];
    }
    return self;
}

- (void)setMessage:(NSString *)message {
    [self setMessage:message animated:YES];
}

- (void)setMessage:(NSString *)message animated:(BOOL)animated {
    
    UIFont *fontToUse = [UIFont boldSystemFontOfSize:kLabelFontSize];
    CGSize size = [message sizeWithAttributes:@{NSFontAttributeName:fontToUse}];
    
    CGFloat labelX = ((self.frame.size.width/2.f)-(size.width/2.f))+14.f;
    CGFloat spinnerX = labelX - 22.f;
    
    self.textLabel.font = fontToUse;
    
    [UIView animateWithDuration:(animated ? 0.2 : 0.0) animations:^{
        self.spinnerView.frame = CGRectMake(spinnerX, 0.f, 20.f, 20.f);
        self.textLabel.frame = CGRectMake(labelX, 0.f, size.width, 20.f);
        self.textLabel.text = message;
    }];
}

- (void)show {
    
    if (!self.superview) {
        [self.containerWindow addSubview:self];
    }
    [self resetFrame];
    
    self.containerWindow.hidden = NO;

    [UIView animateWithDuration:0.4 animations:^{
        CGRect containerWindowFrame = self.containerWindow.frame;
        containerWindowFrame.origin.y += 20.f;
        self.containerWindow.frame = containerWindowFrame;
    }];
    
}

- (void)hide {
    
    [UIView animateWithDuration:0.4 animations:^{
        CGRect containerWindowFrame = self.containerWindow.frame;
        containerWindowFrame.origin.y -= 20.f;
        self.containerWindow.frame = containerWindowFrame;
    } completion:^(BOOL finished) {
        self.containerWindow.hidden = YES;
        [self.containerWindow removeFromSuperview];
    }];
    
}

- (BOOL)hidden {
    return self.containerWindow.isHidden;
}

- (void)resetFrame {
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    statusBarFrame.origin.y -= 20.f;
    self.containerWindow.frame = statusBarFrame;
}

- (UIWindow *)containerWindow {
    if (!_containerWindow) {
        CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
        statusBarFrame.origin.y -= 20.f;

        _containerWindow = [[UIWindow alloc] initWithFrame:statusBarFrame];
        _containerWindow.windowLevel = UIWindowLevelStatusBar+1.0f;

        _containerWindow.alpha = 1.f;
    }

    return _containerWindow;
}


@end
