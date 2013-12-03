//
//  ViewController.h
//  TransLinear
//
//  Created by Bruno Guidolim on 11/20/13.
//  Copyright (c) 2013 Amithiva Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *objeto;
@property (assign, nonatomic) BOOL isReflected;
@property (assign, nonatomic) BOOL isExpanded;
@property (assign, nonatomic) BOOL isExpandedX;
@property (assign, nonatomic) BOOL isExpandedY;
@property (assign, nonatomic) BOOL isSheared;
@property (assign, nonatomic) CGRect frameOriginal;
@property (assign, nonatomic) CGAffineTransform transformOriginal;

- (IBAction)btnReflexaoTapped:(id)sender;
- (IBAction)btnTranslacaoTapped:(id)sender;
- (IBAction)btnRotacaoPontoTapped:(id)sender;
- (IBAction)btnRotacaoZTapped:(id)sender;
- (IBAction)btnDilatContrTapped:(id)sender;
- (IBAction)btnCisalhamentoTapped:(id)sender;
- (IBAction)btnDilatContrXTapped:(id)sender;
- (IBAction)btnDilatContrYTapped:(id)sender;
- (IBAction)btnResetTapped:(id)sender;

@end
