//
//  ViewController.m
//  Attributer
//
//  Created by Justin Singh on 7/28/24.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *bodyText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) usePreferredFonts {
    self.bodyText.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (void) preferredFontsChanged:(NSNotification *) notification {
    [self usePreferredFonts];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self usePreferredFonts];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFontsChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name: UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void) setSelectedBodyTextColor:(UIColor *)textColor {
    if (!textColor || self.bodyText.selectedRange.length == 0) return;
    
    [self.bodyText.textStorage addAttribute:NSForegroundColorAttributeName
                                      value:textColor
                                      range:self.bodyText.selectedRange];
}

- (void) setSelectedBodyTextOutline {
    if(self.bodyText.selectedRange.length == 0) return;
    
    [self.bodyText.textStorage addAttributes:@{
        NSStrokeWidthAttributeName: @-3,
        NSStrokeColorAttributeName: [UIColor blackColor]
    } range:self.bodyText.selectedRange];
}

- (void) removeSelectedBodyTextOutline {
    if(self.bodyText.selectedRange.length == 0) return;
    
    [self.bodyText.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.bodyText.selectedRange];
    
    [self.bodyText.textStorage removeAttribute:NSStrokeColorAttributeName range:self.bodyText.selectedRange];
    

}

- (IBAction)handleColorSelectionPress:(UIButton *)sender {
    [self setSelectedBodyTextColor:sender.backgroundColor];
}

- (IBAction)handleOutlinePress:(UIButton *)sender {
    [self setSelectedBodyTextOutline];
}

- (IBAction)handleUnOutlinePress:(UIButton *)sender {
    [self removeSelectedBodyTextOutline];
}

@end
