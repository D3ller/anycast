//
//  ResultItemView.m
//  anycast
//
//  Created by d3ller on 23/11/2026.
//

#import "ResultItem.h"

@implementation ResultItemView

- (instancetype)initWithFrame:(NSRect)frameRect name:(nonnull NSString *)name icon:(NSImage*)icon {
    self = [super initWithFrame:frameRect];
    if(self) {
        NSButton *button = [NSButton buttonWithTitle:@"" target:self action:@selector(clicked:)];
        
        NSImageView *imageView = [[NSImageView alloc] init];
        imageView.image = icon;
        [imageView.widthAnchor constraintEqualToConstant:iconSize].active = YES;
        [imageView.heightAnchor constraintEqualToConstant:iconSize].active = YES;
        
        NSTextField *textField = [NSTextField labelWithAttributedString:[[NSAttributedString alloc] initWithString:name attributes:@{
            NSFontAttributeName: [NSFont systemFontOfSize:13],
            NSForegroundColorAttributeName: [NSColor colorWithWhite:1 alpha:0.85]
        }]];
        textField.lineBreakMode = NSLineBreakByTruncatingTail;
        
        NSStackView *stack = [NSStackView stackViewWithViews:@[imageView, textField]];
        stack.spacing = 12;
        stack.alignment = NSLayoutAttributeCenterY;
        stack.edgeInsets = NSEdgeInsetsMake(0, 8, 0, 12);
        stack.frame = self.bounds;

        button.alignment = NSTextAlignmentLeft;
        
        button.frame = self.bounds;
        button.bordered = NO;
        button.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        
        [self addSubview:stack];
        [self addSubview:button];
    }
    return self;
}


- (void)clicked:(id)sender {
    if(self.onClick) {
        self.onClick();
    }
}
@end
