//
//  KeyCap.m
//  anycast
//
//  Created by d3ller on 23/11/2026.
//

#import "KeyCap.h"
#define KEYCAP_SIZE 18

@implementation KeyCap

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if(self) {
        [self addRadiusAndBorder];
    }
    return self;
}

- (instancetype)initWithText:(NSString *)text {
    self = [self initWithFrame:NSMakeRect(0, 0, KEYCAP_SIZE, KEYCAP_SIZE)];
    if (self) {
        
        NSTextField *field = [NSTextField labelWithString:text];
        field.font = [NSFont systemFontOfSize:12 weight:NSFontWeightMedium];
        
        NSSize s = field.intrinsicContentSize;
        field.frame = NSMakeRect((18 - s.width) / 2, (18 - s.height) / 2, s.width, s.height);
        
        [self addSubview:field];
    }
    
    return self;
}

- (instancetype)initWithSymbol:(NSString *)symbol {
    self = [self initWithFrame:NSMakeRect(0, 0, KEYCAP_SIZE, KEYCAP_SIZE)];
    if(self) {
        NSImage *img = [NSImage imageWithSystemSymbolName:symbol accessibilityDescription:nil];
    }
    
    return self;
}

- (void)addRadiusAndBorder {
    self.wantsLayer = YES;
    self.layer.cornerRadius = 6;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [NSColor colorWithWhite:1 alpha:0.25].CGColor;
}

@end
