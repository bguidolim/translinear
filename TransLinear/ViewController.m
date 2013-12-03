//
//  ViewController.m
//  TransLinear
//
//  Created by Bruno Guidolim on 11/20/13.
//  Copyright (c) 2013 Amithiva Mobile. All rights reserved.
//

#import "ViewController.h"

#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    _isReflected = NO;
    _isExpanded = NO;
    _isExpandedX = NO;
    _isExpandedY = NO;
    _isSheared = NO;
}

-(void)viewWillAppear:(BOOL)animated {
    _frameOriginal = _objeto.frame;
    _transformOriginal = _objeto.transform;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnReflexaoTapped:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];
    if (!_isReflected) {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:_objeto cache:YES];
        _isReflected = YES;
    } else {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:_objeto cache:YES];
        _isReflected = NO;
    }
    
    CGRect frame = _objeto.frame;
    frame.origin.x = 1024 - frame.origin.x - frame.size.width;
    [_objeto setFrame:frame];
    
    UIGraphicsBeginImageContextWithOptions(_objeto.bounds.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, -1.0, 1.0);
    CGContextTranslateCTM(context, -_objeto.bounds.size.width, 0.0);
    
    [_objeto.layer renderInContext:context];
    _objeto.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [UIView commitAnimations];
}

- (IBAction)btnTranslacaoTapped:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];

    CGRect frame = _objeto.frame;
    frame.origin.x = 1024 - frame.origin.x - frame.size.width;
    [_objeto setFrame:frame];
    
    [UIView commitAnimations];
}

- (IBAction)btnRotacaoPontoTapped:(id)sender {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, nil, 513, 391, 260, DEGREES_TO_RADIANS(180.0), DEGREES_TO_RADIANS(0.0), YES);

    CAKeyframeAnimation *animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    CGPathRelease(path);
    
    animation.duration = 1.5;
    animation.removedOnCompletion = NO;
    animation.autoreverses = YES;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.fillMode = kCAFillModeBackwards;
    
    [_objeto.layer addAnimation:animation forKey:@"position"];
}

-(IBAction)btnRotacaoZTapped:(id)sender {
     CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
     animation.fromValue = @0.0f;
     animation.toValue = @(2*M_PI);
     animation.duration = 0.75;
     [_objeto.layer addAnimation:animation forKey:@"rotation"];
}

- (IBAction)btnDilatContrTapped:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];
    
    CGRect frame = _objeto.frame;
    
    _objeto.contentMode = UIViewContentModeScaleToFill;
    if (!_isExpanded) {
        frame.size.width += 200;
        frame.size.height += 200;
        _isExpanded = YES;
    } else {
        frame.size.width -= 200;
        frame.size.height -= 200;
        _isExpanded = NO;
    }
    
    [_objeto setFrame:frame];
    
    [UIView commitAnimations];
    _objeto.contentMode = UIViewContentModeScaleAspectFit;
}

-(IBAction)btnCisalhamentoTapped:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];
    
    if (!_isSheared) {
        _objeto.transform = CGAffineTransformConcat(_objeto.transform, CGAffineTransformMake(1.0, 0.0, -1.0, 1.0, 0.0, 0.0));
        _isSheared = YES;
    } else {
        _objeto.transform = CGAffineTransformConcat(_objeto.transform, CGAffineTransformMake(1.0, 0.0, 1.0, 1.0, 0.0, 0.0));
        _isSheared = NO;
    }
    
    [UIView commitAnimations];
}

- (IBAction)btnDilatContrXTapped:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];
    
    CGRect frame = _objeto.frame;
    
    _objeto.contentMode = UIViewContentModeScaleToFill;
    if (!_isExpandedX) {
        frame.size.width += 300;
        _isExpandedX = YES;
    } else {
        frame.size.width -= 300;
        _isExpandedX = NO;
    }
    
    [_objeto setFrame:frame];
    
    [UIView commitAnimations];
}

- (IBAction)btnDilatContrYTapped:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];
    
    CGRect frame = _objeto.frame;
    
    _objeto.contentMode = UIViewContentModeScaleToFill;
    if (!_isExpandedY) {
        frame.size.height += 300;
        _isExpandedY = YES;
    } else {
        frame.size.height -= 300;
        _isExpandedY = NO;
    }
    
    [_objeto setFrame:frame];
    
    [UIView commitAnimations];
}

- (IBAction)btnResetTapped:(id)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];
    
    [_objeto setFrame:_frameOriginal];
    [_objeto setTransform:_transformOriginal];
    [_objeto setImage:[UIImage imageNamed:@"Helicoptero"]];
    
    [UIView commitAnimations];
}

@end
