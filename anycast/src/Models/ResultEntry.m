//
//  ResultEntry.m
//  anycast
//
//  Created by Corentin on 24/11/2026.
//

#import "ResultEntry.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ResultEntry



- (nonnull NSString *)kindLabel {
    NSString *label;
    
    switch (_kind) {
        case ResultKindApplication:
            label = NSLocalizedString(@"result.kind.application.label", nil);
            break;
        case ResultKindCommand:
            label = NSLocalizedString(@"result.kind.command.label", nil);
            break;
        case ResultKindExtension:
            label = NSLocalizedString(@"result.kind.extension.label", nil);
            break;
    }
    
    return label;
}

- (nonnull NSString *)primaryActionTitle {
    NSString *action;
    
    switch (_kind) {
        case ResultKindApplication:
            action = NSLocalizedString(@"result.kind.application.action", nil);
            break;
        case ResultKindCommand:
            action = NSLocalizedString(@"result.kind.command.action", nil);
            break;
        case ResultKindExtension:
            action = NSLocalizedString(@"result.kind.extension.action", nil);
            break;
    }
    
    return action;
}

- (nonnull instancetype)initWithName:(nonnull NSString *)name icon:(nullable NSImage *)icon kind:(ResultKind)kind perform:(nonnull void (^)(void))perform {
    self = [super init];
    if(self) {
        _name = [name copy];
        _icon = icon;
        _kind = kind;
        _perform = perform;
    }
    
    return self;
}

@end

NS_ASSUME_NONNULL_END
