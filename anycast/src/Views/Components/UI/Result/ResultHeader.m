//
//  ResultSectionView.m
//  anycast
//
//  Created by Corentin on 25/11/2026.
//

#import "ResultHeader.h"
#import "Theme.h"

@implementation ResultHeader

- (instancetype)initWithTitle:(NSString *)title frame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if(self){
        _title = [title copy];
        
        NSTextField *textField = [NSTextField labelWithString:title];
        NSColor *color = [NSColor colorWithWhite:1 alpha:0.6];
        NSFont *font = [NSFont systemFontOfSize:11 weight:NSFontWeightMedium];
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        
        textField.textColor = color;
        textField.font = font;
        
        [self addSubview:textField];
        
        [textField.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:padding].active = YES;
        [textField.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    }
    
    return self;
}

@end
