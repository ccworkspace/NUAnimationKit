//
//  NUChainAnimationsViewController.m
//  NUAnimationKit
//
//  Created by Victor on 01/22/2016.
//  Copyright (c) 2016 Victor. All rights reserved.
//

#import "NUChainAnimationsViewController.h"
#import "NUAnimationController.h"

@interface NUChainAnimationsViewController ()
@property (nonatomic, strong) UILabel *completionLabel;
@end

@implementation NUChainAnimationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *animationView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    animationView1.backgroundColor = [UIColor redColor];
    
    UIView *animationView2= [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    animationView2.backgroundColor = [UIColor greenColor];
    
    UIView *animationView3 = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    animationView3.backgroundColor = [UIColor blueColor];
    
    self.completionLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 300, 300, 20)];
    self.completionLabel.text = @"Not started";
    
    UILabel *progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, 300, 20)];
    progressLabel.text = [NSString stringWithFormat:@"%f", 0.0f];
    
    [self.view addSubview:animationView1];
    [self.view addSubview:animationView2];
    [self.view addSubview:animationView3];
    [self.view addSubview:self.completionLabel];
    [self.view addSubview:progressLabel];
    
    [self.controller addAnimation:^{
        [animationView1 setFrameY:400];
        animationView1.backgroundColor = [UIColor grayColor];
    }].withAnimationOption(UIViewAnimationOptionTransitionCrossDissolve)
    .andThen(^{
        self.completionLabel.text = @"Working on it";
    });
    
    [self.controller addAnimation:^{
        [animationView2 setFrameY:400];
    }].withDelay(0.1).withDuration(0.3).withCurve(UIViewAnimationCurveEaseInOut);
    
    [self.controller addAnimation:^{
        [animationView3 setFrameY:400];
    }].withType(NUAnimationTypeSpringy).withDuration(NUSpringAnimationNaturalDuration).
    alongSideBlock(^(CGFloat progress){
        progressLabel.text = [NSString stringWithFormat:@"%f", progress];
    });
    
}

- (void)startAnimation {
    [self.controller startAnimationChainWithCompletionBlock:^{
        self.completionLabel.text = @"All done";
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end