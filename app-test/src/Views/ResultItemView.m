//
//  ResultItemView.m
//  anycast
//
//  Created by d3ller on 23/11/2026.
//

#import "ResultItemView.h"

@implementation ResultItemView

- (instancetype)initWithFrame:(NSRect)frameRect name:(nonnull NSString *)name {
    self = [super initWithFrame:frameRect];
    if(self) {
        NSButton *button = [NSButton buttonWithTitle:name target:self action:@selector(clicked:)];
        
        button.attributedTitle = [[NSAttributedString alloc] initWithString:name attributes:@{
            NSFontAttributeName: [NSFont systemFontOfSize:13],
            NSForegroundColorAttributeName: [NSColor whiteColor]
        }];
        
        button.alignment = NSTextAlignmentLeft;
        
        button.frame = self.bounds;
        button.bordered = NO;
        button.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        
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
